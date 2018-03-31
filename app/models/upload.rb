class Upload < ApplicationRecord

  belongs_to :format
  mount_uploader :attachment, AttachmentUploader


end
