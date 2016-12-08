puts "Bem-vindo ao jogo de adivinhação!\n"
puts "\nDigite o seu nome:"
nome = gets
puts "\nO jogo vai começar, " + nome + "\n"
puts "Escolhendo um número secreto entre 0 e 200...\n\n"
numero_secreto = 123
puts "Escolhido... Adivinhe o número"
acertou = false

while !acertou
	numero = gets
	puts "\nVocê escolheu o número " + numero + ". Será que acertou?\n\n"

	acertou = numero_secreto == numero.to_i
	if acertou
		puts "Acertou!"
	else 
		puts "Errou"

		if numero_secreto < numero.to_i
			puts "O número é menor que " + numero
		else
			puts "O número é maior que " + numero
		end

		puts "Tente novamente"
	end
end
