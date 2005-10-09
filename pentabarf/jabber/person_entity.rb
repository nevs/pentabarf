require 'entity'
require 'momomoto/views'
require 'RMagick'
require 'base64'
#$:.unshift('/usr/local/lib/ruby/gems/1.8/gems/activesupport-1.0.4/lib')
#require 'active_record/base'
#require 'active_support/core_ext/hash/indifferent_access'
#require 'active_support/core_ext/hash/keys'

class PersonEntity < Entity
  def initialize(stream, jid, conference_id, person_id)
    super(stream, jid)
    @conference_id = conference_id
    @person_id = person_id
  end

  def notify_change(change)
    puts "Got #{change.title}"
    #subscriptions = Subscriptions.new(@jid)

    msg = Jabber::Message.new(Jabber::JID.new('astro@hooker.sin'))
    msg.type = :headline
    msg.subject = "#{change.title}"
    msg.body = "#{msg.subject}\n\n#{change.changed_when} by #{change.changed_by}"

    send(msg)
  end

  def handle_subscription_request(from)
    true
  end

  def presence
    #event = Momomoto::View_find_event.find({:translated_id => 144, :conference_id => @conference_id, :event_id => @event_id}, 1)
    #Jabber::Presence.new.set_status(event.title)
  end

  def disco_identity
    #event = Momomoto::View_find_event.find({:translated_id => 144, :conference_id => @conference_id, :event_id => @event_id}, 1)
    #Jabber::DiscoIdentity.new('client', event.title, 'bot')
    person = Momomoto::View_person.find({:person_id => @person_id}, 1)
    Jabber::DiscoIdentity.new('client', event.name)
  end

  def disco_features
    super + ['vcard-temp']
  end

  def vcard
    fields = {}

    person = Momomoto::View_person.find({:person_id => @person_id}, 1)
    fields['FN'] = person.name
    fields['TITLE'] = person.title
    fields['NICKNAME'] = person.nickname
    fields['N/GIVEN'] = person.first_name
    fields['N/MIDDLE'] = person.middle_name
    fields['N/FAMILY'] = person.last_name
    fields['EMAIL'] = person.email_contact

    fields.merge!(photo)
    
    Jabber::IqVcard.new(fields)
  end

  def photo
    # Get image
    person_image = Momomoto::View_person_image.find({:person_id => @person_id}, 1)
    # Create RMagick image
    image = Magick::Image.from_blob(person_image.image)[0]

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
    {'PHOTO/TYPE' => person_image.mime_type, 'PHOTO/BINVAL' => Base64.encode64(image.to_blob)}
  rescue
    {}
  end
end
