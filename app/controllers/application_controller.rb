class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  # Get requests -------------------------------------------------------------------
  get '/categories' do 
    Category.all.to_json(include: {
      houses: {
        only: [:id, :price, :description, :size_in_sqft, :image],
        include: {
          location: {
            only: [:location]
          }
        }
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
            only: [:id, :price, :description, :size_in_sqft, :image],
            include: {
              location: {
                only: [:location],
            }
          }
        }
      })
    end
  end

  get '/locations' do 
    Location.all.to_json(include: {
      houses: {
        only: [:id, :price, :description, :size_in_sqft, :image],
        include: {
          category: {
            only: [:category]
          }
        }
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
          only: [:id, :price, :description, :size_in_sqft, :image],
          include: {
          category: {
              only: [:category]
            }
          }
        }
      })
    end
  end

  get '/houses' do
    requested_houses = House.all.map do |house|
      house_details(house)
    end

    requested_houses.to_json
  end

  get '/houses/:id' do
    requested_house = House.where(:id => params[:id])

    if requested_house == []
      return {}.to_json
    else
      house_details(House.find(params[:id])).to_json
    end
  end

  # Post requests ------------------------------------------------------------------


  # --------------------------------------------------------------------------------
  private
  def house_details(house, remove: [])
    result = {
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

    remove.each do |key|
      result.delete(key)
    end

    result
  end
end
