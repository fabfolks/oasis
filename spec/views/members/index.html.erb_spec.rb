require 'spec_helper'

describe "members/index" do
  before(:each) do
    assign(:members, [
      stub_model(Member,
        :name => "Name",
        :sex => "Sex",
        :contact_no => "Contact No",
        :role => "Role",
        :email => "Email",
        :blood_group => "Blood Group"
      ),
      stub_model(Member,
        :name => "Name",
        :sex => "Sex",
        :contact_no => "Contact No",
        :role => "Role",
        :email => "Email",
        :blood_group => "Blood Group"
      )
    ])
  end

  it "renders a list of members" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Sex".to_s, :count => 2
    assert_select "tr>td", :text => "Contact No".to_s, :count => 2
    assert_select "tr>td", :text => "Role".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Blood Group".to_s, :count => 2
  end
end
