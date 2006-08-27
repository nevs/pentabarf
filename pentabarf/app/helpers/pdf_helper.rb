require 'RMagick'

module PdfHelper
  def tmpdir
    @tmpdir
  end

  def include_image(type, id)
    unless @images
      @images = {}
    end

    ident = "#{type}-#{id}"
    if @images.has_key? ident
      is_new = false
      image = @images[ident]
    else
      is_new = true
      case type
      when :conference
        image = Momomoto::View_conference_image.find(:conference_id => id)
      when :event
        image = Momomoto::View_event_image.find(:event_id => id)
      when :person
        image = Momomoto::View_person_image.find(:person_id => id)
      else
        raise "Unknown image type: #{type}"
      end

      image = RAILS_ROOT + "/public/images/icon-#{type}-128x128.png" if image.length < 1
    end

    @images[ident] = image

    result = ''
    x = Builder::XmlMarkup.new(result)
    unless image.kind_of? String
      if image.mime_type == 'image/jpeg'
        img = Magick::Image.from_blob(image.image)[0]
        img.format = 'PNG'
        image.mime_type = 'image/png'
        image.image = img.to_blob
      end

      ext = image.mime_type.split('/').last
      imgfile = "#{tmpdir}/#{type}-#{id}.#{ext}"
      if is_new
        f = File.new(imgfile, 'w')
        f.write(image.image)
        f.close
      end

      x.external_graphic(
                         :src=>"url(#{imgfile.split('/').last})",
                         :content_height=>'1em',
                         :content_width=>'1em',
                         :alignment_baseline=>'middle'
                        )
    else
      x.external_graphic(
                         :src=>"url(#{image})",
                         :content_height=>'1em',
                         :content_width=>'1em',
                         :alignment_baseline=>'middle'
                        )
    end

  end
end
