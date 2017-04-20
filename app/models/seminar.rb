class Seminar < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :photos, dependent: :destroy, inverse_of: :seminar
 
  validates :title, presence: true
  validates :description, presence: true
  validates :author, presence: true
  validates :company, presence: true
  validates :price, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end
