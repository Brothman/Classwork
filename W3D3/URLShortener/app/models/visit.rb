# == Schema Information
#
# Table name: visits
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer
#  short_url  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Visit < ApplicationRecord
  validates :short_url, :user_id, presence: true

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"

  belongs_to :shortened_url,
    primary_key: :short_url,
    foreign_key: :short_url,
    class_name: "ShortenedUrl"



  def self.record_visit!(user, shortened_url)
    self.create!(user_id: user.id, short_url: shortened_url)
  end


end
