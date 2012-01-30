require "acts_as_uuid/version"

module ActsAsUuid
  require "acts_as_uuid/railtie" if defined?(Rails)
  require "acts_as_uuid/acts_as_uuid"
end
