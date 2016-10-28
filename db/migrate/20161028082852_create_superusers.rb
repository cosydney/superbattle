class CreateSuperusers < ActiveRecord::Migration
  def change
    create_table :superusers do |t|
      t.string :email
      t.string :insta_username
      t.string :insta_usercomp
      t.integer :engagement_rate
      t.integer :followers_count
      t.integer :number_of_posts
      t.integer :super_score

      t.timestamps null: false
    end
  end
end
