class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.belongs_to :user, index: true
      t.text :text
      t.timestamps null: false
    end
  end
end
