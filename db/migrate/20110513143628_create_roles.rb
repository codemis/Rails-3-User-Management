class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :title
      t.references :user

      t.timestamps
    end

    add_index :roles, :user_id
  end

  def self.down
    drop_table :roles
  end
end