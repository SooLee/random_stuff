task hello {
    String name
    String outfilename = 'result'

    command {
        echo 'hello ${name}' > ${outfilename}
    }

    output {
        File outfile = outfilename
    }

    runtime {
        docker: "ubuntu:16.04"
    }
}

workflow hello_test {
    call hello
}

