class AttrAccessorObject
  def self.my_attr_accessor(*names)
    # ...
    #for each attr_accessor we've passed in, we'll create a setter and getter method
    names.each do |name|
      define_method(name) do
        self.instance_variable_get("@#{name}")
      end

      define_method("#{name}=") do |value|
        self.instance_variable_set("@#{name}", value)
      end


    end
  end
end
