require 'spec_helper'

describe "members/show" do
  before(:each) do
    @member = assign(:member, stub_model(Member,
      :name => "Name",
      :sex => "Sex",
      :contact_no => "Contact No",
      :role => "Role",
      :email => "Email",
      :blood_group => "Blood Group"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Sex/)
    rendered.should match(/Contact No/)
    rendered.should match(/Email/)
    rendered.should match(/Blood Group/)
  end
end
