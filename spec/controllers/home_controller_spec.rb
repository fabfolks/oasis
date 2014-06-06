require 'spec_helper'

describe HomeController do
  describe 'index' do
  describe 'signed in member' do
    it 'should assign members of house of current member, except current member, as @members' do
      house = FactoryGirl.create(:house)
      member1 = FactoryGirl.create(:member, :house => house)
      member2 = FactoryGirl.create(:member, :house => house, :email => "foo#{rand(10)}@bar.com")
      member3 = FactoryGirl.create(:member, :house => house, :email => "foo#{rand(10)}@bar.com")
      sign_in member1
      get :index
      assigns(:members).should eq([member2, member3])
    end

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
  end

end
