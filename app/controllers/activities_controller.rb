class ActivitiesController < ApplicationController

    get '/activities/new' do 
        erb :'activities/new'
    end

    post '/activities/new' do
        @activity = Activity.create(params)
        @dependent = Dependent.find_by(:name => params[:dependent_name])

        @activity.dependent = @dependent
        @dependent.activities << @activity

        @user_activity = UserActivity.new 
        @user_activity.user_id = current_user.id 
        @user_activity.activity_id = @activity.id
        @user_activity.save

        redirect "/dependents/#{@activity.dependent.id}"
    end

    get '/activities/:id' do
        @activity = Activity.find_by(:id => params[:id])
        erb :'activities/show'
    end

    get '/activities/:id/edit' do
        if !logged_in?
            redirect '/users/login'
        end
    
        @activity = Activity.find_by(:id => params[:id])
        erb :'activities/edit'
    end
    
    patch '/activities/:id' do
        @activity = Activity.find_by(:id => params[:id])
        @user = current_user
        @user_activity = UserActivity.find_by(:activity_id => params[:id])
    
        if @user.id != @user_activity.user_id
            redirect to "/users/#{@user.id}"
        else
            @activity.update(params[:activity])
            @dependent = @activity.dependent
            binding.pry
            redirect to "/dependents/#{@dependent.id}"
        end
    end
    
    delete '/activities/:id/delete' do
        if logged_in? 
            @activity = UserActivities.find_by(:activity_id => params[:id])
            @user = current_user
    
            if @user.id == @activity.user_id
                @dependent.delete
                redirect to "/users/#{@user.id}"
            end
    
        else
            redirect to '/users/login'
        end
    end

end
