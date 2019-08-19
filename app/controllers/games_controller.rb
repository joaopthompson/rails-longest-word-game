require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (("A".."Z").to_a * 100).sample(10).join
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    data = open("https://wagon-dictionary.herokuapp.com/#{@word}").read
    @info = JSON.parse(data)
    @word.upcase!

    if @word.chars.all? { |letter| @letters.count(letter) >= @word.count(letter) }
      if @info["found"] == true
        @game_score = { score: @word.length, message: "Good, well done" }
      else
        @game_score = { score: 0, message: "Word not an english word" }
      end
    else
      # raise
      @game_score = { score: 0, message: "Word not in the grid" }
    end

    #   @game_score = { score: 0, message: "Word not in the grid" }
    # elsif @info["found"] == false
    #   @game_score = { score: 0, message: "Word not an english word" }
    # else
    #   @game_score = { score: @word.length, message: "Good, well done" }
    # end

  end

  # def characters_ok(word, letters)
  #   if word.chars.all? { |letter| letters.count(letter) >= word.count(letter) }
  #     raise
  #     true
  #   else
  #     false
  #   end
  # end
end
