class HomeController < ApplicationController

  def index
    redirect_to notifications_url
  end
end
