# Format holds a JSON data specification file
class Format < ApplicationRecord
  mount_uploader(:attachment, AttachmentUploader)
end
