require_relative "../test_helper"

class UserDeleteRobotTest < FeatureTest
  def test_user_delete_robot
    RobotWorld.create(
              "name" => "Billie",
              "city" => "Chicago",
              "state" => "Illinois",
              "birthday" => "2/26/77",
              "date_hired" => "2/26/16",
              "department" => "neon warfare")
    visit '/robots'
    click_on("Delete")
    within("#robots") do
      refute page.has_content?("Billie")
    end
  end
end
