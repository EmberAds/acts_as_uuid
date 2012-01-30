module ActsAsUUID
  def self.included klass
    klass.before_validation :generate_uuid
    klass.validates :id, :uniqueness => true
    klass.primary_key = :id
  end

  def generate_uuid
    self.id ||= UUID.generate
  end
end
