defmodule App.Query.User do
  alias App.Repo
  alias App.Schema.User


  def new_user do
    %User{}
    |> User.changeset()
  end

  def insert_user(params) do
    %User{}
    |> User.changeset_with_password(params)
    |> Repo.insert()
  end

  def list_users do
    Repo.all(User)
  end

  def get_user(id) do
    Repo.get(User, id)
  end

  @doc """
  Delete a user.
  """
  def delete_user(id) do
    get_user(id)
    |> Repo.delete()
  end

  def edit_user(id) do
    get_user(id)
    |> User.changeset()
  end

  def update_user(id, params) do
    get_user(id)
    |> User.changeset(params)
    |> Repo.update()
  end

  def update_user_password(id, params) do
    get_user(id)
    |> User.changeset_with_password(params)
    |> Repo.update()
  end

  def get_user_by(attr) do
    Repo.get_by(User, attr)
  end

  @doc """
  Get user by email and password.
  """
  def get_user_by_email_and_password(email, password) do
    with user when not is_nil(user) <- get_user_by(%{email: String.trim(email)}),
         true <- App.Password.verify_pass(password, user.hashed_password),
	 true <- user.approve do
      user
    else
      _ -> App.Password.no_user_verify
    end
  end
end