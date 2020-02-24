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

end
