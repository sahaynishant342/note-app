class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.column :name, :string, null: false
      t.column :email, :string, null: false
      t.column :encrypted_password, :string, null: false
      t.column :activation_code, :string, null: false
      t.column :active, :boolean, null: false
      t.timestamps null: false
    end

    # https://stackoverflow.com/questions/32210431/how-do-you-enforce-uniqueness-in-ruby-on-rails-migration
    # NOTE: You need to create an index in order to enforce uniqueness at the database level:
    add_index :users, :email, :unique => true
  end
end
