class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :giftwhat
      t.string :giftwho
      t.string :giftwhen
      t.string :givetake
      t.string :giftcomment
      t.string :giftpict1
      t.string :giftpict2
      t.string :giftpict3
      t.references :user

      t.timestamps
    end
  end
end
