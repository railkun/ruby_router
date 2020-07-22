require 'haml'

class HomeController

  def initialize(params)
    @params  = params
  end

  def index
    template.render(binding)
  end

  private

  def template
    action   = caller[0].split("`").pop.gsub("'", "")

    template = File.read(File.join("views/home/#{action}.haml"))

    Haml::Engine.new(template)
  end
end
