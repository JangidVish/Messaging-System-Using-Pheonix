defmodule MessagingSystemWeb.MessageController do
  use MessagingSystemWeb, :controller

  alias MessagingSystem.Messages

  def create(conn, %{"sender" => sender, "content" => content}) do
    case Messages.create_message(%{"sender" => sender, "content" => content}) do
      {:ok, message} -> Phoenix.Controller.json(conn, message)
      {:error, _reason} -> Phoenix.Controller.json(conn, %{error: "Error saving message"})
    end
  end

  def index(conn, _params) do
    messages = Messages.list_messages()
    Phoenix.Controller.json(conn, messages)
  end
end
