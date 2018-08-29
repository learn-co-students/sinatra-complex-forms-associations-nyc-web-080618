class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  patch '/owners/:id' do
  @owner = Owner.find(params[:id])
  @owner.update(params["owner"])
  if !params["pet"]["name"].empty?
    @owner.pets << Pet.create(name: params["pet"]["name"])
  end
  redirect to "owners/#{@owner.id}"
 end

 patch '/pets/:id' do
 @pet = Pet.find(params[:id])
 @pet.update(params["pet"])
 if !params["owner"]["name"].empty?
   @owner=Owner.create(name:params["owner"]["name"])
   @pet.update(owner_id:@owner.id)

 end
 redirect to "pets/#{@pet.id}"
end

end
