class CreateAvailabilities < ActiveRecord::Migration[6.1]
  def change
    create_table :availabilities do |t|
      t.references :user, null: false, foreign_key: true
      t.string :type
      t.datetime :start_at
      t.datetime :end_at
      t.boolean :whole_day, default: true
      t.string :repeat_type, default: :no_repeat
      t.integer :day
      t.integer :week_day
      t.integer :ordinal_modifier

      t.timestamps
    end
  end
end
