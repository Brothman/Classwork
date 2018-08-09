# == Schema Information
#
# Table name: users
#
#  id         :bigint(8)        not null, primary key
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  has_many :authored_polls,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: "Poll"

  has_many :responses,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: "Response"

  validates :username, uniqueness: true, presence: true
end
