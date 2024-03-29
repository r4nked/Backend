# frozen_string_literal: true

class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.belongs_to :stack, null: false, foreign_key: {on_delete: :cascade}
      t.string :name, null: false, limit: 126
    end

    add_index :cards, %i[stack_id name], unique: true
  end
end
