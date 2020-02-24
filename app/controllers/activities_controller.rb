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

    
end
