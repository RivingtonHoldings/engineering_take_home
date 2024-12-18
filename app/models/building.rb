class Building < ApplicationRecord
  belongs_to :client

  validates :street_address_one, presence: true
  validates :city, presence: true
  validates :state, presence: true, format: /\A[A-Z]{2}\z/
  validates :zipcode, presence: true, format: /\A[0-9]{5}(-?[0-9]{4})?\z/
  validates :city, presence: true
end
