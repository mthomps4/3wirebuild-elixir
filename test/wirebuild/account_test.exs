defmodule Wirebuild.AccountTest do
  use Wirebuild.DataCase

  alias Wirebuild.Account

  describe "users" do
    alias Wirebuild.Account.User

    @valid_attrs %{
      first_name: "some first_name",
      password: "some password",
      last_name: "some last_name",
      username: "some username"
    }
    @update_attrs %{
      first_name: "some updated first_name",
      password: "some updated password",
      last_name: "some updated last_name",
      username: "some updated username"
    }
    @invalid_attrs %{first_name: nil, password: nil, last_name: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Account.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Account.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Account.create_user(@valid_attrs)
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Account.update_user(user, @update_attrs)
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_user(user, @invalid_attrs)
      assert user == Account.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Account.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Account.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Account.change_user(user)
    end

    test "create_user/1 with valid password hash" do
      assert {:ok, %User{} = user} = Account.create_user(@valid_attrs)
      assert {:ok, user} == Argon2.check_pass(user, "some password", hash_key: :hashed_password)
      assert user.username == "some username"
    end

    test "update_user/2 with valid password hash" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Account.update_user(user, @update_attrs)

      assert {:ok, user} ==
               Argon2.check_pass(user, "some updated password", hash_key: :hashed_password)

      assert user.username == "some updated username"
    end
  end

  describe "social_profiles" do
    alias Wirebuild.Account.SocialProfile

    @valid_attrs %{
      company: "some company",
      dev_to: "some dev_to",
      email: "some email",
      github: "some github",
      medium: "some medium",
      twitter: "some twitter"
    }
    @update_attrs %{
      company: "some updated company",
      dev_to: "some updated dev_to",
      email: "some updated email",
      github: "some updated github",
      medium: "some updated medium",
      twitter: "some updated twitter"
    }

    def social_profile_fixture(attrs \\ %{}) do
      {:ok, social_profile} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_social_profile()

      social_profile
    end

    test "list_social_profiles/0 returns all social_profiles" do
      social_profile = social_profile_fixture()
      assert Account.list_social_profiles() == [social_profile]
    end

    test "get_social_profile!/1 returns the social_profile with given id" do
      social_profile = social_profile_fixture()
      assert Account.get_social_profile!(social_profile.id) == social_profile
    end

    test "create_social_profile/1 with valid data creates a social_profile" do
      assert {:ok, %SocialProfile{} = social_profile} =
               Account.create_social_profile(@valid_attrs)

      assert social_profile.company == "some company"
      assert social_profile.dev_to == "some dev_to"
      assert social_profile.email == "some email"
      assert social_profile.github == "some github"
      assert social_profile.medium == "some medium"
      assert social_profile.twitter == "some twitter"
    end

    test "update_social_profile/2 with valid data updates the social_profile" do
      social_profile = social_profile_fixture()

      assert {:ok, %SocialProfile{} = social_profile} =
               Account.update_social_profile(social_profile, @update_attrs)

      assert social_profile.company == "some updated company"
      assert social_profile.dev_to == "some updated dev_to"
      assert social_profile.email == "some updated email"
      assert social_profile.github == "some updated github"
      assert social_profile.medium == "some updated medium"
      assert social_profile.twitter == "some updated twitter"
    end

    test "delete_social_profile/1 deletes the social_profile" do
      social_profile = social_profile_fixture()
      assert {:ok, %SocialProfile{}} = Account.delete_social_profile(social_profile)
      assert_raise Ecto.NoResultsError, fn -> Account.get_social_profile!(social_profile.id) end
    end

    test "change_social_profile/1 returns a social_profile changeset" do
      social_profile = social_profile_fixture()
      assert %Ecto.Changeset{} = Account.change_social_profile(social_profile)
    end
  end
end
