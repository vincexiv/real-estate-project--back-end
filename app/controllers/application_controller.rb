class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  # GET -----------------------------------------------------------------------
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

  # POST ---------------------------------------------------------------------------
  post '/houses' do
    requested_house = get_house(get_house_details(params))

    if requested_house == [] && no_nil_entry(params)
      new_house = House.create(
        location_id: get_location(location_name: params[:location]).id,
        category_id: get_category(category_name: params[:category]).id,
        price: params[:price],
        description: params[:description],
        size_in_sqft: params[:size_in_sqft],
        image: params[:image]        
      )
      return new_house.to_json
    else
      return requested_house.to_json
    end
  end

  # DELETE -------------------------------------------------------------------------
  delete '/houses/:id' do
    requested_house = House.find_by(id: params[:id])
    if requested_house.nil?
      return
    else
      requested_house.destroy
    end
  end

  # PATCH --------------------------------------------------------------------------
  patch '/houses/:id' do
    binding.pry
    requested_house = House.find_by(id: params[:id])
    if !requested_house.nil?
      expected_entries = get_expected_entries

      expected_entries.each do |expected_key|
        if !params[expected_key.to_sym].nil?
          if expected_key == "location"
            location_id = get_location(location_name: params[:location]).id
            requested_house[:location_id] = params[expected_key.to_sym]
          elsif expected_key == "category"
            category_id = get_category(category_name: params[:category]).id
            requested_house[:category_id] = params[expected_key.to_sym]
          else
            requested_house[expected_key.to_sym] = params[expected_key.to_sym]
          end
        end
      end

      requested_house.save
    end
    requested_house.to_json
  end


  # ================================================================================
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

  def get_location(location_name:)
      location = Location.find_by(location: location_name)
      location_exists = !location.nil?
      if location_exists
        return location
      else
        return Location.create(location: location_name)
      end
  end

  def get_category(category_name:)
    category = Category.find_by(category: category_name)
    category_exists = !category.nil?
    if category_exists
      return category
    else
      return Category.create(category: category_name)
    end     
  end

  def get_house(house_details)
    base_sql_query = get_base_query(house_details)
    full_query = get_full_query(base_query:base_sql_query, house_details: house_details)

    House.find_by_sql full_query
  end

  def get_base_query(house_details)
    base_sql = "SELECT * FROM houses WHERE "
    house_details.each do |key, val|
      if !val.nil?
        base_sql = base_sql + key.to_s + "= ? AND "
      end
    end
    
      #remove the last comma
      base_sql[0..-5]
  end

  def get_full_query(base_query:, house_details:)
    full_sql_query = [base_query]
    house_details.each do |key, val|
      if !val.nil?
        full_sql_query << val
      end
    end

    full_sql_query
  end

  def get_house_details(params)
    location = get_location(location_name: params[:location])
    category = get_category(category_name: params[:category])
    
    house_details = {
        location_id: location.id,
        category_id: category.id,
        price: params[:price],
        description: params[:description],
        size_in_sqft: params[:size_in_sqft],
        image: params[:image]
      }
  end

  def get_expected_entries
    [
      "location",
      "category",
      "price",
      "description",
      "size_in_sqft",
      "image"
    ]
  end

  def get_expected_entries
    [
      "location_id",
      "category_id",
      "price",
      "description",
      "size_in_sqft",
      "image"
    ]
  end

  def no_nil_entry(params)
    expected_entries = get_expected_entries

    expected_entries.each do |param_key|
      if params[param_key.to_sym].nil?
        return false
      end
    end

    return true
  end
end
