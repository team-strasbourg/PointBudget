class City < ApplicationRecord
  has_many :users
  validates :zip_code,
            presence: true,
            format: {with: /\A(?:[0-8]\d|9[0-8])\d{3}\Z/}
end