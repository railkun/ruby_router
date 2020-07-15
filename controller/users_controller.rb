require 'haml'

class UsersController
  def index
    template = File.read(File.join("views/users/index.haml"))

    users

    Haml::Engine.new(template).render(binding)
  end

  def show(params)
    template = File.read(File.join("views/users/show.haml"))

    user_name = users[params[":id"].to_i - 1]

    Haml::Engine.new(template).render(binding)
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

  private

  def users
    users = [
      "Alex",
      "Steve",
      "John"
    ]
  end
end
