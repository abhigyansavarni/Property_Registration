

version=1.3
export CHANNEL_NAME="propertyregistrationchannel"

SetGlobal_Usr_Peer_0(){
CORE_PEER_LOCALMSPID="userMSP"
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/user.propertyregistration-network.com/users/Admin@user.propertyregistration-network.com/msp
CORE_PEER_ADDRESS=peer0.user.propertyregistration-network.com:7051
}

SetGlobal_Reg_Peer_0(){
CORE_PEER_LOCALMSPID="registrarMSP"
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/registrar.propertyregistration-network.com/users/Admin@registrar.propertyregistration-network.com/msp
CORE_PEER_ADDRESS=peer0.registrar.propertyregistration-network.com:9051
}

Installchaincode(){
SetGlobal_Usr_Peer_0    
peer chaincode install -n regnet -v ${version} -l node -p /opt/gopath/src/github.com/hyperledger/fabric/peer/chaincode/
SetGlobal_Reg_Peer_0
peer chaincode install -n regnet -v ${version} -l node -p /opt/gopath/src/github.com/hyperledger/fabric/peer/chaincode/
echo "Chaincode Installed !!!!!!!"
}


Instantiatechaincode(){
echo "Chaincode Instantiation started !!!!!!!"
SetGlobal_Usr_Peer_0 
peer chaincode instantiate -o orderer.propertyregistration-network.com:7050 -C $CHANNEL_NAME -n regnet -l node -v ${version} -c '{"Args":["org.propertyregistration-network.regnet:instantiate"]}' -P "OR ('userMSP.member','registrarMSP.member')"

}

Installchaincode
sleep 2
Instantiatechaincode