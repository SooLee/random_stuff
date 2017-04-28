task hello {
    String name
    String outfilename = 'result'

    command {
        echo 'hello ${name}' > ${outfilename}
    }

    output {
        File outfile = outfilename
    }

}

workflow hello_test {
    call hello
}

