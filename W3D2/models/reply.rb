require_relative 'questions_database'
require_relative 'super_model'

class Reply < SuperModel
  attr_accessor :user_id, :question_id, :id, :parent_reply_id, :body

  def self.find_by_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
    *
    FROM
    replies
    WHERE
    question_id = ?
    SQL
    return nil unless data.length > 0

    data.map { |datum| Reply.new(datum)}
  end

  def initialize(options)
    # debugger
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
    @body = options['body']
    @parent_reply_id = options['parent_reply_id']
  end


  def save
    if @id
      update
    else
      create
    end
  end

  private

  # :user_id, :question_id, :id, :parent_reply_id, :body
  def create
    raise "#{self} already in database" if @id

    QuestionsDatabase.instance.execute(<<-SQL, @user_id, @question_id, @parent_reply_id, @body)
    INSERT INTO
     replies(user_id, question_id, parent_reply_id, body)
    VALUES
     (?, ?, ?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "#{self} doesn't exist" unless @id

    QuestionsDatabase.instance.execute(<<-SQL, @user_id, @question_id, @parent_reply_id, @body, @id)
      UPDATE
        replies
      SET
       user_id = ?, question_id = ?, parent_reply_id = ?, body = ?
      WHERE
        replies.id = ?
    SQL
  end

end
