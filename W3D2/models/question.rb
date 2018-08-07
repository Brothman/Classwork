require_relative 'questions_database'
require_relative 'question_follows'
require_relative 'question_likes'
require_relative 'super_model'

class Question < SuperModel
  attr_accessor :title, :body, :user_id, :id
  def self.find_by_id(id)
    # puts 'hello'
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
       *
      FROM
       questions
      WHERE
       id = ?
    SQL
    return nil unless data.length > 0
    Question.new(data.first)
  end


  def self.most_followed(n)
    QuestionFollows.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLikes.most_like_questions(n)
  end

  def initialize(options)
    # debugger
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def followers
    QuestionFollows.followers_for_question_id(id)
  end

  def likers
    QuestionLikes.likers_for_question_id(id)
  end

  def num_likes
    QuestionLikes.num_likes_for_question_id(id)
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

    QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @user_id)
    INSERT INTO
     questions(title, body, user_id)
    VALUES
     (?, ?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "#{self} doesn't exist" unless @id

    QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @user_id, @id)
      UPDATE
        questions
      SET
       title = ?, body = ?, user_id = ?
      WHERE
        questions.id = ?
    SQL
  end


end
