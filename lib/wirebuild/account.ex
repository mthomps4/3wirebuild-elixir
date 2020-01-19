defmodule Wirebuild.Account do
  @moduledoc """
  The Account context.
  """

  import Ecto.Query, warn: false
  alias Wirebuild.Repo

  alias Wirebuild.Account.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{} |> User.create_changeset(attrs) |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user |> User.changeset(attrs) |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  alias Wirebuild.Account.SocialProfile

  @doc """
  Returns the list of social_profiles.

  ## Examples

      iex> list_social_profiles()
      [%SocialProfile{}, ...]

  """
  def list_social_profiles do
    Repo.all(SocialProfile)
  end

  @doc """
  Gets a single social_profile.

  Raises `Ecto.NoResultsError` if the Social profile does not exist.

  ## Examples

      iex> get_social_profile!(123)
      %SocialProfile{}

      iex> get_social_profile!(456)
      ** (Ecto.NoResultsError)

  """
  def get_social_profile!(id), do: Repo.get!(SocialProfile, id)

  @doc """
  Creates a social_profile.

  ## Examples

      iex> create_social_profile(%{field: value})
      {:ok, %SocialProfile{}}

      iex> create_social_profile(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_social_profile(attrs \\ %{}) do
    %SocialProfile{}
    |> SocialProfile.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a social_profile.

  ## Examples

      iex> update_social_profile(social_profile, %{field: new_value})
      {:ok, %SocialProfile{}}

      iex> update_social_profile(social_profile, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_social_profile(%SocialProfile{} = social_profile, attrs) do
    social_profile
    |> SocialProfile.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a SocialProfile.

  ## Examples

      iex> delete_social_profile(social_profile)
      {:ok, %SocialProfile{}}

      iex> delete_social_profile(social_profile)
      {:error, %Ecto.Changeset{}}

  """
  def delete_social_profile(%SocialProfile{} = social_profile) do
    Repo.delete(social_profile)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking social_profile changes.

  ## Examples

      iex> change_social_profile(social_profile)
      %Ecto.Changeset{source: %SocialProfile{}}

  """
  def change_social_profile(%SocialProfile{} = social_profile) do
    SocialProfile.changeset(social_profile, %{})
  end
end
