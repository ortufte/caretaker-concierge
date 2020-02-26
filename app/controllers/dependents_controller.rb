class DependentsController < ApplicationController

    get '/dependents/new' do 
        if !logged_in?
            flash[:error] = "You need to be logged in to create a dependent"
            redirect '/users/login'
        else
            erb :'dependents/new'
        end
    end

    post '/dependents/new' do
        @existing_dependent = Dependent.find_by(:name => params[:name])

        if @existing_dependent && @existing_dependent.user_id == current_user.id        
            flash[:error] = "Dependent already exists."
            redirect "/users/#{current_user.id}"
        elsif params[:name].empty? 
            flash[:error] = "Dependent Name and must be filled in to create a dependent."
            redirect to "/dependents/new"
        else
            @dependent = Dependent.create(params)
            @dependent.user_id = current_user.id
            current_user.dependents << @dependent
            redirect "/dependents/#{@dependent.id}"
        end

    end

    get '/dependents/:id' do
        @dependent = Dependent.find_by(:id => params[:id])
        erb :'dependents/show'
    end

    get '/dependents/:id/edit' do
        @user = current_user
        @dependent = Dependent.find_by(:id => params[:id])

        if !logged_in?
            flash[:error] = "You need to be logged in to edit a dependent"
            redirect '/users/login'
        elsif
            @user.id != @dependent.user_id
            flash[:error] = "You cannot edit dependents that do not belong to you."
            redirect to "/users/#{@user.id}"
        else
            erb :'dependents/edit'
        end

    end

    patch '/dependents/:id' do
        @dependent = Dependent.find_by(:id => params[:id])
        @user = current_user

        if params["name"].empty?
            redirect to "/dependents/#{@dependent.id}/edit"
        else
            @dependent.name = params["name"]
            @dependent.activities.all.each do |a|
                a.dependent_name = params["name"]
                a.save
            end

            @dependent.save
            redirect "/dependents/#{@dependent.id}"
        end

    end

    delete '/dependents/:id/delete' do
        @dependent = Dependent.find_by(:id => params[:id])
        @user = current_user

        if !logged_in? 
            flash[:error] = "You need to be logged in to delete a dependent."
            redirect '/users/login'
        elsif @user.id != @dependent.user_id
            flash[:error] = "You cannot delete a dependent that does not belong to you."
            redirect "/users/#{@user.id}"
        else
            @dependent.delete
            redirect "/users/#{@user.id}"
        end

    end

end
