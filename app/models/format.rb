class Format < ApplicationRecord
	has_many :variables
	accepts_nested_attributes_for :variables

  mount_uploader :attachment, AttachmentUploader
  validates :name, presence: true

end
