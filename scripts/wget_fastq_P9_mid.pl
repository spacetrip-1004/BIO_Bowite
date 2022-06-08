#!/usr/bin/perl

my $fn_file_list = $ARGV[0];
open(FN_FILE_LIST, $fn_file_list) or die $!;

my $fn_file_out = join(".", "wget_fastq_P9_mid", "sh");
open(FN_FILE_OUT, ">$fn_file_out") or die $!;

my $i = 1;
foreach my $line (<FN_FILE_LIST>) {
        chomp $line;
        my @list = split("\t", $line);
        print "input file $i: $line\n";

        my $ID = $list[0];
        my $sub_name_srr = substr($list[0], 0, 6);
        my $sub_name_num = substr($list[0], -1);

        my $command_line0 = "wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/$sub_name_srr/00$sub_name_num/$ID/$ID" . "_1.fastq.gz\n";
        my $command_line1 = "wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/$sub_name_srr/00$sub_name_num/$ID/$ID" . "_2.fastq.gz\n";

        print FN_FILE_OUT $command_line0;
        print FN_FILE_OUT $command_line1;

        $i++;
}
close(FN_FILE_OUT);
close (FN_FILE_LIST);
