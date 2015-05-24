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
      average_age = (2015 - average_birthyear).floor
    else
      "No profiles available"
    end
  end

  def self.hired_per_year
    hire_dates = dataset.select(:date_hired).to_a.map { |row| row[:date_hired][0..3] }.map(&:to_i)
    sorted_by_years = hire_dates.each_with_object(Hash.new(0)) do |year, hash|
      hash[year] += 1
    end
  end

  def self.per_department
    departments = dataset.select(:department).to_a.map { |row| row[:department] }
    sorted_by_department = departments.each_with_object(Hash.new(0)) do |dept, hash|
      hash[dept] += 1
    end
  end

  def self.per_state
    states = dataset.select(:state).to_a.map { |row| row[:state] }
    sorted_by_state = states.each_with_object(Hash.new(0)) do |state, hash|
      hash[state] += 1
    end
  end

  def self.per_city
    cities = dataset.select(:city).to_a.map { |row| row[:city] }
    sorted_by_city = cities.each_with_object(Hash.new(0)) do |city, hash|
      hash[city] += 1
    end
  end

  def self.dataset
    database.from(:robots)
  end


end
