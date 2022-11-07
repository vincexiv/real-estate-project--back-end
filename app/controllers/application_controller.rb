class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  get '/categories' do 
    Category.all.to_json(include: :houses)
  end

  get '/categories/:id' do
    requested_category = Category.where(:id => params[:id])

    if requested_category == []
      return {}.to_json
    else
      return Category.find(params[:id]).to_json(include: :houses)
    end
  end

  get '/locations' do 
    Location.all.to_json(include: :houses)
  end

  get '/locations/:id' do
    requested_location = Location.where(:id => params[:id])

    if requested_location == []
      return {}.to_json
    else
      return Location.find(params[:id]).to_json(include: :houses)
    end
  end

  get '/houses' do
    House.all.to_json(include: :categories)
  end

  get '/houses/:id' do
    requested_house = House.where(:id => params[:id])

    if requested_house == []
      return {}.to_json
    else
      House.find(params[:id]).to_json
    end
  end
end
