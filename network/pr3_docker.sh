export CA1=$(cd crypto-config/peerOrganizations/registrar.propertyregistration-network.com/ca && ls *_sk)
export CA2=$(cd crypto-config/peerOrganizations/user.propertyregistration-network.com/ca && ls *_sk)
echo "${CA2}"
###### Start Docker container #####
##----------------------------------------
echo "Starting Docker container"
docker-compose -f ./docker-compose.yaml up -d
echo "All container are up and running"
echo "####################################"

echo "Creating Channel Artifact"
docker exec -it cli /bin/bash -e   ./scripts/createChannel.sh
#source ./scripts/createChannel.sh
echo "Created Channel Artifact"
echo "##################################"

echo "Network setup done. !!!!!!!!!!!!!!!!!"