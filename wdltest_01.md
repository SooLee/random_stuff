### Summary
* These are my initial tests of WDL (workflow description/definition language)


### Install `cromwell` to run wdl scripts.

```bash
#installing cromwell
brew install cromwell
```
```bash
cromwell -version
```
```
26-22fe860-SNAP
```


### Run hello wdl as the first test.
#### run using `cromwell`.

```bash
cromwell run wdltest_01/hello.wdl wdltest_01/hello_wdl.json
```
```
[2017-04-28 15:02:54,78] [info] SingleWorkflowRunnerActor workflow finished with status 'Succeeded'.
{
  "outputs": {
    "hello_test.hello.outfile": "/Users/soo/git/random_stuff/cromwell-executions/hello_test/bff286d0-f2d3-4431-983e-27237a61a386/call-hello/execution/result"
  },
  "id": "bff286d0-f2d3-4431-983e-27237a61a386"
}
```
Success..

#### Checking output file
```bash
cat /Users/soo/git/random_stuff/cromwell-executions/hello_test/bff286d0-f2d3-4431-983e-27237a61a386/call-hello/execution/result
```
```
hello soo
```
Yay!


### Run hello_docker wdl 
This one is differnt from hello in that it has specified `ubuntu:16.04` as docker image to run hello.

#### run using `cromwell`.

```bash
cromwell run wdltest_01/hello_docker.wdl wdltest_01/hello_wdl.json 
```
```
[2017-04-28 15:07:48,84] [info] SingleWorkflowRunnerActor workflow finished with status 'Succeeded'.
{
  "outputs": {
    "hello_test.hello.outfile": "/Users/soo/git/random_stuff/cromwell-executions/hello_test/7ac5ff63-e51e-478b-b335-d8db1b691975/call-hello/execution/result"
  },
  "id": "7ac5ff63-e51e-478b-b335-d8db1b691975"
}
[2017-04-28 15:07:48,92] [error] Outgoing request stream error
```
Run was successful but there was an 'outgoing request stream error'.

#### Checking output file
```bash
cat /Users/soo/git/random_stuff/cromwell-executions/hello_test/7ac5ff63-e51e-478b-b335-d8db1b691975/call-hello/execution/result
```
```
hello soo
```
The output file is created, though.


### testing local input file

#### running

```bash
cromwell run wdltest_01/hello_file.wdl wdltest_01/hello_file_wdl.json 
```
```
[2017-04-28 15:20:03,32] [info] SingleWorkflowRunnerActor workflow finished with status 'Succeeded'.
{
  "outputs": {
    "hello_test.hello.outfile": "/Users/soo/git/random_stuff/cromwell-executions/hello_test/7c95ba1a-aafd-4ba3-9899-dab14e82ecfe/call-hello/execution/result"
  },
  "id": "7c95ba1a-aafd-4ba3-9899-dab14e82ecfe"
}
```

#### Checking output file
```bash
cat /Users/soo/git/random_stuff/cromwell-executions/hello_test/7c95ba1a-aafd-4ba3-9899-dab14e82ecfe/call-hello/execution/result
```
```
soo
```

### Run hello_file_docker
Local file input and docker.

#### running
```bash
cromwell run wdltest_01/hello_file_docker.wdl wdltest_01/hello_file_wdl.json
```
```
{
  "outputs": {
    "hello_test.hello.outfile": "/Users/soo/git/random_stuff/cromwell-executions/hello_test/73552f96-2bce-4da6-87b5-17a7d44b5942/call-hello/execution/result"
  },
  "id": "73552f96-2bce-4da6-87b5-17a7d44b5942"
}
[2017-04-28 15:22:51,34] [error] Outgoing request stream error
akka.stream.AbruptTerminationException: Processor actor [Actor[akka://cromwell-system/user/StreamSupervisor-1/flow-2-0-unknown-operation#-1274839802]] terminated abruptly
[2017-04-28 15:22:51,34] [error] Outgoing request stream error
akka.stream.AbruptTerminationException: Processor actor [Actor[akka://cromwell-system/user/StreamSupervisor-1/flow-6-0-unknown-operation#554779889]] terminated abruptly
```
Likewise, the run was successful, but there was 'outgoing request stream error'


### Run bwa-mem wdl with some local files inside docker
```bash
cromwell run wdltest_01/bwa-mem.wdl wdltest_01/bwa-mem_wdl.json 
```
```
[2017-04-28 15:12:44,85] [warn] Localization via hard link has failed: /Users/soo/git/random_stuff/cromwell-executions/bwa_mem_test/4c0215a8-2d8f-4e12-93a8-70fb3b7e83b0/call-bwa_mem/inputs/Users/soo/data/references/hg38.bwaIndex.tgz  -> /Users/soo/data/references/hg38.bwaIndex.tgz 
[2017-04-28 15:12:44,86] [warn] Localization via copy has failed: /Users/soo/data/references/hg38.bwaIndex.tgz 
[2017-04-28 15:12:44,87] [error] BackgroundConfigAsyncJobExecutionActor [4c0215a8bwa_mem_test.bwa_mem:NA:1]: Error attempting to Execute
```
The earliest error I get says input files cannot be linked or copied.
Possibly because here I used the absolute path instead of a file under the current directory.


