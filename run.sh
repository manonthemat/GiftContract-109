#1/bin/sh
export W1=`curl -s -d '' http://localhost:9080/wallet/create | jq '.wiWallet.getWalletId'`
sleep 1
export W2=`curl -s -d '' http://localhost:9080/wallet/create | jq '.wiWallet.getWalletId'`
sleep 1
export W3=`curl -s -d '' http://localhost:9080/wallet/create | jq '.wiWallet.getWalletId'`
sleep 1
export W4=`curl -s -d '' http://localhost:9080/wallet/create | jq '.wiWallet.getWalletId'`
sleep 1

export W1_IID=$(curl -s -H "Content-Type: application/json" -X POST -d '{"caID": "GiftContract", "caWallet":{"getWalletId": '$W1'}}' http://localhost:9080/api/contract/activate | jq .unContractInstanceId | tr -d '"')
sleep 4
export W2_IID=$(curl -s -H "Content-Type: application/json" -X POST -d '{"caID": "GiftContract", "caWallet":{"getWalletId": '$W2'}}' http://localhost:9080/api/contract/activate | jq .unContractInstanceId | tr -d '"')
sleep 4
export W3_IID=$(curl -s -H "Content-Type: application/json" -X POST -d '{"caID": "GiftContract", "caWallet":{"getWalletId": '$W3'}}' http://localhost:9080/api/contract/activate | jq .unContractInstanceId | tr -d '"')
sleep 4
export W4_IID=$(curl -s -H "Content-Type: application/json" -X POST -d '{"caID": "GiftContract", "caWallet":{"getWalletId": '$W4'}}' http://localhost:9080/api/contract/activate | jq .unContractInstanceId | tr -d '"')
sleep 4

curl -H "Content-Type: application/json" -X POST -d 9000000000 http://localhost:9080/api/contract/instance/$W1_IID/endpoint/give
sleep 4
curl -H "Content-Type: application/json" -X POST -d 9000000000 http://localhost:9080/api/contract/instance/$W2_IID/endpoint/give
sleep 4
curl -H "Content-Type: application/json" -X POST -d "false" http://localhost:9080/api/contract/instance/$W3_IID/endpoint/grab
sleep 4
curl -H "Content-Type: application/json" -X POST -d "true" http://localhost:9080/api/contract/instance/$W4_IID/endpoint/grab

echo $W1
echo $W2
echo $W3
echo $W4
