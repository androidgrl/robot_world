require_relative "../test_helper"

class UserEditRobotTest < FeatureTest
  def test_user_edits_robot
    RobotWorld.create(
              "name" => "Billie",
              "city" => "Chicago",
              "state" => "Illinois",
              "birthday" => "2/26/77",
              "date_hired" => "2/26/16",
              "department" => "neon warfare")
    visit '/robots'
    click_on("Edit")
    fill_in("robot[name]", with: "Joon")
    click_on("submit")
    assert_equal "/robots/1", current_path
    within("#robot") do
      assert page.has_content?("Joon")
    end
  end
end
