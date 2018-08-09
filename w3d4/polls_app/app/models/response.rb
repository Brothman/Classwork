# == Schema Information
#
# Table name: responses
#
#  id               :bigint(8)        not null, primary key
#  answer_choice_id :integer          not null
#  user_id          :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Response < ApplicationRecord
  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: "AnswerChoice"

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"

  has_one :question,
    through: :answer_choice,
    source: :question

  has_one :poll,
    through: :question,
    source: :poll

  #validates :user_id, user_id: true
  validates :question, user_id: true

  #validates :answer_choice_id, presence: true

  # validates :respondent, uniqueness: true

  #validate :respondent_already_answered

  # validate :author_cannot_respond

  def sibling_responses
    # self.question.responses.where("responses.id != ?", self.id)
    self.question.responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    sibling_responses != self.question.responses
  end

  def author_cannot_respond
    if self.poll.user_id == self.respondent.id
      errors[:author] << "Author cannot respond to his own question"
    end
  end

  def author_responding_to_own_poll?
    self.poll.user_id == self.respondent.id
  end

  def respondent_already_answered
    if sibling_responses != self.question.responses
      #{raise "Respondent already answered"}
      errors[:respondent] << "Respondent already answered"
    end
  end


end
