require 'spec_helper'

describe "houses/edit" do
  before(:each) do
    @house = assign(:house, stub_model(House,
      :name => "MyString"
    ))
  end

  it "renders the edit house form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", house_path(@house), "post" do
      assert_select "input#house_name[name=?]", "house[name]"
    end
  end
end
