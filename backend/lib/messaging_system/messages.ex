defmodule MessagingSystem.Messages do
  alias Mongo
  alias MessagingSystem.Messages.Message
  import BSON.ObjectId

  def list_messages do
    conn = MessagingSystem.Mongo.get_conn()
    #{:ok, conn} = Mongo.get_conn()
    cursor = Mongo.find(conn, "messages", %{})

  cursor
  |> Enum.map(fn doc -> Map.update!(doc, "_id", &BSON.ObjectId.encode!/1) end)
  end

  def create_message(attrs) do
    conn = MessagingSystem.Mongo.get_conn()  # ✅ Get MongoDB connection
    message = %{
      #"_id" => ObjectId.encode(),
      "sender" => attrs["sender"],
      "content" => attrs["content"],
      "inserted_at" => DateTime.utc_now()
    }

    case Mongo.insert_one(conn, "messages", message) do  # ✅ Use `Mongo.insert_one/3` correctly
      {:ok, %{inserted_id: id}} ->
        {:ok, Map.put(message, "_id", BSON.ObjectId.encode!(id))}
      {:error, reason} -> {:error, reason}
    end
  end

  end
