task bwa_mem {
    File input_fastq1
    File input_fastq2
    File bwaIndex
    String output_prefix
    Int nThreads
    String output_dir
    String output_file_name = output_dir + "/" + output_prefix + '.bam'

    command {
        run-bwa-mem.sh ${input_fastq1} ${input_fastq2} ${bwaIndex} ${output_prefix} ${nThreads} ${output_dir}
    }

    output {
        File output_bam = output_file_name
    }

    runtime {
        docker: "duplexa/4dn-hic:v8"
    }
}

workflow bwa_mem_test {
    call bwa_mem
}

