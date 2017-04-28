task hello {
    File input_file
    String outfilename = 'result'

    command {
        cat ${input_file}  > ${outfilename}
    }

    output {
        File outfile = outfilename
    }

}

workflow hello_test {
    call hello
}

