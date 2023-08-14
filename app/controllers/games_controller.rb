require 'open-uri'

class GamesController < ApplicationController
  def new
    alphabet = ('A'..'Z').to_a
    @letters = 10.times.map { alphabet.sample(1) }
  end

  def score
    @guess = params[:guess]
    @grid = params[:grid]
    # url = "https://wagon-dictionary.herokuapp.com/#{@guess}"

    # validate word
    if @guess.upcase.chars.all? { |letter| @guess.count(letter) <= @grid.count(letter) }
      # check is the word is in the english dicionary
      response = URI.open("https://wagon-dictionary.herokuapp.com/#{@guess}")
      json = JSON.parse(response.read)
      valid = json['found']
      if valid
        # score based on length and time
        @result = 'well done'
      else
        @result = 'sorry, not an english word'
      end
    else
      @result = 'not in the grid'
    end
  end
end
