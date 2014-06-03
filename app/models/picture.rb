class Picture < ActiveRecord::Base
	has_attached_file :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode

  after_post_process :copy_exif_data

  def copy_exif_data
  	i = MiniExiftool.new(image.queued_for_write[:original].path)
  	self.latitude = parse_latlong(i[:gpslatitude])
  	self.longitude = parse_latlong(i[:gpslongitude])
  end

  def parse_latlong(latlong)
  	latlong.scan(/(.*) deg (.*)' (.*)" (.*)/).map do |d,m,s,r|
  		calc = d.to_f + m.to_f/60 + s.to_f/3600
  		if ['W', 'S'].include? r
  		  -calc
  		else
  		  calc
  		end
  	end.last
  end
end
