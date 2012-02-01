module ActsAsUUID
  def self.included klass
    klass.before_validation :generate_uuids
    klass.validates :id, :uniqueness => true
    klass.primary_key = :id


    def klass.uuid_on field, options = {}
      @@fields ||= Array.new
      @@fields << field
      self.validates field, :uniqueness => true
      self.primary_key = field if options[:as] == :primary_key
    end
  end

  def generate_uuids
    @@fields.each do |field|
      self[field] ||= UUID.generate
    end
  end


end
