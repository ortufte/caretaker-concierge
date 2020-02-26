class ActivitiesController < ApplicationController

    get '/activities/new' do 
        erb :'activities/new'
    end

    post '/activities/new' do
        @activity = Activity.create(params)
        @dependent = Dependent.find_by(:name => params[:dependent_name])
        @activity.dependent = @dependent
        @dependent.activities << @activity
        current_user.activities << @activity
        redirect "/dependents/#{@dependent.id}"
    end

    get '/activities/:id' do
        @activity = Activity.find_by(:id => params[:id])
        erb :'activities/show'
    end

    get '/activities/:id/edit' do
        if !logged_in?
            redirect '/users/login'
        else
            @activity = Activity.find_by(:id => params[:id])
            erb :'activities/edit'
        end
    end
    
    patch '/activities/:id' do
        @activity = Activity.find_by(:id => params[:id])
        @dependent = @activity.dependent
        @user_activity = current_user.activities.find_by(params[:id])

        if current_user.dependents.include?(@dependent)
            @activity.update(params[:activity])
            redirect to "/dependents/#{@dependent.id}"
        else
            redirect to "/users/#{@user.id}"
        end
    end
    
    delete '/activities/:id/delete' do
        if !logged_in?
            redirect '/users/login'
        else
            @activity = Activity.find_by(:id => params[:id])
            @dependent = @activity.dependent
            @user_activity = current_user.activities.find_by(params[:id])

            if current_user.dependents.include?(@dependent)
                @activity.delete
                @user_activity.delete
                redirect to "/dependents/#{@dependent.id}"
            else
                redirect to "/users/#{@user.id}"
            end
        end

    end

end
