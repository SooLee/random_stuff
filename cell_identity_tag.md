
## The READ GROUP tag for Whole Genome Sequencing data

It is typical and standard that Whole Genome Sequencing data is stored in a BAM file with READ GROUP information using the `RG` tag for platform, lane and sample ID, to enable platform-specific quality-score calibration in the downstream analysis.

The bam header lines contain all the distinct read groups  in the file (in this case `ST-E00181_268_HJNHFCCXX_1` and  `ST-E00181_268_HJNHFCCXX_200`)

```
@RG     ID:ST-E00181_268_HJNHFCCXX_1    PL:piattaforma  PU:ST-E00181_268_HJNHFCCXX_1    LB:ST-E00181_268_HJNHFCCXX_1    SM:PIPPO
@RG     ID:ST-E00181_268_HJNHFCCXX_200  PL:piattaforma  PU:ST-E00181_268_HJNHFCCXX_200  LB:ST-E00181_268_HJNHFCCXX_200  SM:PIPPO
```

Each read in the bam file contain the `RG:Z` tag as below (`Z` means the type is string) (see the end of the line - you may need to scroll horizontally.) The `RG:Z` tag looks like `RG:Z:ST-E00181_268_HJNHFCCXX_1`.

```
ST-E00181:268:HJNHFCCXX:1:1101:18203:1485       83      chr5    177674646       60      151M    =       177674385       -412    GGCAATAGGGTGCGACCCTGTCTCAATAAAACAAAATGAAACAAAATACACAACCATTTGGTGTGTCTGACTACCTGCTTGCTGGAACACTGTCTTCTGTAGGTTTCTGTGATGCTGTGCTTCTCTCACCACTTTTTTTTTAGTCTCCTTN KAA<<AAF<7KKFKAA<FKFFAKKKKFFKKFFKAFFKKKKKKKFKAF<7FAFAAAFFKKKKKKFKKKFKKKKAFAAKAKAAFKKKKKKKKKAKKKKFFAFAKKKKKKKKKKKKKFKFFKFKKKKKKFFKF<KFKFKKKKKKKKKKKFFAA# NM:i:1  MD:Z:150A0      MC:Z:151M       AS:i:150        XS:i:122        XA:Z:chr5,+176235864,10M1I140M,6;       RG:Z:ST-E00181_268_HJNHFCCXX_1
```


The `RG` tag is reserved in the SAM specification for READ GROUP (https://samtools.github.io/hts-specs/SAMtags.pdf)


## The CELL IDENTIFIER tag for Single-cell data

We can use something similar for cell identity. Actually I found out that there is also a reserved tag for CELL IDENTIFIER (`CB` tags instead of `RG`).

So, then the bam header lines could contain the following:

```
@CB     ID:Cell_XYZ
@CB     ID:Cell_ABC
```

Each read in the bam file contain the `CB:Z` tag as below (see the end of the line - again you may need to horizontally scroll). The `CB:Z` tag looks like `CB:Z:Cell_XYZ`.

```
ST-E00181:268:HJNHFCCXX:1:1101:18203:1485       83      chr5    177674646       60      151M    =       177674385       -412    GGCAATAGGGTGCGACCCTGTCTCAATAAAACAAAATGAAACAAAATACACAACCATTTGGTGTGTCTGACTACCTGCTTGCTGGAACACTGTCTTCTGTAGGTTTCTGTGATGCTGTGCTTCTCTCACCACTTTTTTTTTAGTCTCCTTN KAA<<AAF<7KKFKAA<FKFFAKKKKFFKKFFKAFFKKKKKKKFKAF<7FAFAAAFFKKKKKKFKKKFKKKKAFAAKAKAAFKKKKKKKKKAKKKKFFAFAKKKKKKKKKKKKKFKFFKFKKKKKKFFKF<KFKFKKKKKKKKKKKFFAA# NM:i:1  MD:Z:150A0      MC:Z:151M       AS:i:150        XS:i:122        XA:Z:chr5,+176235864,10M1I140M,6;       CB:Z:Cell_XYZ
```

This information could be then saved in a custom cell_identity column in the PAIRS file.

The following link describes how cell-specific barcodes are stored in the CB field in the 10x genomics bam files.
https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/output/bam

