#!/usr/bin/perl
use strict;
use warnings;
use 5.010;
use List::MoreUtils qw(first_index);

my $file="tutorial";
my $que="normal";
my $select=1;
my $ncpus=68;
my $mpiprocs=68;
my $walltime="48:00:00";
my $email=" ";

my @commandline = @ARGV;
$file = $commandline[0];

open(my $fh_c, '>', "${file}.c");
print $fh_c <<"EOL";
#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
int main(int argc, char* argv) {
MPI_Init(&argc, &argv);
int thread_num;
MPI_Comm_rank(MPI_COMM_WORLD, &thread_num);
EOL

my $i=0;
open my $in, "<:encoding(utf8)", ${file} or die "${file}: $!";
while (my $line = <$in>){$i=$i+1;}
close $in;
say $fh_c "char *command[$i];";

$i=0;
open $in, "<:encoding(utf8)", ${file} or die "${file}: $!";
while (my $line = <$in>){
chomp $line;
print $fh_c "command[$i]=";
say $fh_c '"', $line, '";';
$i=$i+1;
}
close $in;

print $fh_c <<"EOL";
system(command[thread_num]);
MPI_Barrier(MPI_COMM_WORLD);
MPI_Finalize();
}
EOL
close $fh_c;

system("mpiicc -xMIC-AVX512 ${file}.c -o ${file}.exe");

if($i < $mpiprocs){$mpiprocs = $i;}
if((first_index { $_ eq '-q' } @commandline) > -1){$que = $commandline[1+first_index { $_ eq '-q' } @commandline];}
if((first_index { $_ eq '-n' } @commandline) > -1){$select = $commandline[1+first_index { $_ eq '-n' } @commandline];}
if((first_index { $_ eq '-p' } @commandline) > -1){$mpiprocs = $commandline[1+first_index { $_ eq '-p' } @commandline];}
if((first_index { $_ eq '-t' } @commandline) > -1){$ncpus = $commandline[1+first_index { $_ eq '-t' } @commandline];}
if((first_index { $_ eq '-wt' } @commandline) > -1){$walltime = $commandline[1+first_index { $_ eq '-wt' } @commandline];}
if((first_index { $_ eq '-e' } @commandline) > -1){$email = $commandline[1+first_index { $_ eq '-e' } @commandline];}

open(my $fh_pbs, '>', "${file}.pbs");
print $fh_pbs <<"EOL";
#!/bin/sh
#PBS -N ${file}
#PBS -V
#PBS -q $que
#PBS -A etc
#PBS -l select=$select:ncpus=$ncpus:mpiprocs=$mpiprocs
#PBS -l walltime=$walltime
EOL

say $fh_pbs 'cd $PBS_O_WORKDIR';
say $fh_pbs "mpirun ./${file}.exe";
close $fh_pbs;

if($email eq " "){
system("qsub ${file}.pbs");
}else{
system("qsub -m abe -M $email ${file}.pbs");
}