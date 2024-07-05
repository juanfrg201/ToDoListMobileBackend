class CreateUserTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :user_tasks do |t|
      t.string :name
      t.boolean :active

      t.timestamps
    end
  end
end
