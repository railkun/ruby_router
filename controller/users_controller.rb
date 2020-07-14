class UsersController
  def index
    'All users'
  end

  def show(params)
    "User id is #{params[":id"]}"
  end

  def new
    'Form create new user'
  end

  def create
    'Create user'
  end

  def edit(params)
    "Edit user id:#{params[":id"]}"
  end

  def update(params)
    "Update user id:#{params[":id"]}"
  end

  def destroy(params)
    "Delete user id:#{params[":id"]}"
  end
end
