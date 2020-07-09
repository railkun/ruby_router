Dir["controller/*.rb"].each {|file| require_relative file }

require 'yaml'
require 'ruby_routes_trie'
require 'pry'

require_relative 'exceptions/controller_not_exist'
require_relative 'exceptions/action_not_exist'

class App
  def call(env)

    status  = 200
    headers = { "Content-Type" => "text/html" }
    body    = [find(env["REQUEST_PATH"])]

    [status, headers, body]
  end

  def initialize
    @trie = RubyRoutesTrie.new
    routes.each do |route|
      @trie.add_route(route[0], route[1])
    end
  end

  def create_trie
  end

  def find(route)
    response = @trie.find(route)

    controller(response)
  end

  private

  def pars_response_method(response_method)
    response = response_method.split('#')
    {class: response[0].capitalize, action: response[1]}
  end

  def controller(response)
    response_method = pars_response_method(response.method)
    binding.pry
    raise ControllerNotExist if !Object.const_get("#{response_method[:class]}Controller")

    clazz = eval "#{response_method[:class]}Controller"

    if clazz.method_defined?(response_method[:action])
      clazz.new.send(response_method[:action], response.dynamic_value)
    else
      raise ActionNotExist
    end
  end

  def routes
    YAML.load(File.read("routes.yml"))
  end
end
