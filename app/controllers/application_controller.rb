class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
  	@recipes = Recipe.all
  	erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    if params[:name].size > 0
      @recipe = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
      redirect to "/recipes/#{@recipe.id}"
    else
      erb :new
    end
  end

  get '/recipes/:id' do
  	recipe = Recipe.find_by_id(params[:id])
  	@id = recipe.id
  	@name = recipe.name
  	@ingredients = recipe.ingredients
  	@cook_time = recipe.cook_time
    erb :show
  end

  get '/recipes/:id/edit' do
    recipe = Recipe.find_by_id(params[:id])
    @id = recipe.id
    @name = recipe.name
    @ingredients = recipe.ingredients
    @cook_time = recipe.cook_time
    erb :edit
  end

  patch '/recipes/:id/edit' do
	 recipe = Recipe.find_by_id(params[:id])
	 recipe.name = params[:name]
	 recipe.ingredients = params[:ingredients]
	 recipe.cook_time = params[:cook_time]
	 recipe.save
	 redirect to "/recipes/#{recipe.id}"
  end

  delete '/recipes/:id/delete' do
  	recipe = Recipe.find_by_id(params[:id])
  	recipe.delete
  	redirect to '/recipes'
  end

end
