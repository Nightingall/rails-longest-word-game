class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    word = params["guess"]
    grid = params["grid"]
    if word_in_grid?(word, grid) == false
     @message = "Word not in grid"
    else word_in_grid?(word, grid) && actual_english_word(word)
     @message = "Congrtulations you have a word from the grid and its a valid word"
    end
  end

  def word_in_grid?(word, grid)
    word_upcase_split = word.upcase.split("")
    word_upcase_split.all? { |letter| word_upcase_split.count(letter) <= grid.split("").count(letter) }
  end

  def actual_english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = open(url).read
    word_info = JSON.parse(response)
    word_info["found"]
  end
end
