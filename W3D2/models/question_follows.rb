require_relative 'questions_database'
require_relative 'user'
require_relative 'question'
require_relative 'super_model'


class QuestionFollows < SuperModel
  attr_accessor :user_id, :question_id, :id


  def self.find_by_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
       *
      FROM
       question_follows
      WHERE
       user_id = ?
    SQL
    return nil unless data.length > 0
    QuestionFollows.new(data.first)
  end

  def self.find_by_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
       *
      FROM
       question_follows
      WHERE
       question_id = ?
    SQL
    return nil unless data.length > 0
    QuestionFollows.new(data.first)
  end

  def self.followers_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
       users.*
      FROM
       users
      JOIN
       question_follows ON users.id = question_follows.user_id
      WHERE
       question_follows.question_id = ?
    SQL

    data.map { |datum| User.new(datum) }
  end

  def self.followed_questions_for_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
       questions.*
      FROM
       questions
      JOIN
        question_follows ON question_follows.question_id = questions.id
      WHERE
       question_follows.user_id = ?
    SQL
    return nil unless data.length > 0
    # QuestionFollows.new(data.first)

    data.map { |datum| Question.new(datum)}
  end

  def self.most_followed_questions(n)
    data = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
       questions.*, COUNT(questions.id)
      FROM
        questions
      JOIN
        question_follows ON question_follows.question_id = questions.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(questions.id) desc
      LIMIT
       ?
    SQL
  end

  def initialize(options)
    # debugger
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def create
    raise "#{self} already in database" if @id

    QuestionsDatabase.instance.execute(<<-SQL, @user_id, @question_id)
     INSERT INTO
      question_follows(user_id, question_id)
     VALUES
      (?, ?)
    SQL
    @id = QuestionsDatabase.instance.last_insert_row_id
  end
end
