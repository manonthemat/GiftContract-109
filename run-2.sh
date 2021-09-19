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
sleep 1
export W2_IID=$(curl -s -H "Content-Type: application/json" -X POST -d '{"caID": "GiftContract", "caWallet":{"getWalletId": '$W2'}}' http://localhost:9080/api/contract/activate | jq .unContractInstanceId | tr -d '"')
sleep 1
export W3_IID=$(curl -s -H "Content-Type: application/json" -X POST -d '{"caID": "GiftContract", "caWallet":{"getWalletId": '$W3'}}' http://localhost:9080/api/contract/activate | jq .unContractInstanceId | tr -d '"')
sleep 1
export W4_IID=$(curl -s -H "Content-Type: application/json" -X POST -d '{"caID": "GiftContract", "caWallet":{"getWalletId": '$W4'}}' http://localhost:9080/api/contract/activate | jq .unContractInstanceId | tr -d '"')
sleep 1

printf "\nNext 'inspect' endpoint will be invoked for wallet 3 and 4 to Log the total value in them\n"
read -n1 -r -p "Press any key to continue..." key
printf "\n"

curl -H "Content-Type: application/json" -X POST -d 0 http://localhost:9080/api/contract/instance/$W3_IID/endpoint/inspect
sleep 1
curl -H "Content-Type: application/json" -X POST -d 0 http://localhost:9080/api/contract/instance/$W4_IID/endpoint/inspect
sleep 1

printf "\nNext we are going to put some lovelaces to the script address\n"
read -n1 -r -p "Press any key to continue..." key
printf "\n"

curl -H "Content-Type: application/json" -X POST -d 9000000000 http://localhost:9080/api/contract/instance/$W1_IID/endpoint/give
sleep 1
curl -H "Content-Type: application/json" -X POST -d 9000000000 http://localhost:9080/api/contract/instance/$W2_IID/endpoint/give
sleep 1

printf "\nNext we will see that when wallet 3 tries to grab with an incorrect redeemer the transaction fails.\n"
read -n1 -r -p "Press any key to continue..." key
printf "\n"

curl -H "Content-Type: application/json" -X POST -d "false" http://localhost:9080/api/contract/instance/$W3_IID/endpoint/grab
sleep 1

printf "\nNext, wallet 4 tries to grab the funds at the script with a valid value for the redeemer and succeeds\n"
read -n1 -r -p "Press any key to continue..." key
printf "\n"

curl -H "Content-Type: application/json" -X POST -d "true" http://localhost:9080/api/contract/instance/$W4_IID/endpoint/grab

sleep 1

printf "\nFinally we 'inspect' the funds in the wallet 4\n"
read -n1 -r -p "Press any key to continue..." key
printf "\n"

sleep 1
curl -H "Content-Type: application/json" -X POST -d 0 http://localhost:9080/api/contract/instance/$W4_IID/endpoint/inspect

sleep 1
printf "\n"
read -n1 -r -p "End. Press any key to continue..." key
printf "\n"

printf $W1
printf $W2
printf $W3
printf $W4