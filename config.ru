require 'bundler'
Bundler.require

#$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/app"))

#require 'controllers/robot_world_app'
require ::File.expand_path('../config/environment', __FILE__)

run RobotWorldApp
