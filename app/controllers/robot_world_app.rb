class RobotWorldApp < Sinatra::Base
  set :root, File.join(File.dirname(__FILE__), "..")

  get '/' do
    average_age = RobotWorld.average_age
    hired_per_year = RobotWorld.hired_per_year
    per_department = RobotWorld.per_department
    per_state = RobotWorld.per_state
    per_city = RobotWorld.per_city
    erb :dashboard, :locals => { :average_age => average_age,
                                 :hired_per_year => hired_per_year,
                                 :per_department => per_department,
                                 :per_state => per_state,
                                 :per_city => per_city }
  end

  get '/robots' do
    robots = RobotWorld.all
    erb :index, :locals => {:robots => robots}
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

