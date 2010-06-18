class CreateDownloads < ActiveRecord::Migration
  def self.up
    create_table :downloads do |t|
      t.string :title
      t.string :url_one
      t.string :url_two
      t.string :system
      t.timestamps
    end
  end

  def self.down
    drop_table :downloads
  end
end
