#!/bin/sh

du -sh /scratch/x2304a03/P11/pre_data/*.1 > du_sra_P11.txt
du -sh /scratch/x2304a03/P11/post_data/*.1 >> du_sra_P11.txt
du -sh /scratch/x2304a03/P12/pre_data/*.1 > du_sra_P12.txt
du -sh /scratch/x2304a03/P12/mid_data/*.1 >> du_sra_P12.txt
du -sh /scratch/x2304a03/P14/pre_data/*.1 > du_sra_P14.txt
du -sh /scratch/x2304a03/P14/post_data/*.1 >> du_sra_P14.txt
du -sh /scratch/x2304a03/P15/P15_pre_data/*.1 > du_sra_P15.txt
du -sh /scratch/x2304a03/P15/P15_mid_data/*.1 >> du_sra_P15.txt
