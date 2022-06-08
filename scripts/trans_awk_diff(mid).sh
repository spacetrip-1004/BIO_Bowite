#!/bin/sh

SRR_DIR='/scratch/e1412a01/P9/mid_data/SRR'$1
SRR_RSEM_DIR='/scratch/e1412a01/P9/rsem_mid'
ENA_DIR='/scratch/e1412a01/P9/ENA_P9_mid_data/SRR'$1
ENA_RSEM_DIR='/scratch/e1412a01/P9/ENA_P9_rsem_mid'

SRR='SRR'$1

#STARTTIME=$(date +%s)
#cat ${SRR_DIR}.fastq | awk '{
#if ( /^@/  ) print "@"$2; else print $0; }' | tr '/' '_' > ${SRR_DIR}.1_1.fastq
#cat ${SRR_DIR}.1_1.fastq | sed -n '1~4s/^@/>/p;2~4p' > ${SRR_DIR}.1.fasta

diff -q ${SRR_DIR}.1.fasta ${ENA_DIR}.1.fasta
diff -q ${SRR_RESM_DIR}/rsem_${SRR}/${SRR}.rsem.genes.results ${ENA_RSEM_DIR}/rsem_${SRR}/${SRR}.rsem.genes.results

#NOWDATE=`date`
#ENDTIME=$(date +%s)
#echo "$NOWDATE  ${SRR} trans_awk finished : $(($ENDTIME - $STARTTIME)) seconds "