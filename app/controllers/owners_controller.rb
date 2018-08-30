class OwnersController < ApplicationController

  get '/owners' do #READ
    @owners = Owner.all
    erb :'/owners/index'
  end

  get '/owners/new' do #CREATE
    @pets = Pet.all #get all pets of owner
    erb :'/owners/new'
  end

  post '/owners' do #CREATE
    @owner = Owner.create(params[:owner])
    #assign pet/created pet to owner
    if !params[:pet][:name].empty?
      @owner.pets << Pet.create(name: params[:pet][:name])
    end
    @owner.save
    redirect "owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do #UPDATE
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :'/owners/edit'
  end


  get '/owners/:id' do #READ
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  patch '/owners/:id' do #UPDATE
    @owner = Owner.find(params[:id])
    @owner.update(params[:owner])
    if !params[:pet][:name].empty?
      @owner.pets << Pet.create(name: params[:pet][:name])
    end
    redirect to "owners/#{@owner.id}"
  end


end
