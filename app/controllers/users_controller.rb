class UsersController < ApplicationController

    get '/login' do
        #if self.current_user
            #redirect '/users/:id'
        #else
        erb :'users/login'
        #end
    end

    post '/login' do
        @user = User.find_by(:username => params["username"])
        @dependents = @user.dependents
        session[:user_id] = @user.id
        redirect '/users/:id'
    end

    get '/users/:id' do
        @user = User.find_by_id(params["id"])
        erb :'/users/show'
    end


end
