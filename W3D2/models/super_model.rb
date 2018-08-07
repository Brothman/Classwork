require 'require_all'
#require_all './'
require_relative 'user'
require 'byebug'

class SuperModel

  def self.all
    data = QuestionsDatabase.instance.execute(<<-SQL)
    SELECT
      *
    FROM
      #{table}
  SQL
  return nil unless data.length > 0
  data.map { |datum| User.new(datum) }
end


def self.table
  hash = {
    'QuestionFollows' => 'question_follows',
    'QuestionLikes' => 'question_likes',
    'Question' => 'questions',
    'Reply' => 'replies',
    'User' => 'users'
  }
  hash[self.to_s]
end


def self.where(options)
  user_id, user_val = 'id', options['id']

  debugger
  data = QuestionsDatabase.instance.execute(<<-SQL,user_id,user_val)
  SELECT
    *
  FROM
    #{table}
  WHERE
    #{self.table.user_id = sf
  SQL
end



end
