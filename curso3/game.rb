require 'io/console'
require_relative 'ui'

def readMap(num)
    map = File.read("map#{num}.txt").split("\n")
end

def copyMap(map)
    newMap = map.join("\n").tr("H", " ").split("\n")
end

def findPlayer(map, hero)
    map.each_with_index do |curLine, line|
        heroPos = curLine.index hero
        if heroPos
            return [line, heroPos]
        end
    end
    nil
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
    
    if !isColision? [newPos[0], newPos[1]], map
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

def validMoves(map, newMap, position)
    positions = []
    moves = [[-1, 0], [0, +1], [+1, 0], [0, -1]]
    
    moves.each do |move|
        newPos = [position[0] + move[0], position[1] + move[1]]
        
        if (!isColision?(newPos, map) && !hasHunter?(newPos, map)) && (!isColision?(newPos, newMap) && !hasHunter?(newPos, newMap))
            positions << newPos
        end
    end

    positions
end

def movePlayer(map, direction)
    hero = "P"
    heroPos = findPlayer map, hero
    changePosition heroPos, direction, hero, map
end

def moveHunter(map, newMap, hunterPos, hunter)
    moves = validMoves map, newMap, hunterPos
    
    if moves.empty?
        return
    end
    
    move = moves[rand(moves.size)]
    
    map[hunterPos[0]][hunterPos[1]] = " "
    newMap[move[0]][move[1]] = hunter
end

def moveHunters(map)
    hunter = "H"
    
    newMap = copyMap(map)
    
    map.each_with_index do |curLine, line|
        curLine.chars.each_with_index do |curCol, column|
            if curCol == hunter
                moveHunter map, newMap, [line, column], hunter
            end
        end
    end
    
    newMap
end

def playerLost?(map)
    !findPlayer(map)
end

def play
    map = readMap 1
    
    direction = 'A'
    
    while direction != 'Q'
        draw map
        
        direction = STDIN.getch
        
        movePlayer map, direction
        
        map =  moveHunters map
        
        if playerLost? map
            gameOver
            break
        end
    end
end

def startGame
    titleScreen
    play
end