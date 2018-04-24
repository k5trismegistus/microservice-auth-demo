class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.references :user, null: false
      t.string :session_key, null: false
      t.timestamps
    end
  end
end
