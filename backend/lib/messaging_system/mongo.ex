defmodule MessagingSystem.Mongo do
    use GenServer
    alias Mongo

    @mongo_url "mongodb://localhost:27017"
    @database "messaging_system_db"

#Start Server
def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
end

def init(_) do
    {:ok, conn} = Mongo.start_link(url: @mongo_url, database: @database)
    {:ok, conn}
end

def get_conn do
    GenServer.call(__MODULE__, :get_conn)
end

def handle_call(:get_conn, _from, state) do
    {:reply, state, state}
end

end
