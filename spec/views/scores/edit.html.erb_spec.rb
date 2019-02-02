require 'rails_helper'

RSpec.describe "scores/edit", type: :view do
  before(:each) do
    @score = assign(:score, Score.create!(
      :quiz => nil,
      :user => nil
    ))
  end

  it "renders the edit score form" do
    render

    assert_select "form[action=?][method=?]", score_path(@score), "post" do

      assert_select "input[name=?]", "score[quiz_id]"

      assert_select "input[name=?]", "score[user_id]"
    end
  end
end
