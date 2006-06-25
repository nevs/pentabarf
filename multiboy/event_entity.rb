require 'entity'
require 'momomoto/views'
require 'RMagick'
require 'base64'

class EventEntity < Entity
  def initialize(stream, jid, base_url, conference_id, event_id)
    super(stream, jid, base_url)
    @conference_id = conference_id
    @event_id = event_id

    if Momomoto::View_find_event.find({:translated_id => 144, :conference_id => @conference_id, :event_id => @event_id}, 1).nil?
      raise NoEntityException.new
    end
  end

  def url
    "#{@base_url}event/#{@event_id}"
  end

  def handle_subscription_request(from)
    true
  end

  def presence
    event = Momomoto::View_find_event.find({:translated_id => 144, :conference_id => @conference_id, :event_id => @event_id}, 1)
    Jabber::Presence.new.set_status(event.title)
  end

  def disco_identity
    event = Momomoto::View_find_event.find({:translated_id => 144, :conference_id => @conference_id, :event_id => @event_id}, 1)
    Jabber::DiscoIdentity.new('client', event.title, 'bot')
  end

  def disco_features
    super + ['vcard-temp']
  end

  def vcard
    fields = {}

    event = Momomoto::View_event.find({:translated_id => 144, :conference_id => @conference_id, :event_id => @event_id}, 1)
    fields['FN'] = event.title
    fields['NICKNAME'] = event.subtitle
    fields['DESC'] = event.description
    fields['BDAY'] = "Day #{event.day}: #{event.real_starttime}"

    fields.merge!(photo)
    
    Jabber::IqVcard.new(fields)
  end

  def photo
    # Get image
    event_image = Momomoto::View_event_image.find({:event_id => @event_id}, 1)
    # Create RMagick image
    image = Magick::Image.from_blob(event_image.image)[0]

    # Resize keeping aspect ratio
    rows = 64
    columns = 64
    if image.rows > rows or image.columns > columns
      rows = columns * (image.rows.to_f / image.columns) if image.rows < image.columns
      columns = rows * (image.columns.to_f / image.rows) if image.columns < image.rows
      image.resize!(columns, rows)
    end

    # Output
    image.strip!
    {'PHOTO/TYPE' => event_image.mime_type, 'PHOTO/BINVAL' => Base64.encode64(image.to_blob)}
  rescue
    {}
  end
end
