class AddAttachmentFileToAttachments < ActiveRecord::Migration
  def up
    change_table :attachments do |t|
      t.attachment :file
    end
  end

  def down
    remove_attachment :attachments, :file
  end
end
