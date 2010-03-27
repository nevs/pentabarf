require 'gettext/rgettext'

module HamlParser
  module_function

  def target?(file)
    File.extname(file) == ".haml"
  end

  def parse(file, ary = [])
    haml = Haml::Engine.new(IO.readlines(file).join)
    code = haml.precompiled.split(/$/)
    RubyParser.parse_lines(file, code, ary)
  end
end

GetText::RGetText.add_parser(HamlParser)

