class Item < ApplicationRecord
  validates_presence_of :name, :unit_price
end
