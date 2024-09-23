class AddInReplyToColumnToMicroposts < ActiveRecord::Migration[7.0]
  def change
    add_reference :microposts, :in_reply_to, foreign_key: { to_table: :users }
    add_index :microposts, [:in_reply_to_id, :created_at]
  end
end
