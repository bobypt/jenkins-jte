# jenkins-jte

## Start Jenkins server
```
docker-compose build
docker-compose up
```

## Bootstrap all jobs
```
docker exec -it -u root jenkins-master  /jenkins/bootstrap.sh
```

Login as root
```
docker exec -it -u root jenkins-master  /bin/bash
```
