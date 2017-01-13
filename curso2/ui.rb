def boasVindas
    puts "Bem vindo ao jogo da forca"
    puts "Qual é o seu nome?"
    nome = gets.strip
    puts "\n\n"
    puts "Começaremos o jogo para você, #{nome}"
    nome
end

def sorteiaPalavraSecreta
    puts "Escolhendo uma palavra..."
    palavraSecreta = pegaPalavraDeArquivo
    puts "Escolhida uma palavra com #{palavraSecreta.size} letras... boa sorte!"
    palavraSecreta
end

def naoQuerJogar?
    puts "Deseja jogar novamente? (S/N)"
    querojogar = gets.strip
    querojogar.upcase == "N"
end

def pedeUmChute(chutes, erros, mascara)
    puts "\n\n"
    puts "Palavra secreta: #{mascara}"
    puts "Erros até agora: #{erros}"
    puts "Chutes até agora: #{chutes}"
    puts "Entre com a letra ou palavra"
    chute = gets.strip.downcase
    puts "Será que acertou? Você chutou #{chute}"
    chute
end