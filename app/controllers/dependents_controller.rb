class DependentsController < ApplicationController

get '/dependents/new' do 
    erb :'dependents/new'
end

post '/dependents/new' do
    @dependent = Dependent.create(params)
    @dependent.user_id = current_user.id 
    redirect '/activities/new'
end

end
