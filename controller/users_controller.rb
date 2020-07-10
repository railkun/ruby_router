class UsersController
  def index
    'All users'
  end

  def show(params)
    "User id is #{params[":id"]}"
  end
end
