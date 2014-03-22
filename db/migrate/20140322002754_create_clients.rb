class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.text :email
      t.text :password

      t.timestamps
    end
  end
end
