defmodule Wirebuild.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Wirebuild.Account.{SocialProfile, User}
  alias Wirebuild.Repo
  alias Argon2

  schema "users" do
    field :username, :string
    field :first_name, :string
    field :last_name, :string
    field :password, :string, virtual: true
    field :hashed_password, :string
    has_one :social_profile, SocialProfile

    timestamps()
  end

  @doc false
  def create_changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :username, :password])
    |> validate_required([:first_name, :last_name, :username, :password])
    |> cast_assoc(:social_profile, with: &SocialProfile.changeset/2)
    |> unique_constraint(:username)
    |> validate_length(:password, min: 8)
    |> put_password_hash()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :username, :password])
    |> validate_required([:first_name, :last_name])
    |> cast_assoc(:social_profile, with: &SocialProfile.changeset/2)
    |> unique_constraint(:username)
    |> validate_length(:password, min: 8)
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, hashed_password: Argon2.hash_pwd_salt(password))
    # |> change(password: nil)
  end

  defp put_password_hash(changeset), do: changeset

  def authenticate_user(username, plain_text_password) do
    query = from u in User, where: u.username == ^username

    case Repo.one(query) do
      nil ->
        Argon2.no_user_verify()
        {:error, :invalid_credentials}

      user ->
        if Argon2.verify_pass(plain_text_password, user.password) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end
end
