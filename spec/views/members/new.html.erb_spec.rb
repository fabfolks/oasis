require 'spec_helper'

describe "members/new" do
  before(:each) do
    assign(:member, stub_model(Member,
      :name => "MyString",
      :sex => "MyString",
      :contact_no => "MyString",
      :role => "MyString",
      :email => "MyString",
      :blood_group => "MyString"
    ).as_new_record)
  end

  it "renders new member form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", members_path, "post" do
      assert_select "input#member_name[name=?]", "member[name]"
      assert_select "input#member_sex[name=?]", "member[sex]"
      assert_select "input#member_contact_no[name=?]", "member[contact_no]"
      assert_select "input#member_role[name=?]", "member[role]"
      assert_select "input#member_email[name=?]", "member[email]"
      assert_select "input#member_blood_group[name=?]", "member[blood_group]"
    end
  end
end
