require_relative "../test_helper"

class UserCreatesRobotTest < FeatureTest
  def test_user_creates_a_robot
    visit "/"
    click_link("Create New Robot Profile")
    fill_in("robot[name]", with: "Benny")
    fill_in("robot[city]", with: "Oxford")
    fill_in("robot[state]", with: "England")
    fill_in("robot[birthday]", with: "New Year's Eve")
    fill_in("robot[date_hired]", with: "Christmas")
    fill_in("robot[department]", with: "Medical")
    click_on("submit")
    assert_equal "/robots", current_path
    within("#robots") do
      assert page.has_content?("Benny")
      assert page.has_content?("Medical")
    end
  end
end
