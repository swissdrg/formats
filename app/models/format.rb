class Format < ApplicationRecord
	has_many :variables, dependent: :destroy
	accepts_nested_attributes_for :variables

  has_one :upload, dependent: :destroy
end
