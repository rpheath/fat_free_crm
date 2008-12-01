class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts, :force => true do |t|
      t.string      :uuid, :limit => 36
      t.references  :user
      t.string      :name, :limit => 64, :null => false, :default => ""
      t.string      :access, :limit => 8, :default => "Private" # %w(Private Public Shared)
      t.string      :notes
      t.string      :website, :limit => 64
      t.string      :phone, :limit => 32
      t.string      :fax, :limit => 32
      t.string      :billing_address
      t.string      :shipping_address
      t.datetime    :deleted_at
      t.timestamps
    end

    add_index :accounts, [ :user_id, :name ], :unique => true
    add_index :accounts, :uuid
    ActiveRecord::Base.connection.execute("CREATE TRIGGER accounts_uuid BEFORE INSERT ON accounts FOR EACH ROW SET NEW.uuid = UUID()");
  end

  def self.down
    drop_table :accounts
  end
end