class ActivitiesController < ApplicationController

    get '/activities/new' do 
        if !logged_in?
            flash[:error] = "You must be logged in to create an activity."
            redirect '/users/login'
        else
            erb :'activities/new'
        end
    end

    post '/activities/new' do
        @existing_activity = Activity.find_by(:title => params[:title])
        @dependent = Dependent.find_by(:name => params[:dependent_name])

        if @existing_activity && @existing_activity.dependent_id == @dependent.id        
            flash[:error] = "Activity already exists for this dependent."
            redirect "/dependents/#{@dependent.id}"
        else
            @new_activity = @dependent.activities.build(params)
            if @new_activity.save
                redirect "/dependents/#{@dependent.id}"
            else
                flash[:error] = "Dependent Name and Activity Title must be filled in to create an activity."
                redirect to "/activities/new"
            end
        end
    end

    get '/activities/:id' do
        @activity = Activity.find_by(:id => params[:id])
        erb :'activities/show'
    end

    get '/activities/:id/edit' do
        @user = current_user
        @activity = Activity.find_by(:id => params[:id])

        if !logged_in?
            flash[:error] = "You must be logged in to edit an activity."
            redirect '/users/login'
        elsif !current_user.dependents.include?(@dependent)
            flash[:error] = "You cannot edit activities that do not belong to you."
            redirect to "/users/#{@user.id}"
        else
            @activity = Activity.find_by(:id => params[:id])
            erb :'activities/edit'
        end
    end
    
    patch '/activities/:id' do
        @activity = Activity.find_by(:id => params[:id])
        @dependent = @activity.dependent

        if params[:title].empty? || params[:dependent_name].empty?
            flash[:error] = "Dependent Name and Activity Title must be filled in to edit an activity."
            redirect to "/activities/#{@activity.id}/edit"
        else
            @activity.update(params[:activity])
            redirect to "/dependents/#{@dependent.id}"
        end
    end
    
    delete '/activities/:id/delete' do
        @activity = Activity.find_by(:id => params[:id])
        @dependent = @activity.dependent
        @user_activity = current_user.activities.find_by(params[:id])

        if !logged_in?
            flash[:log_in_to_delete_activity] = "You need to be logged in to delete an activity."
            redirect '/users/login'
        elsif !current_user.dependents.include?(@dependent)
            flash[:log_in_to_delete_dependent] = "You cannot delete an activity that doesn't belong to you."
            redirect to "/users/#{@user.id}"
        else
            @activity.delete
            @user_activity.delete
            redirect to "/dependents/#{@dependent.id}"
        end

    end

end
