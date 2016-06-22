class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :age
      t.string :sex
      t.string :email
      t.string :password_digest
      t.string :symptoms

      t.timestamps null: false
      
      t.index :email, unique: true
    end
  end
end
