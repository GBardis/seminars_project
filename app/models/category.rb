class Category < ApplicationRecord
    has_many :seminars,dependent: :destroy
end
