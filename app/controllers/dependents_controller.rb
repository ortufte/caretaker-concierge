class DependentsController < ApplicationController

    get '/dependents/new' do 
        erb :'dependents/new'
    end

    post '/dependents/new' do
        @dependent = Dependent.create(params)
        @dependent.user_id = current_user.id 
        redirect "/dependents/#{@dependent.id}"
    end

    get '/dependents/:id' do
        @dependent = Dependent.find_by(:id => params[:id])
        erb :'dependents/show'
    end

    get '/dependents/:id/edit' do
        if !logged_in?
            redirect '/users/login'
        end

        @dependent = Dependent.find_by(:id => params[:id])
        erb :'dependents/edit'
    end

    patch '/dependents/:id' do
        @dependent = Dependent.find_by(:id => params[:id])
        @user = current_user

        if params["name"].empty?
            redirect to "/dependents/#{@dependent.id}/edit"
        elsif
            @user.id != @dependent.user_id
            redirect to "/users/#{@user.id}"
        else
            @dependent.name = params["name"]
            @dependent.activities.all.each do |a|
                a.dependent_name = params["name"]
                a.save
            end

            @dependent.save
            redirect to "/dependents/#{@dependent.id}"
        end
    end

    delete '/dependents/:id/delete' do

        if logged_in? 
            @dependent = Dependent.find_by(:id => params[:id])
            @user = current_user

            if @user.id == @dependent.user_id
                @dependent.delete
                redirect to "/users/#{@user.id}"
            end

        else
            redirect to '/users/login'
        end

    end

end
