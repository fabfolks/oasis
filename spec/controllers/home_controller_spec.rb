require 'spec_helper'

describe HomeController do
  describe 'index' do
    describe 'signed in member' do
      it 'redirect to notifications url' do
        house = FactoryGirl.create(:house)
        member1 = FactoryGirl.create(:member, :house => house)
        sign_in member1
        get :index
        response.should redirect_to(notifications_url)
      end
    end
  end
end
