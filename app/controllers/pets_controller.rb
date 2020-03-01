class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @pet = Pet.create(params) 
    erb :'/pets/new'
  end

  post '/pets/new' do 
    @pet = Pet.create(params[:pet]) 
       if !params[:owner][:name].empty? 
         @pet.owner << Owner.create(name: params[:owner][:name]) 
       end 

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end
  
  get '/pets/:id/edit' do 
    @pet = Pet.find_by_id(params[:id]) 
    @owners = Owner.all 
        erb :'/pets/edit' 
  end 

  patch '/pets/:id/edit' do
    ###### bug fix 
       if !params[:pet].keys.include?(:owner_ids)
         params[:pet][:owner_id]=[] 
       end 
    ######
    
    @pet = Pet.find(params[:id]) 
    @pet.update(params["pet"]) 
    
    if !params[:owner][:name].empty? 
       @pet.owner << Owner.create(name: params[:owner][:name]) 
    end 

    redirect to "pets/#{@pet.id}"
  end
end