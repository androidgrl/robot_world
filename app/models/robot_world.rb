require 'yaml/store'

class RobotWorld
  def self.database
    if ENV["ROBOT_WORLD_ENV"] == 'test'
      @database ||= Sequel.sqlite("db/robot_world_test.sqlite3")
    else
      @database ||= Sequel.sqlite("db/robot_world.sqlite3")
    end
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

  def self.raw_robot(id)
    raw_robots.find do |robot|
      robot["id"] == id
    end
  end

  def self.find(id)
    Robot.new(raw_robot(id))
  end

  def self.update(id, data)
    database.transaction do
      target = database["robots"].find { |robot| robot["id"] == id }
      target["name"] = data["name"]
      target["city"] = data["city"]
      target["state"] = data["state"]
      target["birthday"] = data["birthday"]
      target["date_hired"] = data["date_hired"]
      target["department"] = data["department"]
    end
  end

  def self.destroy(id)
    database.transaction do
      database['robots'].delete_if { |task| task["id"] == id }
    end
  end

  def self.delete_all
    database.transaction do
      database["robots"] = []
      database["total"] = 0
    end
  end
end
