class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  include DeviseTokenAuth::Concerns::User # after devise

  has_many :locations,
           -> { order(id: :desc) },
           class_name: "UserLocation"
end
