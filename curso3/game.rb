require 'io/console'
require_relative 'ui'

def readMap(num)
    map = File.read("map#{num}.txt").split("\n")
end

def findPlayer(map, hero)
    map.each_with_index do |curLine, line|
        heroPos = curLine.index hero
        if heroPos
            return [line, heroPos]
        end
    end
end

def changePosition(heroPos, direction, hero, map)
    moves = {
        "w" => [-1, 0],
        "s" => [1, 0],
        "a" => [0, -1],
        "d" => [0, 1]
    }
    
    newPos = heroPos.dup
    
    move = moves[direction]
    
    if move
        newPos[0] += move[0]
        newPos[1] += move[1]
    end
    
    if !isColision? newPos, map
        map[heroPos[0]][heroPos[1]] = " "
        heroPos = newPos
        map[heroPos[0]][heroPos[1]] = hero
    end
end

def isColision?(charPosition, map)
    map[charPosition[0]][charPosition[1]] == 'X'
end

def movePlayer(map, direction)
    hero = "P"
    heroPos = findPlayer map, hero
    changePosition heroPos, direction, hero, map
end

def play
    map = readMap 1
    
    direction = 'A'
    
    while direction != 'Q'
        draw map
        
        direction = STDIN.getch
        
        movePlayer map, direction
        
        moveHunter map
    end
end

def startGame
    titleScreen
    play
end