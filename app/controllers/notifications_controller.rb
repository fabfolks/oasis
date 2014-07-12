class NotificationsController < ApplicationController
  before_filter :check_owner, :only => [:edit, :update, :destroy]
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

  def edit
    @notification = Notification.find(params[:id])
  end

  def update
    @notification = Notification.find(params[:id])

    respond_to do |format|
      if @notification.update_attributes(params[:notification])
        format.html { redirect_to @notification, notice: 'Notification was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
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

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy

    respond_to do |format|
      format.html { redirect_to notifications_url }
      format.json { head :no_content }
    end
  end

  private
  def check_owner
    notification = Notification.find(params[:id])
    redirect_to root_url, :notice => "You are not authorized to this action" unless notification.member_id == current_member.id
  end
end
