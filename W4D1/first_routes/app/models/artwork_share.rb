class ArtworkShare < ApplicationRecord
  validates :viewer_id, uniqueness: {scope: :artwork_id, message: "An artwork can only be shared with a viewer once"}

  validates :viewer_id, :artwork_id, presence: true

  belongs_to :viewer,
    primary_key: :id,
    foreign_key: :viewer_id,
    class_name: 'User'

  belongs_to :artwork,
    primary_key: :id,
    foreign_key: :artwork_id,
    class_name: 'Artwork'
end
