require 'rails_helper'

RSpec.describe "scores/new", type: :view do
  before(:each) do
    assign(:score, Score.new(
      :quiz => nil,
      :user => nil
    ))
  end

  it "renders new score form" do
    render

    assert_select "form[action=?][method=?]", scores_path, "post" do

      assert_select "input[name=?]", "score[quiz_id]"

      assert_select "input[name=?]", "score[user_id]"
    end
  end
end
