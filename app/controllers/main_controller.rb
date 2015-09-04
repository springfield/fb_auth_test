class MainController < ApplicationController
  def index
    @friends = fb.friends if logged_in?
  end
end
