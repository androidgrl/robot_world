class RobotWorldApp < Sinatra::Base
  set :root, File.join(File.dirname(__FILE__), "..")

  get '/' do
    "Hello Robot World!"
  end
end
