require 'open-uri'

class GamesController < ApplicationController
  def new
    @alphabet = ("A".."Z").to_a
    @letters = []
    i = 0
    until i == 10
      letter = @alphabet.sample
      @letters << letter
      i += 1
    end
  end

  def score
    @answer = params[:score].upcase
    @letters = params[:letters].split(//)
    @arr_answer = @answer.split(//)
    if @arr_answer - @letters == []
      call_api(@answer)
      if @answer_check["found"] == true
        @message = "Congratulations! '#{@answer.capitalize}' is a valid English word."
      else @message = "Sorry but '#{@answer.capitalize}' does not seem to be a valid English word."
      end
    else @message = "Sorry but '#{@answer.capitalize}' cannot be built out of #{@letters.join(" ")}"
    end
  end

  def call_api(answer)
    url = "https://wagon-dictionary.herokuapp.com/#{answer.downcase}"
    @answer_check = open(url).read
    @answer_check = JSON.parse(@answer_check)
  end

end
