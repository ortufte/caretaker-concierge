class ActivitiesController < ApplicationController

    get '/activities/new' do 
        erb :'activities/new'
    end


end
