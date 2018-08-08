# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  long_url   :string
#  short_url  :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ApplicationRecord
  validates :short_url, :long_url, presence: true, uniqueness: true
  validates :user_id, presence: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"

  has_many :visits,
    primary_key: :short_url,
    foreign_key: :short_url,
    class_name: "Visit"

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :user

  has_many :taggings,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: "Tagging"

  has_many :tag_topics,
    through: :taggings,
    source: :tag_topic


  def self.random_code
    random_code = SecureRandom.urlsafe_base64

    while self.exists?(short_url: random_code)
      random_code = SecureRandom.urlsafe_base64
    end
    random_code
  end

  def self.create_shortened_url(user, long_url)
    random_code = self.random_code
    self.create!(user_id: user.id, long_url: long_url, short_url: random_code)
    #this should return the short_url of the new shortenedURL, which we just created
    self.last.short_url
  end

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    # self.visits.select(:user_id).distinct.where(created_at: (10.minutes.ago..Time.now)).count
    self.visitors.where(visits: {created_at: (10.minutes.ago..Time.now)}).count
  end
end
