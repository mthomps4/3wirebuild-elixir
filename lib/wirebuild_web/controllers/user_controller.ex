defmodule WirebuildWeb.UserController do
  use WirebuildWeb, :controller

  alias Wirebuild.Account
  alias Wirebuild.Account.User
  alias Wirebuild.Repo

  def preload_social_profile(%User{} = user) do
    Repo.preload(user, [:social_profile])
  end

  def index(conn, _params) do
    users = Account.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Account.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Account.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: Routes.user_path(conn, :show, preload_social_profile(user)))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Account.get_user!(id) |> preload_social_profile()
    render(conn, "show.html", user: user, social_profile: user.social_profile)
  end

  def edit(conn, %{"id" => id}) do
    user = Account.get_user!(id) |> preload_social_profile()
    changeset = Account.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Account.get_user!(id) |> preload_social_profile()

    case Account.update_user(user, user_params) do
      {:ok, user} ->
        user = preload_social_profile(user)

        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Account.get_user!(id) |> preload_social_profile()
    {:ok, _user} = Account.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end
end
