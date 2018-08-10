require_relative '02_searchable'
require 'active_support/inflector'
require 'byebug'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    # ...
    class_name.constantize
  end

  def table_name
    # ...
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    # ...
    #create our own default hash

    self.foreign_key = options[:foreign_key] || "#{name}_id".to_sym
    self.class_name = options[:class_name] || name.to_s.camelcase.singularize
    self.primary_key = options[:primary_key] || :id
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    # ...
    self.foreign_key = options[:foreign_key] || "#{self_class_name.to_s.downcase}_id".to_sym
    self.class_name = options[:class_name] || name.to_s.camelcase.singularize
    self.primary_key = options[:primary_key] ||  :id
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    # ...
    options = BelongsToOptions.new(name, options)

    define_method(name) do
      foreign_key = options.send(:foreign_key)
      model_class = options.model_class
      val = self.send(foreign_key)
      result = model_class.where(:id => val)

      result.first
    end
  end

  def has_many(name, options = {})
    # ...
    options = HasManyOptions.new(name, self, options)

    define_method(name) do
      primary_key = options.send(:primary_key)
      foreign_key = options.send(:foreign_key)
      model_class = options.model_class
      val = self.send(primary_key)
      # debugger
      debugger
      result = model_class.where(foreign_key => val)

      #result.first
      return result
    end
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  # Mixin Associatable here...
  extend Associatable
end
