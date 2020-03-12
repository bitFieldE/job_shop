class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email,            null: false
      t.string :user_name,        limit: 50
      t.string :uid
      t.string :provider
      t.string :family_name,      limit: 50
      t.string :family_furigana,  limit: 50
      t.string :first_name,       limit: 50
      t.string :first_furigana,   limit: 50
      t.date   :birthday
      t.text   :introduction,     limit: 1000

      t.timestamps
    end
  end
end
