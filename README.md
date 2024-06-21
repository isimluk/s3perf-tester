# S3 Perf Tester

Simple container that will upload and remove random file from S3-compatible storage in a loop.

``` shell
helm install s3perf-tester ./helm-charts/s3perf-test \
  -n namespace
```

