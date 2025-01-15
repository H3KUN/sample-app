class SearchesController < ApplicationController

  def search
    @word = params[:word]
    @microposts = Micropost.looks(params[:word])
    @microposts = @microposts.page(params[:page])
    render '/searches/search_result'
  end
end
