class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_members

  def set_members
    @members = current_member.house.members - Array.wrap(current_member)
  end
end
