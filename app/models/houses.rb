class House < ActiveRecord::Base
    belongs_to :house_category
    belongs_to :location
end