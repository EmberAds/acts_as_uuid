require 'acts_as_uuid'
require 'rails'

module ActsAsUUID
  class Railtie < Rails::Railtie
    railtie_name :activeuuid
    initializer "activeuuid.configure_rails_initialization" do

      module PostgreSQLAdapter
        def native_database_types_with_uuid_support
          a = native_database_types_without_uuid_support
          a[:uuid] = {:name => 'uuid'}
          return a
        end

        def self.included klass
          klass.alias_method_chain :native_database_types, :uuid_support
        end
      end

      module PostgreSQLColumn
        def simplified_type_with_uuid_support(field_type)
          if field_type == 'uuid'
            :uuid
          else
            simplified_type_without_uuid_support(field_type)
          end
        end

        def self.included klass
          klass.alias_method_chain :simplified_type, :uuid_support
        end
      end

      module TableDefinition
        def uuid *args
          options = args.extract_options!
          column(args[0], 'uuid', options)
        end
      end

      # Include it all
      if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
        ActiveRecord::ConnectionAdapters::PostgreSQLAdapter::TableDefinition.__send__ :include, ActsAsUUID::Railtie::TableDefinition
        ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.__send__ :include, ActsAsUUID::Railtie::PostgreSQLAdapter
        ActiveRecord::ConnectionAdapters::PostgreSQLColumn.__send__ :include, ActsAsUUID::Railtie::PostgreSQLColumn
      end

    end
  end
end
