require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    @result = check_word(@word, @letters)
  end

  private

  def check_word(word, letters)
    if word.upcase.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
      if english_word?(word)
        word
      else
        0
      end
    else
      -1
    end
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
