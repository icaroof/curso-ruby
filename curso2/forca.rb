require_relative 'ui'

def pegaPalavraDeArquivo
    arquivo = File.new("dicionario.txt", "r")
    qtdPalavras = arquivo.gets.to_i
    aleatoria = rand(qtdPalavras)
    for i in 1..aleatoria -1
        arquivo.gets
    end
    palavra = arquivo.gets.strip.downcase
    arquivo.close
    palavra
end

def palavraMascarada(chutes, palavra_secreta)
    mascara = ""
    for letra in palavra_secreta.chars
        if chutes.include? letra
            mascara += letra
        else
            mascara += "_"
        end
    end
    mascara
end

def joga(nome)
    palavraSecreta = sorteiaPalavraSecreta

    erros = 0
    chutes = []
    pontos = 0

    while erros < 5
        mascara = palavraMascarada chutes, palavraSecreta
        
        chute = pedeUmChute chutes, erros, mascara
        
        if(chutes.include? chute)
            puts "Você já chutou #{chute}"
            next
        end
        
        chutes << chute
        
        if chute.size == 1
            total_encontrado = palavraSecreta.count(chute)
            if total_encontrado == 0
                puts "Letra não encontrada!"
                erros += 1
            else
                puts "Letra encontrada #{total_encontrado} vezes!"
            end
        else
            if chute == palavraSecreta
                puts "Parabéns! Acertou!"
                pontos += 100
                break
            else
                puts "Que pena... errou!"
                pontos -= 30
                erros += 1
            end
        end
    end

    puts "Você ganhou #{pontos} pontos."
end

def jogoDaForca
    nome = boasVindas

    loop do
        joga nome
        break if naoQuerJogar?
    end
end