require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject

  def self.columns
    # ...
    return @columns if @columns
    @columns = DBConnection.execute2("SELECT * FROM #{table_name}").first.map(&:to_sym)
  end

  def self.finalize!
    columns.each do |column|
      define_method(column) do
        attributes[column]
      end

      define_method("#{column}=") do |value|
        attributes[column] = value
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || self.to_s.tableize
  end

  def self.all
    # ...
  results = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL

    self.parse_all(results)
  end

  def self.parse_all(results)
    # ...
    result_arr = []
    results.each do |result|
      result_arr << self.new(result)
    end
    result_arr
  end

  def self.find(id)
    # ...
    #self.all.find { |obj| obj.id == id }
    result = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{table_name}.id = ?
    SQL

     return nil if result.empty?
     self.new(result.first)
  end

  def initialize(params = {})
    # ...
    params.each do |column, value|
      raise "unknown attribute '#{column}'" unless self.class.columns.include?(column.to_sym)

      self.send("#{column}=".to_sym, value)
    end
  end

  def attributes
    # ...
    @attributes = Hash.new unless @attributes
    @attributes
  end

  def attribute_values
    # ...
    values_arr = []
    self.class.columns.each do |column|
      values_arr << self.send(column)
    end
    values_arr
  end

  def insert
    # creates an array of column names joined by commas
    col_names = self.class.columns.join(',')
    col_names = '(' + col_names + ')'

    question_marks = []

    self.class.columns.length.times do
      question_marks << '?'
    end

    question_marks = question_marks.join(', ')

    #cover edge cases
    question_marks = '(' + question_marks + ')'

    DBConnection.execute(<<-SQL, attribute_values)
      INSERT INTO
        #{self.class.table_name} #{col_names}
      VALUES
        #{question_marks}
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    # ...
    col_names = self.class.columns.map{ |col| "#{col} = ?" }.join(', ')
    puts col_names
    DBConnection.execute(<<-SQL, attribute_values, self.id)
      UPDATE
        #{self.class.table_name}
      SET
        #{col_names}
      WHERE
        id = ?
    SQL
  end

  def save
    # ...
    if self.id
      update
    else
      insert
    end
  end
end
