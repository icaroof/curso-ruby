require 'io/console'

def titleScreen
    clearScreen
    puts "Hunters 'n Prey"
    puts "Movements w, s, a, d"
    puts "Press any key to start"
    STDIN.getch
    clearScreen
end

def clearScreen
   if RUBY_PLATFORM =~ /win32|win64|\.NET|windows|cygwin|mingw32/i
      system('cls')
    else
      system('clear')
   end
end

def draw map
    clearScreen
    puts map
end