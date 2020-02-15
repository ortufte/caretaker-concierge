class UsersController < Sinatra::Base

    get '/login' do
        if current_user
            redirect '/users/:id'
        else
        erb :login
        end
    end

    post '/login' do
        @user = User.find_by(:username => params["username"])
        session[:user_id] = @user.id
        redirect '/users/:id'
    end

    get '/users/:id' do
        @user = User.find_by_id(params["id"])
        erb :'/users/show'
    end


end
