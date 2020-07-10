require 'yaml'

require_relative 'app'

run App.new(YAML.load(File.read("routes.yml")))
