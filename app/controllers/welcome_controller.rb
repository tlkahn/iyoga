class WelcomeController < ApplicationController
  def index

  end

  def search
  	render :text => "You are searching for #{params[:search_text]}"
  end
end
