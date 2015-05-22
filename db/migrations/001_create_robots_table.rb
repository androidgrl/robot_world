require 'sequel'
require_relative '../../app/models/robot_world'

RobotWorld.database.create_table(:robots) do
  primary_key :id
  String :name
  String :city
  String :state
  String :birthday
  String :date_hired
  String :department
end
