class Category < ApplicationRecord
  has_many :seminars,inverse_of: :category
  accepts_nested_attributes_for :seminars
end
