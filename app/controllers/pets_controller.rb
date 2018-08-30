class PetsController < ApplicationController

  get '/pets' do #READ
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do  #CREATE
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do #CREATE
    @pet = Pet.create(params[:pet])
    if !params[:owner][:name].empty?
      @pet.update(owner_id:Owner.create(name: params[:owner][:name]).id)
    end
    redirect to "/pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do #UPDATE
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do #READ
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do #UPDATE
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
    end
    # binding.pry
    redirect to "/pets/#{@pet.id}"
  end


end
