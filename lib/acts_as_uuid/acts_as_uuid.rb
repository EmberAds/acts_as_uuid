module ActsAsUUID
  def self.included klass
    klass.before_validation :generate_uuid
    klass.extend ClassMethods
  end

  def generate_uuid
    self[self.class.acts_as_uuid_field] ||= UUID.generate
  end

  module ClassMethods

    def uuid_on field, options = {}
      self.acts_as_uuid_field = field
      self.validates field, :uniqueness => true
      self.primary_key = field if options[:as] == :primary_key
    end

    attr_accessor :acts_as_uuid_field
    protected :acts_as_uuid_field=
  end

end
