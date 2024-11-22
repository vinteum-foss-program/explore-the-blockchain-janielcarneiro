# What is the hash of block 654,321?
#!/bin/bash

#Variaveis
RPC_CONNECT="84.247.182.145"
RPC_USER="user_091"
RPC_PASSWORD="RdTw08robCy5"
BLOCK_NUMBER=654321
#EXECUTAR=/home/janiel/Documentos/bitcoin-28.0-x86_64-linux-gnu/bitcoin-28.0/bin/

#Comando bitcoin-cli
#$EXECUTAR./#bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getblockhash $BLOCK_NUMBER
bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getblockhash $BLOCK_NUMBER
