class Book < ApplicationRecord
  
  has_many :authorships
  has_many :authors, through: :authorships
  
  has_many :reviews
  has_many :users, through: :reviews
  
  
end
