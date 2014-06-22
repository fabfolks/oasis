require 'spec_helper'

describe NotificationsController do
  it 'should assign notifications as @notifications in desc order of creation time' do
    notification1 = FactoryGirl.create(:notification)
    notification2 = FactoryGirl.create(:notification)
    house = FactoryGirl.create(:house)
    member1 = FactoryGirl.create(:member, :house => house)
    sign_in member1
    get :index
    assigns(:notifications).should eq([notification2, notification1])
  end
end
