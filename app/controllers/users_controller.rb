class UsersController < ApplicationController

    get '/users/signup' do
        erb :'users/signup'
    end

    post '/users/signup' do
        @user = User.create(params)
        session[:user_id] = @user.id
        redirect "/users/#{@user.id}"
    end
    
    get '/users/login' do
        erb :'users/login'
    end

    post '/users/login' do
        @user = User.find_by(:email => params["email"])
        if @user.authenticate(params["password"])
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
        else
            #tell the user they entered the incorrect credentials
            redirect '/users/login'
        end
    end

    get '/users/logout' do
        session.clear
        redirect '/'
    end

    get '/users/:id' do
        @user = User.find_by(:id => params[:id])
        erb :'users/show'
    end

end
