module RandomData

  def self.random_paragraph
    sentences = []
    rand(4..6).times do
      sentences << random_sentence
      #We create four to six random sentences and append them to sentences.
    end

    sentences.join(" ")
  end

  def self.random_sentence
    strings = []
    rand(3..8).times do
      strings << random_word
      #We create three to eight random words and append them to strings.
    end

    sentence = strings.join(" ")
    sentence.capitalize << "."
    #After we generate a sentence, we call capitalize on it and append a period.
  end

  def self.random_word
    letters = ('a'..'z').to_a
    letters.shuffle!
    #If we were to call shuffle without the bang (!), then shuffle would return an array rather than shuffle in place.
    letters[0,rand(3..8)].join
    #We join the zeroth through nth item in letters. The nth item is the result of rand(3..8) which returns a random number greater than or equal to three and less than or equal to eight.
  end

   def self.random_name
     first_name = random_word.capitalize
     last_name = random_word.capitalize
     "#{first_name} #{last_name}"
   end
 
   def self.random_email
     "#{random_word}@#{random_word}.#{random_word}"
   end
end
