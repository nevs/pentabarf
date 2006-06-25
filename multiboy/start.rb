require 'yaml'
require 'xmpp4r'

require 'multiboy'

Multiboy.new(YAML::load_file("../config/multiboy.yml")).run
