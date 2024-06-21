# S3 Perf Tester
[![Docker Repository on Quay](https://quay.io/repository/slukasik/s3perf-tester/status "Docker Repository on Quay")](https://quay.io/repository/slukasik/s3perf-tester)

Simple container that will upload and remove random file from S3-compatible storage in a loop.

``` shell
helm install s3perf-tester ./helm-charts/s3perf-test \
  -n namespace \
  --set replicaCount=4 \
```

