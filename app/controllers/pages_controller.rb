class PagesController < ApplicationController
  def index
    @posts= Post.limit(8)
  end
end
