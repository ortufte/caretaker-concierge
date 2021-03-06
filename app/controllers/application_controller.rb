require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "organizeyourlife"
    register Sinatra::Flash
  end

  get '/' do
      erb :index
  end

  helpers do 
    
    def logged_in?
      !!session[:user_id] #or !!current_user
    end

    def current_user
      @current_user ||= User.find_by(:id => session[:user_id])
    end

  end 

end
