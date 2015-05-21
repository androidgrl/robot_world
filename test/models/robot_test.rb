require_relative '../test_helper'

class RobotTest < Minitest::Test
  def test_it_assigns_attributes_correctly
    robot = Robot.new("id" => "1",
              "name" => "Billie",
              "city" => "Chicago",
              "state" => "Illinois",
              "birthday" => "2/26/77",
              "date_hired" => "2/26/16",
              "department" => "neon warfare")
    assert_equal "1", robot.id
    assert_equal "Billie", robot.name
    assert_equal "Chicago", robot.city
    assert_equal "Illinois", robot.state
    assert_equal "2/26/77", robot.birthday
    assert_equal "2/26/16", robot.date_hired
    assert_equal "neon warfare", robot.department
  end
end
