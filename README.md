# ActsAsUUID

Adds (native) UUID primary key support to your ActiveRecord models. Currently only supports PostgreSQL. ActsAsUUID works with primary keys and ActiveRecordAssociations.

Inspired by https://github.com/jashmenn/activeuuid and the lack of PostgreSQL gems that worked.

## Installation

Add this to your `Gemfile`:

`gem "acts_as_uuid"`

## Example

### 1a: New models

```ruby
class AddUUIDPrimaryKeyToEmail < ActiveRecord::Migration
  def self.change
    create_table :emails, :id => false  do |t|
      t.uuid :id, :unique => true
    end
    add_index :emails, :id
  end
end

### 1b: Migrate existing models

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

### 2: Extend your model

```ruby
class Email < ActiveRecord::Base
  include ActsAsUUID
end
```