require 'fileutils'
require 'image_size'
require 'debugger'

dirname = ARGV[0]
width 	= ARGV[1]
height	= ARGV[2]
factor  = width.to_i/height.to_i

Dir.glob(dirname+"/*.jpg").each do |url|
	open(url, "rb") do |image|
    size = ImageSize.new(image.read).get_size 
    if(size[0].to_f/size[1] > factor)
        system "convert '#{url}' -resize x#{height} '#{url}'"
    elsif(size[0].to_f/size[1] < factor)
        system "convert '#{url}' -resize #{width}x '#{url}'"
    else
        system "convert '#{url}' -resize #{width}x#{height} '#{url}'"
    end
    system "convert '#{url}' -crop #{width}x#{height}+0+0 '#{url}'"
  end
end