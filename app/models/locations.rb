class Location < ActiveRecord::Base
    has_many :houses
    has_many :house_categories, through: :houses
end