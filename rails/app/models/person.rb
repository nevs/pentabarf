class Person < Momomoto::Table
  module Methods

    def name
      if public_name
        public_name
      elsif first_name && last_name
        "#{first_name} #{last_name}"
      elsif last_name
        last_name
      else
        nickname
      end
    end

  end
end

