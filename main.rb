
def load_word
        lines = File.readlines('5desk.txt')
        array = []
       
        lines.each do |line|
            word = line.split
             #puts word.to_s.length   
            if word.to_s.length > 5 && word.to_s.length < 13    
                array.push(word) 
                else
                    next
                end
        end        

        hangman_word = array.shuffle.first
            #puts hangman_word

            filename = "lib/savehangman.txt"
            File.open(filename,'w') do |file|
                file.puts hangman_word
            end
    return hangman_word
end






class Game
        load_word
        hangman_word = File.read('lib/savehangman.txt')
        #puts hangman_word.to_s.length - 1   
    
        (hangman_word.length-1).times {print "_ "}

        puts
    def verification(letter)
        
    end            
end


new = Game.new
puts


guess_letter = gets.chomp

