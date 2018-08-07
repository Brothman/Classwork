require_relative 'questions_database'
require_relative 'question_follows'
require_relative 'super_model'
require 'byebug'


class User < SuperModel
  attr_accessor :fname, :lname, :id
  def self.find_by_name(fname,lname)
    data = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
       *
      FROM
       users
      WHERE
       fname = ? AND lname = ?
    SQL
    return nil unless data.length > 0
    User.new(data.first)
  end

  def initialize(options)
    # debugger
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end


  def followed_questions
    QuestionFollows.followed_questions_for_user_id(id)
  end


  def average_karma

    data = QuestionsDatabase.instance.execute(<<-SQL, @id, @id)
    SELECT
      CAST(COUNT(question_likes.question_id) AS FLOAT) / (

        SELECT
          COUNT(questions.id)
        FROM
          questions
        WHERE
          questions.user_id = ?
      ) AS avg_karma
    FROM
      users
    JOIN
      questions ON questions.user_id = users.id
    JOIN
      question_likes ON question_likes.question_id = questions.id
    WHERE
      users.id = ?
    GROUP BY
      users.id
    SQL

    data.first['avg_karma']
  end

  def save
    if @id
      update
    else
      create
    end
  end

  private

  def create
    raise "#{self} already in database" if @id

    QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
    INSERT INTO
     users(fname, lname)
    VALUES
     (?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "#{self} doesn't exist" unless @id

    QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname, @id)
      UPDATE
        users
      SET
       fname = ?, lname = ?
      WHERE
        users.id = ?
    SQL
  end

end
