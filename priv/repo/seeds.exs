require Logger

alias TotalRecall.Repo
alias TotalRecall.Accounts
alias TotalRecall.Accounts.User

Logger.info  "Deleting data..."
Repo.delete_all(User)

user_data = [
  %{
    email: "user@total-recall.app",
    full_name: "John Doe",
    username: "jdoe",
    password: "password"
  },
  %{
    email: "jdilla@gmail.com",
    full_name: "Jay Dilla",
    username: "jdilla",
    password: "password"
  },
]

Logger.info  "Seeding Users..."
Enum.each(user_data, fn(data) ->
  case Accounts.register_user(data) do
    {:ok, _} -> Logger.info "Created #{data[:full_name]}..."
    {:error, error} -> Logger.info "Could not create #{data[:full_name]}..."
  end
end)

Logger.info  "Finished seeding 🎉"
