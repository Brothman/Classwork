# == Schema Information
#
# Table name: cats
#
#  id          :bigint(8)        not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ApplicationRecord

  has_many :cat_rental_requests,
     dependent: :destroy



  before_validation :downcase_color, :upcase_sex

  validates :color, inclusion: { in: %w(red green pineapple orange blue yellow) }
  validates :sex, inclusion: { in: %w(M F) }

  validates :color, :sex, :birth_date, :name, :description, presence: true

  def downcase_color
    self.color.downcase!
  end

  def upcase_sex
    self.sex.upcase!
  end

  def age
    today = Date.today
    ((today - birth_date).to_i) / 365
  end
end
