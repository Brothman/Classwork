require_relative 'questions_database'
require_relative 'user'
require_relative 'question'
require_relative 'super_model'


class QuestionLikes < SuperModel
  attr_accessor :likes, :question_id, :user_id, :id
  def self.find_by_question_id(question_id)
    # puts 'hello'
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
       *
      FROM
       question_likes
      WHERE
       question_id = ?
    SQL
    return nil unless data.length > 0
    QuestionLikes.new(data.first)
  end

  def self.likers_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT DISTINCT
       *
      FROM
       question_likes
      JOIN
        users ON users.id = question_likes.user_id
      WHERE
       question_id = ?
    SQL
    return nil unless data.length > 0

    data.map { |datum| User.new(datum)}
  end

  def self.num_likes_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      question_likes.question_id, COUNT(question_likes.question_id)
    FROM
      question_likes
    GROUP BY
      question_likes.question_id
    HAVING
     question_likes.question_id = ?
    SQL

    #This grabs the hash, which is the first element in the array set to data, and takes the value of the second key, which corresponds to COUNT
    data.first.values[1]
  end

  def self.liked_questions_for_user(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL,user_id)
    SELECT
      questions.*
    FROM
      questions
    JOIN
      question_likes ON question_likes.question_id= questions.id
    WHERE
      question_likes.user_id = ?
    SQL

    data.map { |datum| Question.new(datum)}
  end



  def self.most_like_questions(n)
    data = QuestionsDatabase.instance.execute(<<-SQL,n)
    SELECT
     questions.*, COUNT(questions.id)
    FROM
      questions
    JOIN
      question_likes ON question_likes.question_id = questions.id
    GROUP BY
      questions.id
    ORDER BY
      COUNT(questions.id) desc
    LIMIT
     ?
    SQL

    data.map { |datum| Question.new(datum) }
  end

  def initialize(options)
    # debugger
    @id = options['id']
    @likes = options['likes']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

  def create
    raise "#{self} already in database" if @id

    data = QuestionsDatabase.instance.execute(<<-SQL, @likes, @question_id, @user_id)
     INSERT INTO
      question_likes(likes, question_id, user_id)
     VALUES
      (?, ?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id

    QuestionsDatabase.instance.execute(<<-SQL, @likes, @question_id, @user_id, @id)
     UPDATE
      question_likes
     SET
      likes = ?, question_id = ?, user_id = ?
     WHERE
      question_likes.id = ?
    SQL
  end


end
