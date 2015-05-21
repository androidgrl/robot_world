require_relative '../test_helper'

class RobotWorldTest < Minitest::Test
  def create_robots(num)
    1.upto(num) do |x|
      data = {  "id" => "#{x}",
                "name" => "robot#{x}",
                "city" => "city#{x}",
                "state" => "state#{x}",
                "birthday" => "birthday#{x}",
                "date_hired" => "date_hired#{x}",
                "department" => "department#{x}"
               }
      RobotWorld.create(data)
    end
  end

  def test_it_creates_a_robot
    create_robots(1)
    assert_equal 1, RobotWorld.all.count
    assert_equal 1, RobotWorld.all.first.id
    assert_equal "robot1", RobotWorld.all.first.name
  end

  def test_it_finds_a_robot
    create_robots(3)

    robot = RobotWorld.find(2)

    assert_equal "robot2", robot.name
  end

  def test_it_finds_all_robots
    create_robots(3)

    assert_equal 3, RobotWorld.all.count
    assert_equal ["robot1", "robot2", "robot3"], RobotWorld.all.map(&:name)
  end

  def test_it_updates_a_robot
    data = {
      "name" => "robot5",
      "city" => "city5",
      "state" => "state5",
      "birthday" => "birthday5",
      "date_hired" => "date_hired5",
      "department" => "department5"
    }
    create_robots(1)

    RobotWorld.update(1, data)
    robot = RobotWorld.find(1)

    assert_equal "robot5", robot.name
  end

  def test_it_deletes_a_robot
    create_robots(1)

    RobotWorld.destroy(1)

    assert_equal 0, RobotWorld.all.count
  end
end
