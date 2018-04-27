class Format < ApplicationRecord
  mount_uploader(:attachment, AttachmentUploader)
end
