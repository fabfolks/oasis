class HomeController < ApplicationController
  before_filter :authenticate_member!
  def index
    @members = current_member.house.members - Array.wrap(current_member)
    @notifications = Notification.page(params[:page]).order('created_at DESC')
    respond_to do |format|
      format.html
    end
  end
end
