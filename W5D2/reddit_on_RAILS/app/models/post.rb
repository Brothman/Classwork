# == Schema Information
#
# Table name: posts
#
#  id         :bigint(8)        not null, primary key
#  title      :string           not null
#  url        :string
#  content    :string
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  validates :title, presence: true

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: 'User'

  has_many :comments

  has_many :post_subs, dependent: :destroy, inverse_of: :post

  has_many :subs, through: :post_subs

  # def sub_ids=(sub_ids_arr)
  #   sub_ids_arr.each do |sub_id|
  #     PostSub.create(sub_id: sub_id, post_id: self.id)
  #   end
  # end

end
