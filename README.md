# circleci-build
Docker image for circleci build

# build command
```
docker build . -t mediot/circleci-build:<build version> -t mediot/circleci-build:latest
```
example
```
docker build . -t mediot/circleci-build:1.0.15 -t mediot/python:latest
```

# push command example
```
docker push mediot/circleci-build:1.0.15
docker push mediot/circleci-build:latest
```