class CreateAvailabilities < ActiveRecord::Migration[6.1]
  def change
    create_table :availabilities do |t|
      t.references :user, null: false, foreign_key: true
      t.string :type
      t.datetime :start_at
      t.datetime :end_at
      t.string :repeat_type, default: :no_repeat
      t.boolean :whole_day, default: true
      t.integer :day
      t.integer :week_day
      t.integer :week_modifier
      t.time :time_start
      t.time :time_end
      t.datetime :recurrent_start
      t.datetime :recurrent_end

      t.timestamps
    end
  end
end
