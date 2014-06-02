class HomeController < ApplicationController
  before_filter :authenticate_member!
  def index
    @member = Member.all.first
    respond_to do |format|
      format.html
    end
  end
end
