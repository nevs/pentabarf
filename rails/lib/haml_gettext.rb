# Haml gettext module providing gettext translation for all Haml plain text calls
#
# http://pastie.org/445295

class Haml::Engine
  # Inject _ gettext into plain text and tag plain text calls
  def push_plain(text)
    super(_(text))
#    push_script("= _('#{text}')")
  end

  def parse_tag(line)
    tag_name, attributes, attributes_hash, object_ref, nuke_outer_whitespace,
      nuke_inner_whitespace, action, value = super(line)
    value = _(value) unless action || value.empty?
    [tag_name, attributes, attributes_hash, object_ref, nuke_outer_whitespace,
        nuke_inner_whitespace, action, value]
  end
end


