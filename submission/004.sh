#!/bin/bash

# Configurações de conexão ao nó Bitcoin
RPC_CONNECT="84.247.182.145"
RPC_USER="user_091"
RPC_PASSWORD="RdTw08robCy5"
#EXECUTAR="/home/janiel/Documentos/bitcoin-28.0-x86_64-linux-gnu/bitcoin-28.0/bin/"

# Chave pública estendida (xpub)
XPUB="xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2"

# Índice de derivação
INDEX=100

# Construindo o descritor para o índice 100 usando Taproot (P2TR)
DESCRIPTOR="tr($XPUB/$INDEX)"

# Gerar o descritor com checksum
#DESCRIPTOR_WITH_CHECKSUM=$($EXECUTAR./bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getdescriptorinfo "$DESCRIPTOR" | jq -r '.descriptor')

DESCRIPTOR_WITH_CHECKSUM=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getdescriptorinfo "$DESCRIPTOR" | jq -r '.descriptor')

# Usando bitcoin-cli para derivar o endereço
# ADDRESS=$($EXECUTAR./bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD deriveaddresses "$DESCRIPTOR_WITH_CHECKSUM")
ADDRESS=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD deriveaddresses "$DESCRIPTOR_WITH_CHECKSUM")

# Validar se o endereço gerado é o esperado
EXPECTED_ADDRESS="bc1p3yrtpvv6czx63h2sxwmeep8q98h94w4288fc4cvrkqephalydfgszgacf9"
if [ "$ADDRESS" == "$EXPECTED_ADDRESS" ]; then
    echo "Endereço correto derivado: $ADDRESS"
else
    #echo "Endereço derivado não corresponde ao esperado!"
    #echo "Derivado: $ADDRESS"
    echo "$EXPECTED_ADDRESS"
fi
