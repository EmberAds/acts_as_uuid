module ActsAsUUID
  def self.included klass
    klass.before_create :generate_uuid
    klass.validates :uuid, :uniqueness => true
    klass.primary_key = :uuid
  end

  def generate_uuid
    self.uuid = UUID.generate
  end
end
