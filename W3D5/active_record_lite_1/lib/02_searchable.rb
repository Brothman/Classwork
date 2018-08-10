require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    # ...
    key_map = params.keys.map{ |col_name| "#{col_name} = ?" }.join(' AND ')

    #test_values = params.values.map(&:to_s)

    result = DBConnection.execute(<<-SQL, params.values)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{key_map}
    SQL

    instances_arr = []
    result.each do |row|
      instances_arr << self.new(row)
    end
    instances_arr
  end
end

class SQLObject
  # Mixin Searchable here...
  extend Searchable
end
