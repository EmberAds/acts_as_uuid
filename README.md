# ActsAsUUID

Adds (native) UUID support, including support for primary keys and associations , to your ActiveRecord models. Currently only supports PostgreSQL.

Inspired by https://github.com/jashmenn/activeuuid and the lack of PostgreSQL gems that worked.

## Installation

Add this to your `Gemfile`:

    gem "uuid"
    gem "acts_as_uuid"

You can now set the type `uuid` for an attribute in your models.

NB: We don't depend on uuid gem because you can use any gem that provides `UUID.generate`, such as the [cuuid](http://github.com/EmberAds/cuuid) gem.

## Example: Adding a UUID primary key to your models

### Step 1a: For new models

```ruby
class AddUUIDPrimaryKeyToEmail < ActiveRecord::Migration
  def self.change
    create_table :emails, :id => false  do |t|
      t.uuid :id, :unique => true
    end
    add_index :emails, :id
  end
end
```

*Don't forget:* You will also need to change any foreign keys to the `uuid` type.

### Step 1b: Migrating existing models

For existing models just add:

```ruby
class AddUUIDPrimaryKeyToEmail < ActiveRecord::Migration
  def self.change
    remove_column :emails, :id
    add_column :emails, :id, :uuid
    add_index :emails, :id
  end
end
```

*Keep in mind:*  after this all your UUIDs will be set to nil.

### Step 2: Extend your model to auto generate UUIDs for a field

```ruby
class Email < ActiveRecord::Base
  include ActsAsUUID
  uuid_on :id, :as => :primary_key
end
```

## Example: Adding a UUID as a separate field

### Step 1: Migrate a model

```ruby
class AddUUIDPrimaryKeyToEmail < ActiveRecord::Migration
  def self.change
    add_column :emails, :guid, :uuid
    add_index :emails, :guid, :unique => true
  end
end
```

*Keep in mind:*  after this all your UUIDs will be set to nil.

### Step 2: Extend your model to auto generate UUIDs for a field

```ruby
class Email < ActiveRecord::Base
  include ActsAsUUID
  uuid_on :guid
end
```

## Important notes

* Currently only supports 1 field to be set to auto generate a UUID
* Integers can't be migrated to UUIDs without losing data
* If you use a UUID as a primary key you will lose some ActiveRecord features like: `.first`, `.find_each` and `.find_in_batches`. Basically any method that requires the ID to be sorted as an integer.

## License

See LICENSE