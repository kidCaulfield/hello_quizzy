require 'rails_helper'

RSpec.describe "scores/index", type: :view do
  before(:each) do
    assign(:scores, [
      Score.create!(
        :quiz => nil,
        :user => nil
      ),
      Score.create!(
        :quiz => nil,
        :user => nil
      )
    ])
  end

  it "renders a list of scores" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
