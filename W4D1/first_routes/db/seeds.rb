# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([
              {username: 'John'},
              {username: 'Jacob'},
              {username: 'Sophia'},
              {username: 'Harmony'},
              {username: 'Peace'}
  ])

Artwork.create([
                {title: "Untitled", image_url: 'asf.png', artist_id: User.first.id},
                {title: "Untitled", image_url: 'Artwork.png', artist_id: User.second.id},
                {title: "A Flying Fish", image_url: 'aff.png', artist_id: User.all[-1].id},
                {title: "Who's Writing This One", image_url: 'wwto.jpg', artist_id: User.third.id}
  ])

ArtworkShare.create([
                      {viewer_id: User.first.id, artwork_id: Artwork.second.id},
                      {viewer_id: User.second.id, artwork_id: Artwork.third.id},
                      {viewer_id: User.third.id, artwork_id: Artwork.fourth.id},
                      {viewer_id: User.fourth.id, artwork_id: Artwork.second.id},
                      {viewer_id: User.fifth.id, artwork_id: Artwork.second.id}
  ])

Comment.create([
                  {author_id: User.first.id, artwork_id: Artwork.second.id, body: "Sweet art man!"},
                  {author_id: User.second.id, artwork_id: Artwork.third.id, body: "Lame art man!"},
                  {author_id: User.third.id, artwork_id: Artwork.fourth.id, body: "Neutral art man!"},
                  {author_id: User.fourth.id, artwork_id: Artwork.second.id, body: "Its okay!"}
  ])
