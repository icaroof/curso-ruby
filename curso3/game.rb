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

def hasHunter?(charPosition, map)
    map[charPosition[0]][charPosition[1]] == 'H'
end

def movePlayer(map, direction)
    hero = "P"
    heroPos = findPlayer map, hero
    changePosition heroPos, direction, hero, map
end

def moveHunter(map, hunterPos, direction, hunter)
    moves = {
        0 => [-1, 0],
        1 => [1, 0],
        2 => [0, -1],
        3 => [0, 1]
    }
    
    newPos = hunterPos.dup
    
    move = moves[direction]
    
    newPos[0] += move[0]
    newPos[1] += move[1]
    
    if !isColision?(newPos, map) && !hasHunter?(newPos, map)
        map[hunterPos[0]][hunterPos[1]] = " "
        hunterPos = newPos
        map[hunterPos[0]][hunterPos[1]] = hunter
    end
end

def moveHunters(map)
    hunter = "H"
    
    map.each_with_index do |curLine, line|
        curLine.chars.each_with_index do |curCol, column|
            if curCol == hunter
                direction = rand(4)
                moveHunter map, [line, column], direction, hunter
            end
        end
    end
end

def play
    map = readMap 1
    
    direction = 'A'
    
    while direction != 'Q'
        draw map
        
        direction = STDIN.getch
        
        movePlayer map, direction
        
        moveHunters map
    end
end

def startGame
    titleScreen
    play
end