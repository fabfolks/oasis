require 'spec_helper'

describe Member do
  before :each do
    @house = FactoryGirl.create(:house)
  end

  describe 'is_admin' do
    it 'should return true is role on the member is admin' do
      admin_member = FactoryGirl.create :member, :role => 'admin', :house => @house
      non_admin_member = FactoryGirl.create :member, :email => "foo#{rand(10)}@bar.com", :house => @house, :username => 'foo123'
      expect(admin_member.is_admin?).to eq(true)
      expect(non_admin_member.is_admin?).to eq(false)
    end
  end

  describe 'is_member_of?' do
    it 'should return true if given house name is equal to house name of member' do
      house = FactoryGirl.create(:house, :name => 'name')
      another_house = FactoryGirl.create(:house, :name => 'another_name')
      member = FactoryGirl.create(:member, :house => house)
      another_member = FactoryGirl.create(:member, :house => another_house, :email => "foo#{rand(10)}@bar.com", :username => "foo#{rand(10)}")
      expect(member.is_member_of? house).should be true
      expect(another_member.is_member_of? house).should be false
    end
  end
end
