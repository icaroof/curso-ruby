def boasVindas
    puts "Bem-vindo ao jogo de adivinhação!\n"
    puts "\nDigite o seu nome:"
    nome = gets.strip
    puts "\nO jogo vai começar, #{nome}\n\n" 
end

def sorteiaNumero
    puts "Escolhendo um número secreto entre 0 e 200...\n"
    numero = (rand * 100).round
    puts "Escolhido... Adivinhe o número ou digite -1 para sair\n\n"
    numero
end
 
def chutaNumero (chutes, tentativa)
    puts "Tentativa #{tentativa}\n"
    puts "Chutes dados até o momento: #{chutes}\n\n"
    
    gets.strip.to_i
end

def adivinha (numeroSecreto, chute)
    acertou = numeroSecreto == chute
    
	if acertou
		puts "Acertou, Mizerávi!\n\n"
	else
        if(chute == -1)
            puts "Desistiu? Seu pato!"
        else
            puts "Errou!\n\n"

            if numeroSecreto < chute
                puts "O número é menor que #{chute}"
            else
                puts "O número é maior que #{chute}"
            end

            puts "Tente novamente\n\n"
        end
	end
    
    acertou
end

boasVindas
numeroSecreto = sorteiaNumero

tentativa = 1
acertou = false
chutes = []

while !acertou && chutes.last != -1
    chutes << chutaNumero(chutes, tentativa)
    
	acertou = adivinha numeroSecreto, chutes.last
    
    tentativa += 1
end

