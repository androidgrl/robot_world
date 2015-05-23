class RobotWorldApp < Sinatra::Base
  set :root, File.join(File.dirname(__FILE__), "..")

  get '/' do
    erb :dashboard
  end

  get '/robots' do
    robots = RobotWorld.all
    average_age = 2
    erb :index, :locals => {:robots => robots, :average_age => average_age}
  end

  get '/robots/new' do
    erb :new
  end

  post '/robots' do
    RobotWorld.create(params[:robot])
    redirect '/robots'
  end

  get '/robots/:id' do |id|
    @robot = RobotWorld.find(id.to_i)
    erb :show
  end

  get '/robots/:id/edit' do |id|
    @robot = RobotWorld.find(id.to_i)
    erb :edit
  end

  put '/robots/:id' do |id|
    RobotWorld.update(id.to_i, params[:robot])
    redirect "/robots/#{id}"
  end

  delete '/robots/:id' do |id|
    RobotWorld.destroy(id.to_i)
    redirect "/robots"
  end
end

