class Cat < ApplicationRecord
  validates :name, uniqueness: true
end
