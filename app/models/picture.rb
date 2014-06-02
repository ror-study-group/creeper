class Picture < ActiveRecord::Base
	has_attached_file :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode

  after_post_process :copy_exif_data

  def copy_exif_data
  	binding.pry
  end
end
