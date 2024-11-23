# How many new outputs were created by block 123,456?
#!/bin/bash

# Configurações de conexão
RPC_CONNECT="84.247.182.145"
RPC_USER="user_091"
RPC_PASSWORD="RdTw08robCy5"
BLOCK_NUMBER=123456  
#EXECUTAR=/home/janiel/Documentos/bitcoin-28.0-x86_64-linux-gnu/bitcoin-28.0/bin/

# Passo 1: Obter o hash do bloco
BLOCK_HASH=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getblockhash $BLOCK_NUMBER)
#BLOCK_HASH=$($EXECUTAR./bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getblockhash $BLOCK_NUMBER)


# Passo 2: Obter todas as transações do bloco
TRANSACTIONS=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getblock $BLOCK_HASH | jq -r '.tx[]')
#TRANSACTIONS=$($EXECUTAR./bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getblock $BLOCK_HASH | jq -r '.tx[]')

# Passo 3: Inicializar contagem de saídas
TOTAL_OUTPUTS=0

# Passo 4: Contar as saídas de cada transação
#OUTPUT_COUNT=$($EXECUTAR./bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getrawtransaction $TXID true | jq '.vout | length')
for TXID in $TRANSACTIONS; do
    OUTPUT_COUNT=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getrawtransaction $TXID true | jq '.vout | length')
    TOTAL_OUTPUTS=$((TOTAL_OUTPUTS + OUTPUT_COUNT))
done

# Exibir o total de saídas
echo "$TOTAL_OUTPUTS"
