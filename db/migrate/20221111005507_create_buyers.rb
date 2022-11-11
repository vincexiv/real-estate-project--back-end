class CreateBuyers < ActiveRecord::Migration[6.1]
  def change
    create_table :buyer do |t|
      t.string :firstname
      t.string :lastname
      t.string :phonenumber
      t.string :message
    end
  end
end
