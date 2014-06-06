class NotificationsController < ApplicationController
  before_filter :authenticate_member!
  def index
    @notifications = Notification.page(params[:page]).order('created_at DESC')
    respond_to do |format|
      format.html
    end
  end
end
