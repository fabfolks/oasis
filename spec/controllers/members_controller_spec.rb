require 'spec_helper'
describe MembersController do

  # This should return the minimal set of attributes required to create a valid
  # Member. As you add validations to Member, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { 'name' => 'MyString', 'email' => 'foo@bar.com', 'password' => 'password', 'password_confirmation' => 'password' } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MembersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all members as @members" do
      house1 = FactoryGirl.create(:house)
      house2 = FactoryGirl.create(:house, :name => 'other_house')
      member1 = FactoryGirl.create(:member, :house => house1)
      member2 = FactoryGirl.create(:member, :email => "foo#{rand(10)}@bar.com", :house => house1)
      member3 = FactoryGirl.create(:member, :email => "foo#{rand(10)}@bar.com", :house => house2)
      sign_in member1
      get :index
      assigns(:members).should eq([member1, member2])
    end
  end

  describe "GET show" do
    it "assigns the requested member as @member" do
      member = FactoryGirl.create(:member)
      sign_in member
      get :show, {:id => member.to_param}
      assigns(:member).should eq(member)
    end
  end

  describe "GET new" do
    describe 'admin member' do
      it "assigns a new member as @member for admin" do
        sign_in FactoryGirl.create(:member, :role => 'admin')
        get :new, {}
        assigns(:member).should be_a_new(Member)
      end

      it "assigns a new member as @member for admin" do
        sign_in FactoryGirl.create(:member, :role => 'admin')
        get :new, {}
        assigns(:member).should be_a_new(Member)
      end
    end
    describe 'non-admin member' do
      it "assigns a new member as @member for admin" do
        sign_in FactoryGirl.create(:member)
        get :new, {}
        response.should redirect_to new_member_session_path
      end
    end
  end

  describe "GET edit" do
    it "assigns the requested member as @member" do
      member = FactoryGirl.create(:member)
      sign_in member
      get :edit, {:id => member.to_param}
      assigns(:member).should eq(member)
    end
  end

  describe "POST create" do
    describe "admin member" do
      it "creates a new Member" do
        member = FactoryGirl.create(:member, :role => 'admin')
        house = FactoryGirl.create(:house)
        member.house = house
        sign_in member
        expect {
          post :create, {:member => {:email => "foo#{rand(10)}@bar.com", :password => 'password', :password_confirmation => 'password'}}
        }.to change(Member, :count).by(1)
      end

      it "assigns a newly created member as @member" do
        member = FactoryGirl.create(:member, :role => 'admin')
        sign_in member
        post :create, {:member => {:email => "foo#{rand(10)}@bar.com", :password => 'password', :password_confirmation => 'password'}}
        assigns(:member).should be_a(Member)
        assigns(:member).should be_persisted
      end

      it "redirects to the created member" do
        member = FactoryGirl.create(:member, :role => 'admin')
        sign_in member
        post :create, {:member => {:email => "foo#{rand(10)}@bar.com", :password => 'password', :password_confirmation => 'password'}}
        response.should redirect_to(Member.last)
      end
    end

    describe "non-admin member" do
      it "assigns a newly created but unsaved member as @member" do
        # Trigger the behavior that occurs when invalid params are submitted
        member = FactoryGirl.create(:member)
        sign_in member
        post :create, {:member => {:email => "foo#{rand(10)}@bar.com", :password => 'password', :password_confirmation => 'password'}}
        expect(Member.count).to be 1
        response.should redirect_to(new_member_session_path)
      end
    end
  end

  describe "PUT update" do
    describe "with logged in member" do
      it "updates the requested member" do
        member = FactoryGirl.create(:member)
        sign_in member
        # Assuming there are no other members in the database, this
        # specifies that the Member created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Member.any_instance.should_receive(:update_attributes).with({ "name" => "MyString" })
        put :update, {:id => member.to_param, :member => { "name" => "MyString" }}
      end

      it "assigns the requested member as @member" do
        member = FactoryGirl.create(:member)
        sign_in member
        put :update, {:id => member.to_param, :member => valid_attributes}
        assigns(:member).should eq(member)
      end

      it "redirects to the member" do
        member = FactoryGirl.create(:member)
        sign_in member
        put :update, {:id => member.to_param, :member => valid_attributes}
        response.should redirect_to(member)
      end
    end

    describe "with non-logged in member" do
      it "redirect to new member session path" do
        member = FactoryGirl.create(:member)
        sign_in nil
        # Trigger the behavior that occurs when invalid params are submitted
        Member.any_instance.stub(:save).and_return(false)
        put :update, {:id => member.to_param, :member => { "name" => "other value" }}
        response.should redirect_to(new_member_session_path)
      end
    end
  end

  describe "DELETE destroy" do
    describe "admin member" do
      it "destroys the requested member" do
        house = FactoryGirl.create(:house)
        member = FactoryGirl.create(:member, :role => 'admin', :house => house)
        sign_in member
        expect {
          delete :destroy, {:id => member.to_param}, valid_session
        }.to change(Member, :count).by(-1)
      end

      it "redirects to the members list" do
        house = FactoryGirl.create(:house)
        member = FactoryGirl.create(:member, :role => 'admin', :house => house)
        sign_in member
        delete :destroy, {:id => member.to_param}, valid_session
        response.should redirect_to(members_url)
      end

      it "destroys the requested member of same house" do
        house = FactoryGirl.create(:house)
        member = FactoryGirl.create(:member, :role => 'admin', :house => house)
        member1 = FactoryGirl.create(:member, :house => house, :email => "foo#{rand(10)}@bar.com", :password => 'password', :password_confirmation => 'password')
        sign_in member
        expect {
          delete :destroy, {:id => member1.to_param}, valid_session
        }.to change(Member, :count).by(-1)
      end

      it "should not destroy the requested member of other house" do
        house = FactoryGirl.create(:house)
        other_house = FactoryGirl.create(:house, :name => 'other_house')
        member = FactoryGirl.create(:member, :role => 'admin', :house => house)
        member1 = FactoryGirl.create(:member, :house => other_house, :email => "foo#{rand(10)}@bar.com", :password => 'password', :password_confirmation => 'password')
        sign_in member

        delete :destroy, {:id => member1.to_param}
        response.should redirect_to(new_member_session_path)
      end
    end

    describe "non-admin member" do
      it "should not destroy the requested member" do
        house = FactoryGirl.create(:house)
        member = FactoryGirl.create(:member, :house => house)
        sign_in member
        expect {
          delete :destroy, {:id => member.to_param}, valid_session
        }.to change(Member, :count).by(0)
      end
    end

    describe "non-logged-in member" do
      it "should not destroy the requested member" do
        house = FactoryGirl.create(:house)
        member = FactoryGirl.create(:member, :house => house)
        sign_in nil
        delete :destroy, {:id => member.to_param}, valid_session
        response.should redirect_to(new_member_session_path)
      end
    end
  end
end
