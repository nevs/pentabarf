class Ui_message_localized < Momomoto::Table

  def self.log_change_title( change )
    change.ui_message
  end

  def self.log_change_url( change )
    {:controller=>'localization',:action=>:ui_message,:id=>change.ui_message}
  end

  def self.log_content_columns
    columns.keys - [:ui_message]
  end

end

