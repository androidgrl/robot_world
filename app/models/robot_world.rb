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
    if robot[:name] == ""
      dataset.insert({  name: Faker::Name.name,
                        city: Faker::Address.city,
                        state: Faker::Address.state,
                        birthday: Faker::Date.backward(15000),
                        date_hired: Faker::Date.backward(1500),
                        department: Faker::Commerce.department
      })
    else
      dataset.insert(robot)
    end
  end

  def self.all
    dataset.select.to_a.map {|data| Robot.new(data)}
  end

  def self.find(id)
    robot = dataset.where(id: id)
    Robot.new(robot.to_a.first)
  end

  def self.update(id, data)
    dataset.where(id: id).update(data)
  end

  def self.destroy(id)
    dataset.where(id: id).delete
  end

  def self.delete_all
    dataset.delete
  end

  def self.average_age
    if dataset.select.to_a.any?
      birthday_years = dataset.select(:birthday).to_a.map { |row| row[:birthday][0..3] }
      average_birthyear = birthday_years.map(&:to_i).reduce(:+) / birthday_years.length
      average_age = 2015 - average_birthyear
    else
      "No profiles available"
    end
  end

  def self.dataset
    database.from(:robots)
  end
end
