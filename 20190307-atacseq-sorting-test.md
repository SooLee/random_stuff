# Test of Atac-seq post-aln step

## Goal

We noticed that the first step of ATAC-seq/ChIP-seq creates a tagAlign file that is 1) unsorted but two mates clustered for PE, 2) sorted 1,10,11 for mouse SE, 3) sorted 1,2,3 for human SE. The post-aln step sorts the final bedgraph file 1,10,11, regardless of species.

The goal is to know whether sorting the unsorted PE tagAlign file would lead to a different result at the post-aln step.


## Procedure

Two full ATAC-seq runs were compared based on the same two PE tagAlign files, one run through mergebed v1 (sortv=0) on *each* separately (i.e. only sorting not merging), another run without.

### no merge
http://fourfront-webdev.us-east-1.elasticbeanstalk.com/files-processed/4DNFI8VL4QNS/#graph-section

### merge (i.e. sort 1, 10, 11)
http://fourfront-webdev.us-east-1.elasticbeanstalk.com/files-processed/4DNFIHZ9FEW9/#graph-section


## Result

The final bw output files from the two runs had identical sizes, suggesting that their content is identical.

```
-rw-r--r--@ 1 soo  staff  1343418011 Mar  7 10:23 4DNFIHZ9FEW9.bw
-rw-r--r--@ 1 soo  staff  1343418011 Mar  7 10:23 4DNFI8VL4QNS.bw
```

In terms of resources, there was little difference.

| resource | no merge (no sort) | sort 1, 10, 11 |
| --------- | ------------------- | ------------ |
| instance | c5.4xlage | c5.4xlarge |
| run time |  1hr 45min | 1hr 42 min |
| Max Memory | 12.4G | 10.5G |
| Max Disk space | 60G | 64G |
| Max CPU utilization | 98.7% (16 CPUs) | 88.4% (14 CPUs) |


## Conclusion

* Running mergebed doesn't change the result, and sorting1, 10, 11 may help reduce memory a bit at the post-aln step.
* We can run mergebed with sortv=0 on all cases



