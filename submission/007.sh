# Only one single output remains unspent from block 123,321. What address was it sent to?

# Configuração RPC
RPC_CONNECT="84.247.182.145"
RPC_USER="user_091"
RPC_PASSWORD="RdTw08robCy5"
EXECUTAR="/home/janiel/Documentos/bitcoin-28.0-x86_64-linux-gnu/bitcoin-28.0/bin/" 

# Obter o hash do bloco 123.321
HASH_BLOCO=$($EXECUTAR./bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getblockhash 123321)

# Obter todas as transações do bloco
TRANSACOES_BLOCO=$($EXECUTAR./bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getblock $HASH_BLOCO 2)

# Extrair os txid de todas as transações
TRANSACOES=$(echo "$TRANSACOES_BLOCO" | jq -r '.tx[].txid')
#echo "$TRANSACOES_BLOCO" | jq -r '.tx[]'


# Variável para contar quantos UTXOs não gastos são encontrados
UTXO_ENCONTRADOS=0

# Verificar cada transação para saídas não gastas
for TX in $TRANSACOES; do
    if [[ ${#TX} -eq 64 ]]; then
        # Obter os detalhes da transação
        RAW_TX=$($EXECUTAR./bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getrawtransaction $TX 1)
        
        # Loop através de cada saída da transação
        for i in $(seq 0 $(($(echo "$RAW_TX" | jq '.vout | length') - 1))); do
            UTXO=$($EXECUTAR./bitcoin-cli -rpcconnect=$RPC_CONNECT -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD gettxout $TX $i)
            
            # Verificar se a saída não está gasta
            if [[ ! -z "$UTXO" ]]; then
                ENDERECO=$(echo "$UTXO" | jq -r '.scriptPubKey.address')
                echo "$ENDERECO"
                UTXO_ENCONTRADOS=$((UTXO_ENCONTRADOS + 1))
            fi
        done
    else
        echo "Transação $TX não possui um txid válido."
    fi
done









