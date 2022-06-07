# STOP AND DELETE THE DOCKER CONTAINERS
docker ps -aq | xargs -n 1 docker stop
docker ps -aq | xargs -n 1 docker rm -v

# DELETE THE OLD DOCKER VOLUMES
$y | docker volume prune 

# DELETE OLD DOCKER NETWORKS 
$y | docker network prune

# VERIFY RESULTS 
docker ps -a 
docker volume ls
docker volume rm $(docker volume ls -q)

rm -rf ./channel-artifacts/*
rm -rf ./crypto-config/*