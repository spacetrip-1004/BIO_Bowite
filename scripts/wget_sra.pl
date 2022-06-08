#!/usr/bin/perl
#
my $fn_file_list = $ARGV[0];

open(FN_FILE_LIST, $fn_file_list) or die $!;

my $fn_file_out = join(".", "wget_sra", "sh");
open(FN_FILE_OUT, ">$fn_file_out") or die $!;

my $i = 1;
foreach my $line (<FN_FILE_LIST>) {
        chomp $line;
        my @list = split("\t", $line);
        print "input file $i: $line\n";

        my $ID = $list[0];

        my $command_line0 = "wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/$ID/$ID.1\n";

        print FN_FILE_OUT $command_line0;
        $i++;
}
close(FN_FILE_OUT);
close (FN_FILE_LIST);
