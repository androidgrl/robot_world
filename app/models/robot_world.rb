require 'yaml/store'
require_relative 'robot'

class RobotWorld
  def self.database
    @database ||= YAML::Store.new("db/robot_world")
  end

  def self.create(robot)
    database.transaction do
      database["robots"] ||= []
      database["total"] ||= 0
      database["total"] += 1
      database["robots"] << { "id" => database["total"],
                              "name" => robot["name"],
                              "city" => robot["city"],
                              "state" => robot["state"],
                              "birthday" => robot["birthday"],
                              "date_hired" => robot["date_hired"],
                              "department" => robot["department"]
      }
    end
  end

  def self.all
    raw_robots.map { |data| Robot.new(data) }
  end

  def self.raw_robots
    database.transaction do
      database["robots"] || []
    end
  end
end
