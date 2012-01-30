# ActsAsUUID

Adds (native) UUID support, including support for primary keys and associations , to your ActiveRecord models. Currently only supports PostgreSQL.

Inspired by https://github.com/jashmenn/activeuuid and the lack of PostgreSQL gems that worked.

## Installation

Add this to your `Gemfile`:

`gem "acts_as_uuid"`

You can now set the type `uuid` for any attribute in your models.

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
Keep in mind that after this all your UUIDs will be set to nil.

### Step 2: Extend your model

```ruby
class Email < ActiveRecord::Base
  include ActsAsUUID
end
```