class GlobalConfiguration < ActiveRecord::Base
  # Our NotFound exception for unset configurations
  class ConfigurationNotFound < RuntimeError; end

  # Cache management
  after_save :write_cache
  after_destroy { |record| Rails.cache.delete("global_configuration:#{record.key}") }
  
  def write_cache
    Rails.cache.write("global_configuration:#{self.key}", "#{self.kind}:#{self.value}")
  end  

  # Defining setters and getters on class level
  class << self
    
    # Use [] notation to get/set configuration setting
    # Ex: GlobalConfiguration[:email] = 'john@example.com'
    def [](key)
      if cached = Rails.cache.fetch("global_configuration:#{key}") 
        kind, value = cached.split(':')
        return get_typed_value(value, kind)
      else
        fetch_from_db(key)
      end
    end

    # To get configuration setting 
    # Ex: GlobalConfiguration[:email]
    def []=(key, value)
      save_to_db(key, value)
    end
  
    # Remove a key from db and cache
    def remove(key)
      if record = where(key: key).first
        record.destroy
      else
        raise ConfigurationNotFound, "#{key} not found"
      end
    end
    
    private    
    # If we set a configuration it is written to the database
    # We store the class of the value as well 
    def save_to_db(key, value)
      record = find_or_create_by(key: key) 
      record.value = value.to_s
      record.kind = value.class.to_s
      record.save
    end

    # Retrieve the value from database
    def fetch_from_db(key)
      if record = where(key: key).first
        get_typed_value(record.value.to_s, record.kind)
      else
        raise ConfigurationNotFound, "#{key} not found"
      end
    end

    def get_typed_value(value, kind)
      value.send(to_kind(kind))      
    end
    
    # Handles data conversion from string to ...
    def to_kind(klass)
      if klass == 'Fixnum'
        :to_i
      elsif klass == 'Float'
        :to_f
      elsif ['TrueClass', 'FalseClass'].include?(klass)
        :to_bool
      elsif klass == 'String'
        :to_s
      end
    end
  end
end

