
# Generate System Genesis block
configtxgen -profile OrdererGenesis -channelID property-sys-channel -outputBlock ./channel-artifacts/genesis.block

# Generate channel configuration block
configtxgen -profile PropertyRegistrationChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID propertyregistrationchannel

# Generating anchor peer 
configtxgen -profile PropertyRegistrationChannel -outputAnchorPeersUpdate ./channel-artifacts/userMSPanchors.tx -channelID propertyregistrationchannel -asOrg userMSP

configtxgen -profile PropertyRegistrationChannel -outputAnchorPeersUpdate ./channel-artifacts/registrarMSPanchors.tx -channelID propertyregistrationchannel -asOrg registrarMSP

sleep 1

export CA1=$(cd crypto-config/peerOrganizations/registrar.propertyregistration-network.com/ca && ls *_sk)
export CA2=$(cd crypto-config/peerOrganizations/user.propertyregistration-network.com/ca && ls *_sk)
sleep 1
echo "${CA1}"