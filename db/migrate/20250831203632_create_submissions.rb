class CreateSubmissions < ActiveRecord::Migration[8.0]
  def change
    create_table :submissions do |t|
      t.references :enrollment, foreign_key: true
      t.references :lesson, foreign_key: true
      t.references :mentor, foreign_key: true

      t.string :pull_request_url
      t.string :review_result
      t.datetime :reviewed_at

      t.timestamps
    end
  end
end
