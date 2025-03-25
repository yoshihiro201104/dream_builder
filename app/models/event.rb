class Event < ApplicationRecord
  belongs_to :group
  belongs_to :user # イベント作成者

  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode
  
end
