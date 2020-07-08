require 'yaml'
require 'ruby_routes_trie'

require_relative 'controller/controller'
require_relative 'exceptions/controller_not_exist'

class App
  def initialize
    @trie = RubyRoutesTrie.new
  end

  def create_trie
    routes.each do |route|
      @trie.add_route(route[0], route[1])
    end
  end

  def find(route)
    response = @trie.find(route)

    controller(response)
  end

  private

  def controller(response)
    if Controller.method_defined?(response.method)
      Controller.new.send(response.method, response.dynamic_value)
    else
      raise ControllerNotExist
    end
  end

  def routes
    YAML.load(File.read("routes.yml"))
  end
end
