
  WORD = []
  $word_to_guess = []
  $guess_letter = []
  $guess_word = []
  $notguess_letter = []
  $number_of_guess = 0


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

            filename = "lib/hangman_word.txt"
            File.open(filename,'w') do |file|
                file.puts hangman_word
            end
            hangman_word.map do |w|             
              WORD.push(w)              
            end

        hangman = WORD[0]     
        hangman.split(//).each do |l|
         $word_to_guess.push(l)
        end     

        for i in (0..$word_to_guess.length-1)
          $guess_word[i] = "_"
        end
         

    return hangman_word
end



class Game
  def new_game     
        load_word
       
      hangman_word  =WORD[0]
        (hangman_word.length).times {print "_ "}
        puts
    
      
  end
end

class Save_game

  def save
    hangman_word = File.read('lib/hangman_word.txt')
    puts "Choose name of saving"
    name_saving =gets.chomp 

    filename = "lib/savehangman.csv"
            File.open(filename,'a') do |file|
                file.print name_saving
                file.print ";"  
                file.print $word_to_guess.join
                file.print ";"
                file.print $guess_letter.join
                file.print ";"
                file.print $guess_word.join
                file.print ";"
                file.print $notguess_letter.join
                file.print ";"        
                file.print $number_of_guess
                file.print ";"
                file.puts                 
            end
      puts " Game saved - keep playing "
  end

end

class Load_game

  def load

      lines = File.readlines('lib/savehangman.csv')
      i = 1
      lines.each do |line|
            columns = line.split(";")
            namesave = columns[0]
            puts "#{i} #{namesave}"
            i += 1
      end

      puts "choose what number load Game saved"
      chose_load = gets.chomp

      #lines.each do |line|
      line = lines[chose_load.to_i-1]
            columns = line.split(";")
            namesave = columns[0]
           $word_to_guess = [] 
            wg = columns[1]
              for i in (0..wg.length-1)
                $word_to_guess.push(wg[i])
              end

            $guess_letter = []
            gl = columns[2]
              for i in (0..gl.length-1)
                $guess_letter.push(gl[i])
              end

            $guess_word = []
            gw = columns[3]
              for i in (0..gw.length-1)
                $guess_word.push(gw[i])
              end

            $notguess_letter = []
            nl = columns[4]
              for i in (0..nl.length-1)
                $notguess_letter.push(nl[i])
              end
          
            $number_of_guess = columns[5].to_i
            puts
            puts "Save is load, continue play"
            print $guess_word.join(" ")
          end
        
 # end

end

class Guess_letter
 
    def initialize (letter)
      @letter = letter
    end

    def play_letter   
       hangman = WORD[0]
      if WORD[0].include? @letter
         $guess_letter.push(@letter)

        for i in (0..$word_to_guess.length)
          if $word_to_guess[i] == @letter
            $guess_word[i] = @letter
          end
        end

        print $guess_word.join(" ")
      else
        $notguess_letter.push(@letter)
        print $guess_word.join(" ")
        puts
        puts "Letter #{@letter} is wrong, choose another"
      end
      unless $guess_word.include?("_")
        puts
        puts " You  win in #{$number_of_guess} moves. Game Over"
        exit
      end
    end

end


  puts "Write 'new' for new game, Write 'load' for load game, Write 'save' for save game"

  choose_option = gets.chomp
 
  
  
    if choose_option == "new"
      new = Game.new
      puts new.new_game

        while $number_of_guess.to_i < 20
          puts
          puts "                - Incercarea numarul #{$number_of_guess} "
          puts "Letter guess is: #{$guess_letter.join("; ")}"
          
          puts "Letter wrong is: #{$notguess_letter.join("; ")} "
          puts "Choose letter for word"
          letter = gets.chomp
          
          if letter == "save"
            save = Save_game.new
             save.save
          elsif letter == "load"
            load = Load_game.new
            load.load
          else
          guess = Guess_letter.new(letter)
          guess.play_letter
         
          $number_of_guess += 1
          end
        end

      elsif choose_option == "save"
        save = Save_game.new
        save.save
      else
        exit
      end
      
    






