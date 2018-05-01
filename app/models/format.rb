# Format holds a JSON data specification file
class Format < ApplicationRecord
  mount_uploader(:attachment, AttachmentUploader)
  validates :attachment, :presence => true
  validates :title, :presence => true
end
