# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`
#!/bin/bash
#!/bin/bash

# Configurações RPC
RPC_CONNECT="84.247.182.145"
RPC_USER="user_091"
RPC_PASSWORD="RdTw08robCy5"
#EXECUTAR="/home/janiel/Documentos/bitcoin-28.0-x86_64-linux-gnu/bitcoin-28.0/bin/"

# TXID alvo
TXID="37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517"

# Obter a transação bruta
#RAW_TX=$($EXECUTAR./bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getrawtransaction $TXID)
RAW_TX=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getrawtransaction $TXID)

# Verificar se a transação bruta foi retornada
if [[ -z "$RAW_TX" ]]; then
  echo "Erro: Não foi possível obter a transação bruta."
  exit 1
fi

# Decodificar a transação bruta para obter detalhes
#DECODED_TX=$($EXECUTAR./bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD decoderawtransaction "$RAW_TX")
DECODED_TX=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD decoderawtransaction "$RAW_TX")

# Verificar se a transação foi decodificada
if [[ -z "$DECODED_TX" ]]; then
  echo "Erro: Não foi possível decodificar a transação."
  exit 1
fi

# Extrair as chaves públicas das testemunhas (txinwitness) das entradas
PUBKEYS=$(echo "$DECODED_TX" | jq -r '.vin[].txinwitness[1]' | grep -E '^[0-9a-f]{66}$')

# Verificar se chaves públicas foram encontradas
if [[ -z "$PUBKEYS" ]]; then
  echo "Erro: Nenhuma chave pública válida encontrada nas entradas da transação."
  exit 1
fi

# Montar o array JSON de chaves públicas
PUBKEYS_JSON=$(echo "$PUBKEYS" | jq -R . | jq -s .)

# Criar o script multisig com 1 de 4
#MULTISIG=$($EXECUTAR./bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD createmultisig 1 "$PUBKEYS_JSON")
MULTISIG=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD createmultisig 1 "$PUBKEYS_JSON")

# Verificar se o endereço multisig foi gerado
if [[ -z "$MULTISIG" ]]; then
  echo "Erro: Não foi possível criar o endereço multisig."
  exit 1
fi

# Exibir o endereço multisig gerado
ADDRESS=$(echo "$MULTISIG" | jq -r '.address')
REDEEM_SCRIPT=$(echo "$MULTISIG" | jq -r '.redeemScript')

echo "$ADDRESS"
#echo "Redeem Script: $REDEEM_SCRIPT"


