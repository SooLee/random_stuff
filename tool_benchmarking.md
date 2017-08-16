## cooler balance / zoomify

* input : s3://elasticbeanstalk-fourfront-webprod-wfoutput/acdab973-8876-4a58-a701-97e7f30e3f0a/4DNFIHKCL9SF.cool 
* (res 5000bp)
* experimented on Amazon instance (r3.8xlarge, 244GB mem, 32 cores)
* on docker `duplexa/4dn-hic:v32`

```
container_id=$(docker run --detach -it -v ~/data/:/d/:rw duplexa/4dn-hic:v32 bash)
```

* `cooler balance`
* ncore=8, max_iter=3000, chunksize=10000000
```
docker exec $container_id /usr/bin/time run-cooler-balance.sh /d/4DNFIHKCL9SF.cool 3000 /d/out 10000000 &
```
```
8401.52user 2434.53system 22:34.82elapsed 799%CPU (0avgtext+0avgdata 508428maxresident)k
102249inputs+7785408outputs (275major+1347930336minor)pagefaults 0swaps
# 22 min, 508MB max mem (per-process?), using 8 cores.
# It's using 8 cores by default.
```

* `cooler zoomify`
* ncore=8, chunksize=10000000
```
docker exec $container_id /usr/bin/time run-cool2multirescool.sh /d/4DNFIHKCL9SF.cool 8 /d/out2 10000000 2> log.zoomify &
```
```
35278.59user 10261.71system 2:26:24elapsed 518%CPU (0avgtext+0avgdata 5734184maxresident)k
2128inputs+25810096outputs (10major+5346185491minor)pagefaults 0swaps
# 2.5 hr runtime using 5.7GB as max mem per core, using 8 cores.
```


