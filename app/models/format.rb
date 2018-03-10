class Format < ApplicationRecord
	has_many :variables
	accepts_nested_attributes_for :variables
end
