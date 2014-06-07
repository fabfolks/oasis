class NotificationsController < ApplicationController
  before_filter :authenticate_member!
  def index
    @notifications = Notification.page(params[:page]).order('created_at DESC')
    respond_to do |format|
      format.html
    end
  end

  def show
    @notification = Notification.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @member }
    end
  end

  def new
    @notification = Notification.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @notification }
    end
  end

  def create
    @notification = current_member.notifications.new(params[:notification])

    respond_to do |format|
      if @notification.save
        format.html { redirect_to root_url, notice: 'notification was successfully created.' }
        format.json { render json: @notification, status: :created, location: @notification }
      else
        format.html { render action: "new" }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end
end
