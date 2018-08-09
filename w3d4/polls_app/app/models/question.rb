# == Schema Information
#
# Table name: questions
#
#  id         :bigint(8)        not null, primary key
#  poll_id    :integer          not null
#  text       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ApplicationRecord
  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: "Poll"

  has_many :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: "AnswerChoice"

  has_many :responses,
    through: :answer_choices,
    source: :responses

  validates :poll_id, :text, presence: true
end
