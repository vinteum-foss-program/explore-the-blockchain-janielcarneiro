# (true / false) Verify the signature by this address over this message:
#   address: `1E9YwDtYf9R29ekNAfbV7MvB4LNv7v3fGa`
#   message: `1E9YwDtYf9R29ekNAfbV7MvB4LNv7v3fGa`
#   signature: `HCsBcgB+Wcm8kOGMH8IpNeg0H4gjCrlqwDf/GlSXphZGBYxm0QkKEPhh9DTJRp2IDNUhVr0FhP9qCqo2W0recNM=`


#!/bin/bash

# Configurações de conexão
RPC_CONNECT="84.247.182.145"
RPC_USER="user_091"
RPC_PASSWORD="RdTw08robCy5"
#EXECUTAR=/home/janiel/Documentos/bitcoin-28.0-x86_64-linux-gnu/bitcoin-28.0/bin/


# Dados fornecidos
ADDRESS="1E9YwDtYf9R29ekNAfbV7MvB4LNv7v3fGa"
MESSAGE="1E9YwDtYf9R29ekNAfbV7MvB4LNv7v3fGa"
SIGNATURE="HCsBcgB+Wcm8kOGMH8IpNeg0H4gjCrlqwDf/GlSXphZGBYxm0QkKEPhh9DTJRp2IDNUhVr0FhP9qCqo2W0recNM="

# Comando bitcoin-cli para verificar a assinatura
RESULT=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD verifymessage "$ADDRESS" "$SIGNATURE" "$MESSAGE")

#RESULT=$($EXECUTAR./bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD verifymessage "$ADDRESS" "$SIGNATURE" "$MESSAGE")

# Resultado

echo "$RESULT"

