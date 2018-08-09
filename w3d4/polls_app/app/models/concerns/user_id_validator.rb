class UserIdValidator < ActiveModel::EachValidator

  def validate_each(record, attr_name, value)

    if record.respondent_already_answered?
      message = options[:message] || "Respondent already answered."
      record.errors[attr_name] << message
    end

    if record.author_responding_to_own_poll?
      message = options[:message] || "Author cannot respond to his own poll"
      record.errors[attr_name] << message
    end

  end
end
