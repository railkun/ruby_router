class PlayersController
  def initialize(params)
    @params = params
  end

  def show(params)
    "Players id is #{params[":id"]}"
  end
end
