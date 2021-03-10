class SearchController < ApplicationController
  def search
    @model = params[:model]
    @target = params[:target]
    @letter = params[:letter]

    if @model == "user"
      @data = User.search_for(@target, @letter)
    else
      @data = Book.search_for(@target, @letter)
    end
  end
end
