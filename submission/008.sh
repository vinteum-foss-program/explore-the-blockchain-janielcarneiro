# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`

# Configuração RPC
RPC_CONNECT="84.247.182.145"
RPC_USER="user_091"
RPC_PASSWORD="RdTw08robCy5"
#EXECUTAR="/home/janiel/Documentos/bitcoin-28.0-x86_64-linux-gnu/bitcoin-28.0/bin/" 
HASH_TRANSACAO="e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163"


# Obter informações da transação
#INFOR_TRANSACAO=$($EXECUTAR./bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getrawtransaction $HASH_TRANSACAO 1)
INFOR_TRANSACAO=$(bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getrawtransaction $HASH_TRANSACAO 1)

# Extrair chave pública do terceiro elemento do txinwitness
CHAVE_PUBLICA=$(echo "$INFOR_TRANSACAO" | jq -r '.vin[0].txinwitness[2]' | sed 's/^63//;s/21//;s/.$//')

# Extrair a parte desejada da chave pública (primeiros 66 caracteres)
PARTE_DA_CHAVE=$(echo "$CHAVE_PUBLICA" | cut -c1-66)

# Exibir a parte extraída
echo "$PARTE_DA_CHAVE"







