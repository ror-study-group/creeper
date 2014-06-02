class Picture < ActiveRecord::Base
	has_attached_file :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode
end
