## Confirmation for some QC metrics for ENCODE ATAC-seq pipeline (Aln-only)

I'm trying to confirm some qc metrics in the ATACseq QC output from the Aln-only step.
I will try to confirm the following, by actually comparing the bam file with the qc stat from a small test run.

* Numbers reported in the flagstat report are numbers of 'alignments' not the numbers of 'reads' (We do not want to use them as selected metrics).
* Numbers reported in dedup QC and PCB QC (aka Library Complexity) are numbers of 'reads' (We may be able to use them to report some numbers of reads).
* According to Daniel, the 'total read' value from PBC QC is the 'unfiltered, undeduped number of mapped reads minus chrM'. But I see that this is not correct. That number is actually the 'filtered but undeduped number of mapped reads minus chrM'.
* The 'paired end' value from dedup QC is also 'filtered but undeduped number of mapped reads'.

From the atac-seq-pipeline code, the following is the filtering step.
* `merged_bam` (bowtie2 output) --> Filtering -->  `filt_bam` --> `Markdup/dedup_qc` --> `dup_mark_bam` --> `PBC_QC`
where Filtering removes the following:
* unmapped reads, reads whose mate is unmapped, vendor qc check failed(?), multimappers

* The starting number for the dedupqc is the number of Filtered reads.
* The starting number for the PBC QC is the number of dup_mark_bam (most likely same as the number in `filt_bam`) minus chrM-mapped reads.

* The value for 'paired_end' (starting number) - duped reads or 'paired_end' * (1 - dup%) matches the number of reads in the final deduped bam file.
* None of the values for `total_reads` in PBC QC, however, matches the number of reads in the final deduped bam file - chrM.

### Summary
Conclusively, we can report dup% and either `paired_end` (starting number) as Filtered but undeduped reads or 'paired_end' * (1 - dup%) as Filtered and deduped reads. I think the latter makes more sense. Then, we will have only two values : dup% and filtered and deduped reads. We could also report filtered and undeduped reads as 'properly paired uniquely mapped reads'.


### total mapped reads in the bowtie output bam
```
samtools view -F4 /data1/wdl/cromwell-executions/atac/b830b665-9954-4db0-9b78-52dc06df156e/call-filter/shard-0/inputs/1192198012/4DNFIIG3K5CI.h2M.trim.merged.bam |cut -f1 |sort | uniq | wc -l
```
```
994481
```

### total mapped reads in the bowtie output bam - chrM
```
samtools view -F4 /data1/wdl/cromwell-executions/atac/b830b665-9954-4db0-9b78-52dc06df156e/call-filter/shard-0/inputs/1192198012/4DNFIIG3K5CI.h2M.trim.merged.bam | grep -v chrM | cut -f1 |sort | uniq | wc -l
```
```
648390
```

### total mapped alignments in the bowtie output bam
```
samtools view -F4 /data1/wdl/cromwell-executions/atac/b830b665-9954-4db0-9b78-52dc06df156e/call-filter/shard-0/inputs/1192198012/4DNFIIG3K5CI.h2M.trim.merged.bam |wc -l
```
```
1971805
```

### total mapped alignments in the bowtie output bam - chrM
```
samtools view -F4 /data1/wdl/cromwell-executions/atac/b830b665-9954-4db0-9b78-52dc06df156e/call-filter/shard-0/inputs/1192198012/4DNFIIG3K5CI.h2M.trim.merged.bam | grep -v chrM | wc -l
```
```
1284027
```

### total mapped reads in proper pairs in the bowtie output bam
```
samtools view -F4 /data1/wdl/cromwell-executions/atac/b830b665-9954-4db0-9b78-52dc06df156e/call-filter/shard-0/inputs/1192198012/4DNFIIG3K5CI.h2M.trim.merged.bam |cut -f1 |sort | uniq | wc -l
```
```
968656
```

### total mapped reads in proper pairs in the bowtie output bam - chrM
```
samtools view -f2 /data1/wdl/cromwell-executions/atac/b830b665-9954-4db0-9b78-52dc06df156e/call-filter/shard-0/inputs/1192198012/4DNFIIG3K5CI.h2M.trim.merged.bam | grep -v chrM | cut -f1 |sort | uniq | wc -l
```
```
629527
```

### flagstat for bowtie output bam (numbers are alignments)
```
cat /data1/wdl/cromwell-executions/atac/b830b665-9954-4db0-9b78-52dc06df156e/call-bowtie2/shard-0/execution/4DNFIIG3K5CI.h2M.trim.merged.flagstat.qc
```
```
1999488 + 0 in total (QC-passed reads + QC-failed reads)
0 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
1971805 + 0 mapped (98.62%:-nan%)
1999488 + 0 paired in sequencing
999744 + 0 read1
999744 + 0 read2
1937312 + 0 properly paired (96.89%:-nan%)
1954648 + 0 with itself and mate mapped
17157 + 0 singletons (0.86%:-nan%)
10834 + 0 with mate mapped to a different chr
7540 + 0 with mate mapped to a different chr (mapQ>=5)
```

### total mapped reads in the deduped bam
```
samtools view -F4 /data1/wdl/cromwell-executions/atac/b830b665-9954-4db0-9b78-52dc06df156e/call-filter/shard-0/execution/4DNFIIG3K5CI.h2M.trim.merged.nodup.bam |cut -f1 |sort | uniq | wc -l
```
```
641638
```

### total mapped reads in the deduped bam -chrM
```
samtools view -F4 /data1/wdl/cromwell-executions/atac/b830b665-9954-4db0-9b78-52dc06df156e/call-filter/shard-0/execution/4DNFIIG3K5CI.h2M.trim.merged.nodup.bam | grep -v chrM | cut -f1 |sort | uniq | wc -l
```
```
510527
```

### total mapped reads in proper pairs in the deduped bam - chrM
```
samtools view -f2 /data1/wdl/cromwell-executions/atac/b830b665-9954-4db0-9b78-52dc06df156e/call-filter/shard-0/execution/4DNFIIG3K5CI.h2M.trim.merged.nodup.bam |cut -f1 |sort | uniq | wc -l
```
```
641638
```

### total mapped reads in proper pairs in the deduped bam - chrM
```
samtools view -f2 /data1/wdl/cromwell-executions/atac/b830b665-9954-4db0-9b78-52dc06df156e/call-filter/shard-0/execution/4DNFIIG3K5CI.h2M.trim.merged.nodup.bam | grep -v chrM | cut -f1 |sort | uniq | wc -l
```
```
510527
```

### dedup qc
```
cat /data1/wdl/cromwell-executions/atac/b830b665-9954-4db0-9b78-52dc06df156e/call-filter/shard-0/execution/4DNFIIG3K5CI.h2M.trim.merged.dup.qc
```
```
## METRICS CLASS	picard.sam.DuplicationMetrics
LIBRARY	UNPAIRED_READS_EXAMINED	READ_PAIRS_EXAMINED	SECONDARY_OR_SUPPLEMENTARY_RDS	UNMAPPED_READS	UNPAIRED_READ_DUPLICATES	READ_PAIR_DUPLICATES	READ_PAIR_OPTICAL_DUPLICATES	PERCENT_DUPLICATION	ESTIMATED_LIBRARY_SIZE
Unknown Library	0	735100	0	0	0	93462	180	0.127142	2644485
```

* 735100 - 93462 = 641638 (matches the final number of reads in deduped bam)
* 93462 / 735100 = 0.127142 (matches dup rate)

* 735100? This number is smaller than 968656 (total mapped reads in proper pairs in the bowtie output bam). This confirms that this number is for filtered reads. (filtering unmapped, mate unmapped + multimapper)

### pbc_qc (library complexity)
```
cat /data1/wdl/cromwell-executions/atac/b830b665-9954-4db0-9b78-52dc06df156e/call-filter/shard-0/execution/4DNFIIG3K5CI.h2M.trim.merged.dupmark.pbc.qc
```
```
515308	510875	506541	4292	0.991397	0.991517	118.019804
```

* 515308 : This number is smaller than 629527 (total mapped reads in proper pairs in the bowtie output bam - chrM) but slightly larger than 510527 (total mapped reads in proper pairs in the deduped bam - chrM). This confirms that this number is also for filtered reads (-chrM) ((filtering unmapped, mate unmapped + multimapper).

* However, the final number 510527 (total mapped reads in proper pairs in the deduped bam - chrM) is not in the report. It also does not match 515308 * 0.991397 (NRF) = 510155.


