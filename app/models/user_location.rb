class UserLocation < ActiveRecord::Base
  belongs_to :user
  validates :user_id,
            :lat,
            :lon,
            presence: true
end
