#!/usr/bin/env ruby
#
# reads a file with a listing of the recordings and outputs sql to add those links to the
# pentabarf events
#


file = ARGV[0]
acronym = "24c3"

link_prefix = 'http://outpost.h3q.com/fnord/24c3-torrents/'

file = File.open( file, 'r' )

file.each_line do | line |
  if m = line.match(/^<a href="([^"]+)"/)
    filename = m[1]
    if m = filename.match(/^#{acronym}-(\d+)-\w\w-[a-z0-9_]+.(mkv|mp4).torrent$/)
      event_id = m[1]
      url = link_prefix + filename
      title = case m[2]
        when 'mkv' then 'Torrent of the video recording for this event in Matroska / Vorbis / H.264'
        when 'mp4' then 'Torrent of the video recording for this event in MPEG-4 / AAC-LC / H.264'
        else raise "Unknown file format #{m[2]}"
      end
      puts "INSERT INTO event_link(event_id,url,title) VALUES('#{Integer(event_id)}','#{url}','#{title}');"
    else
      raise "Unhandled line: #{line}"
    end
  end
end

