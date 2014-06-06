class HomeController < ApplicationController
  before_filter :authenticate_member!

  def index
    redirect_to notifications_url
  end
end
