# S3 Perf Tester
[![Docker Repository on Quay](https://quay.io/repository/slukasik/s3perf-tester/status "Docker Repository on Quay")](https://quay.io/repository/slukasik/s3perf-tester)

Simple container that will upload and remove random file from S3-compatible storage in a loop.

### Test vanilla S3
``` shell
helm install s3perf-tester ./helm-charts/s3perf-test \
  -n namespace \
  --set replicaCount=4 \
  --set conf.file_size_kb=1024 \
  --set conf.s3.bucket=test \
  --set conf.s3.region=us-east-1 \
  --set conf.s3.access_key=ABCDEF \
  --set conf.s3.secret_key=ABCDEF
```

### Test S3 compatible end-point
``` shell
helm install s3perf-tester ./helm-charts/s3perf-test \
  -n namespace \
  --set replicaCount=4 \
  --set conf.file_size_kb=1024 \
  --set conf.s3.bucket=test \
  --set conf.s3.host=my.demo.test \
  --set conf.s3.access_key=ABCDEF \
  --set conf.s3.secret_key=ABCDEF
```
