# Format holds a JSON data specification file
class Format < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :attachment

  mount_uploader(:attachment, AttachmentUploader)
end
