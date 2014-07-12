class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_member!
  before_filter :set_members

  def set_members
    @my_members = current_member.house.members - Array.wrap(current_member) if member_signed_in?
  end
end
