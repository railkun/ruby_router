require_relative '../service/template'

class HomeController

  include Template

  def initialize(params)
    @params  = params
  end

  def index
    template.render(binding)
  end
end
