# == Schema Information
#
# Table name: artworks
#
#  id        :bigint(8)        not null, primary key
#  title     :string           not null
#  image_url :string           not null
#  artist_id :integer          not null
#

class Artwork < ApplicationRecord

  validates :title, :image_url, :artist_id, presence: true

  validates :title, uniqueness: {scope: :artist_id, message: "Cannot own two artworks with the same title"}

  belongs_to :artist,
    primary_key: :id,
    foreign_key: :artist_id,
    class_name: 'User'

  has_many :artwork_shares,
    primary_key: :id,
    foreign_key: :artwork_id,
    class_name: 'ArtworkShare'

  has_many :shared_viewers,
    through: :artwork_shares,
    source: :viewer

  has_many :comments,
    primary_key: :id,
    foreign_key: :artwork_id,
    class_name: 'Comment'
end
