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

  def test_it_finds_the_average_age
    RobotWorld.create({:birthday => "2009-4-20"})
    RobotWorld.create({:birthday => "2015-4-20"})

    assert_equal 3, RobotWorld.average_age
  end

  def test_it_finds_robots_hired_per_year
    RobotWorld.create({:name => "Hello", :date_hired => "2014-9-09"})
    RobotWorld.create({:name => "Hello", :date_hired => "2014-9-09"})

    assert_equal [[2014, 2]], RobotWorld.hired_per_year.to_a
  end

  def test_it_finds_robots_per_department
    RobotWorld.create({:name => "Hello", :department => "maintenance"})
    RobotWorld.create({:name => "Hello", :department => "catering"})

    assert_equal [["maintenance", 1], ["catering", 1]], RobotWorld.per_department.to_a
  end

  def test_it_finds_robots_per_state
    RobotWorld.create({:name => "Hello", :state => "CA"})
    RobotWorld.create({:name => "Hello", :state => "CA"})
    RobotWorld.create({:name => "Hello", :state => "NY"})

    assert_equal [["CA", 2], ["NY", 1]], RobotWorld.per_state.to_a
  end

  def test_it_finds_robots_per_city
    RobotWorld.create({:name => "Hello", :city => "Pleasanton"})
    RobotWorld.create({:name => "Hello", :city => "Denver"})
    RobotWorld.create({:name => "Hello", :city => "Denver"})

    assert_equal [["Pleasanton", 1], ["Denver", 2]], RobotWorld.per_city.to_a
  end
end
