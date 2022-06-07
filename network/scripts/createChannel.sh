# ---------- Update ENV variables for user --------------------
export CHANNEL_NAME="propertyregistrationchannel"

SetGlobal_Usr_Peer_0(){
CORE_PEER_LOCALMSPID="userMSP"
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/user.propertyregistration-network.com/users/Admin@user.propertyregistration-network.com/msp
CORE_PEER_ADDRESS=peer0.user.propertyregistration-network.com:7051
}
SetGlobal_Usr_Peer_1(){
CORE_PEER_LOCALMSPID="userMSP"
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/user.propertyregistration-network.com/users/Admin@user.propertyregistration-network.com/msp
CORE_PEER_ADDRESS=peer1.user.propertyregistration-network.com:8051
}


SetGlobal_Reg_Peer_0(){
CORE_PEER_LOCALMSPID="registrarMSP"
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/registrar.propertyregistration-network.com/users/Admin@registrar.propertyregistration-network.com/msp
CORE_PEER_ADDRESS=peer0.registrar.propertyregistration-network.com:9051
}
SetGlobal_Reg_Peer_1(){
CORE_PEER_LOCALMSPID="registrarMSP"
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/registrar.propertyregistration-network.com/users/Admin@registrar.propertyregistration-network.com/msp
CORE_PEER_ADDRESS=peer1.registrar.propertyregistration-network.com:10051
}

createChannel(){
SetGlobal_Usr_Peer_0   
peer channel create -o orderer.propertyregistration-network.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/channel.tx  --outputBlock ./channel-artifacts/${CHANNEL_NAME}.block
echo "channel created !!!!!!"
}

joinChannel(){
SetGlobal_Usr_Peer_0  
peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
SetGlobal_Usr_Peer_1 
peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
SetGlobal_Reg_Peer_0  
peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
SetGlobal_Reg_Peer_1 
peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
echo "peer joined the channel"
}

updateAnchorPeers(){
SetGlobal_Usr_Peer_0  
peer channel update -o orderer.propertyregistration-network.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/${CORE_PEER_LOCALMSPID}anchors.tx
SetGlobal_Reg_Peer_0 
peer channel update -o orderer.propertyregistration-network.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/${CORE_PEER_LOCALMSPID}anchors.tx
echo "Anchor peer updated !!!!!!"
}


createChannel
sleep 2
joinChannel
sleep 2
updateAnchorPeers
sleep 2