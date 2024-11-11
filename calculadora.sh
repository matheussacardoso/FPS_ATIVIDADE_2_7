#!/bin/bash

# Define o cabeçalho HTTP para o conteúdo HTML
echo "Content-type: text/html"
echo ""

# Função para realizar a operação selecionada
calcular() {
    case "$operacao" in
        "adicao") echo "$((numero1 + numero2))" ;;
        "subtracao") echo "$((numero1 - numero2))" ;;
        "multiplicacao") echo "$((numero1 * numero2))" ;;
        "divisao") 
            if [ "$numero2" -eq 0 ]; then
                echo "Erro: Divisão por zero"
            else
                echo "$((numero1 / numero2))"
            fi
            ;;
        *) echo "Operação inválida" ;;
    esac
}

# Extrai os parâmetros da URL
QUERY_STRING=$QUERY_STRING
numero1=$(echo "$QUERY_STRING" | sed -n 's/^.*numero1=\([^&]*\).*$/\1/p')
numero2=$(echo "$QUERY_STRING" | sed -n 's/^.*numero2=\([^&]*\).*$/\1/p')
operacao=$(echo "$QUERY_STRING" | sed -n 's/^.*operacao=\([^&]*\).*$/\1/p')

# Exibe o HTML de resposta
echo "<!DOCTYPE html>"
echo "<html lang='pt-BR'>"
echo "<head><meta charset='UTF-8'><title>Resultado da Calculadora</title></head>"
echo "<body>"

# Verifica se os números são válidos
if [[ -n "$numero1" && -n "$numero2" ]]; then
    numero1=$(echo "$numero1" | sed 's/%20/ /g')
    numero2=$(echo "$numero2" | sed 's/%20/ /g')
    resultado=$(calcular)
    echo "<h1>Resultado: $resultado</h1>"
else
    echo "<h1>Erro: Parâmetros inválidos.</h1>"
fi

echo "<a href='/calculadora.html'>Voltar</a>"
echo "</body>"
echo "</html>"

