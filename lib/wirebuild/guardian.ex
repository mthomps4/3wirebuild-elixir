defmodule Wirebuild.Guardian do
  use Guardian, otp_app: :wirebuild

  alias Wirebuild.Account

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Account.get_user!(id) do
      nil -> {:error, :user_not_found}
      user -> {:ok, user}
    end
  end
end
