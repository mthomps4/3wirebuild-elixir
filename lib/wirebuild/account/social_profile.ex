defmodule Wirebuild.Account.SocialProfile do
  use Ecto.Schema
  import Ecto.Changeset
  alias Wirebuild.Account.User

  schema "social_profiles" do
    field :email, :string
    field :dev_to, :string
    field :medium, :string
    field :github, :string
    field :twitter, :string
    field :company, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(social_profile, attrs) do
    social_profile
    |> cast(attrs, [:medium, :dev_to, :twitter, :github, :company, :email, :user_id])
  end
end
