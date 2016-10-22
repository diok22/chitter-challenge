ENV["RACK_ENV"] ||= 'development'
require 'sinatra/base'
require_relative 'data_mapper_setup'

class Chitter < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    'Hello Chitter!'
  end

  get '/users/new' do
  erb :'users/new'
end

post '/users' do
  user = User.new(user_name: params[:user_name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
  if user.save
    session[:user_id] = user.id
    @status = 'match'
    redirect '/links'
  else
    redirect '/users/new'
  end
end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
