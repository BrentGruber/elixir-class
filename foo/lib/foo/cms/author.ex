defmodule Foo.CMS.Author do
  use Ecto.Schema
  import Ecto.Changeset

  alias Foo.CMS.Page

  schema "authors" do
    field :bio, :string
    field :role, :string
    has_many :pages, Page
    belongs_to :user, Foo.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:bio, :role])
    |> validate_required([:bio, :role])
    |> unique_constraint(:user_id)
  end
end
