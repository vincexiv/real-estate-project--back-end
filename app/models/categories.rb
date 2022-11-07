class Category < ActiveRecord::Base
    has_many :houses
    has_many :locations, through: :houses
end