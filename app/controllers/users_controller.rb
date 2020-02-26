class UsersController < ApplicationController

    get '/users/signup' do
        erb :'users/signup'
    end

    post '/users/signup' do
        @user = User.create(params)
        if params[:name].blank? || params[:email].blank? || params[:password].blank?
            flash[:error] = "Please fill in all fields to sign up."
            redirect '/users/signup'
        elsif @user.valid?
            session[:user_id] = @user.id
            redirect to "/users/#{@user.id}"
        else
            flash[:error] = "User already exists, please log in."
            redirect to '/users/login'
        end
      
    end
    
    get '/users/login' do
        erb :'users/login'
    end

    post '/users/login' do
        if !@user = User.find_by(:email => params["email"])
            flash[:error] = "User does not exist, please sign up!"
            redirect to '/users/signup'
        elsif @user && @user.authenticate(params["password"])
            session[:user_id] = @user.id
            redirect to "/users/#{@user.id}"
        else
            flash[:error] = "Incorrect email or password, please try again."
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
