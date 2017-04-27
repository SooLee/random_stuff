
### Benchmarking result for pgltools

#### Method
* I subsampled from a 1 billion read K562 in-situ Hi-C pgl file and queried the entries that occurs at the very beginning of the file (1:1-20000000|1:1-20000000) - supposedly among the easiest queries.
* Note: The file is position-sorted, so the second region query may slow down the query speed a bit.

#### Conclusion.
* Memory and run time was linear to the number of reads in the file. 

![](pgltools_benchmarking/pgltools_benchmarking.20170427.png)

* Estimated memory and run time for 1 billion reads is ~600GB mem and ~2 hours of run time.
* I'm guessing that most of this seems to be spent on building an internal index.

