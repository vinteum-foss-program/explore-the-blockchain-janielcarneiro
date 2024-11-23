# Which tx in block 257,343 spends the coinbase output of block 256,128?
#!/bin/bash

# Defina o endereço RPC do Bitcoin
RPC_CONNECT="84.247.182.145"
RPC_USER="user_091"
RPC_PASSWORD="RdTw08robCy5"
#EXECUTAR="/home/janiel/Documentos/bitcoin-28.0-x86_64-linux-gnu/bitcoin-28.0/bin/"  # Caminho para o bitcoin-cli

# Obter o hash do bloco 256.128
#HASHP=$($EXECUTAR./bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getblockhash 256128)
HASHP=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getblockhash 256128)

# Obter transação da coinbase 256.128
TRANSACAO_COIN=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getblock $HASHP 1)
#echo "Conteúdo do bloco 256.128: $TRANSACAO_COIN"  # Verifique o formato aqui

COINBASE_TX_ID=$(echo "$TRANSACAO_COIN" | jq -r '.tx[0]')


# Obter hash do bloco 257.343 
HASHS=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getblockhash 257343)

# Obter todas as transações do bloco 257.343
TRANSACAO_TODAS=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getblock $HASHS 2)
#echo "Todas as Transações do bloco 257.343: $TRANSACAO_TODAS"

# Extrair os txid de todas as transações
TRANSACOES=$(echo "$TRANSACAO_TODAS" | jq -r '.tx[] | .txid')

# Procurar qual transação gasta a saída da coinbase
for TX in $TRANSACOES; do
    
    ENTRADAS=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getrawtransaction $TX 1 | jq -r '.vin[] | .txid')
    
    # Verificar se alguma entrada corresponde à transação coinbase
    for ENTRADA in $ENTRADAS; do
        if [[ "$ENTRADA" == "$COINBASE_TX_ID" ]]; then
            echo "$TX"
            exit 0
        fi
    done
done

echo "Nenhuma transação no bloco 257.343 gasta a saída da coinbase do bloco 256.128."

