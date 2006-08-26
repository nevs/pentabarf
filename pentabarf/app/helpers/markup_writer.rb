module Markup
  class Writer

    def self.tag_writer(name, tag)
      define_method("open_#{name}".intern) do
        "<#{tag}>"
      end
      define_method("close_#{name}".intern) do
        "</#{tag}>"
      end
    end

  end
end
