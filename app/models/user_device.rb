# == Schema Information
#
# Table name: user_devices
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  platform   :string           not null
#  uuid       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserDevice < ActiveRecord::Base
  extend Enumerize
  has_paper_trail

  belongs_to :user

  validates :platform,
            :uuid,
            presence: true

  enumerize :platform, in: [:android, :ios]
end
