class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  # Get requests -------------------------------------------------------------------
  get '/categories' do 
    Category.all.to_json(include: {
      houses: {
        only: [:id, :price, :description, :size_in_sqft, :image]
      }
    })
  end

  get '/categories/:id' do
    requested_category = Category.where(:id => params[:id])

    if requested_category == []
      return {}.to_json
    else
      return Category.find(params[:id]).to_json(include: {
        houses: {
          only: [:id, :price, :description, :size_in_sqft, :image]
        }
      })
    end
  end

  get '/locations' do 
    Location.all.to_json(include: {
      houses: {
        only: [:id, :price, :description, :size_in_sqft, :image]
      }
    })
  end

  get '/locations/:id' do
    requested_location = Location.where(:id => params[:id])

    if requested_location == []
      return {}.to_json
    else
      return Location.find(params[:id]).to_json(include: {
        houses: {
          only: [:id, :price, :description, :size_in_sqft, :image]
        }
      })
    end
  end

  get '/houses' do
    requested_houses = House.all.map do |house|
      {
        id: house.id,
        location_id: house.location_id,
        category_id: house.category_id,
        location: Location.find(house.location_id).location,
        category: Category.find(house.category_id).category,
        price: house.price,
        description: house.description,
        size_in_sqft: house.size_in_sqft,
        image: house.image
      }
    end

    requested_houses.to_json
  end

  get '/houses/:id' do
    requested_house = House.where(:id => params[:id])

    if requested_house == []
      return {}.to_json
    else
      house = House.find(params[:id])
      {
        id: house.id,
        location_id: house.location_id,
        category_id: house.location_id,
        location: Location.find(house.location_id).location,
        category: Category.find(house.category_id).category,
        price: house.price,
        description: house.description,
        size_in_sqft: house.size_in_sqft,
        image: house.image
      }.to_json
    end
  end
end
