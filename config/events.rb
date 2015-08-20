WebsocketRails::EventMap.describe do
  # The :client_connected method is fired automatically when a new client connects
  subscribe :client_connected, to: ChatController, with_method: :client_connected

  # You can subscribe any number of controller actions to a single event
  subscribe :new_message, to: ChatController, with_method: :new_message
  # subscribe :new_message, to: ChatLogController, with_method: :log_message

  # subscribe :new_user, to: ChatController, with_method: :new_user
  # subscribe :change_username, to: ChatController, with_method: :change_username

  # The :client_disconnected method is fired automatically when a client disconnects
  subscribe :client_disconnected, to: ChatController, with_method: :delete_user
  subscribe :connection_closed, to: ChatController, with_method: :delete_user
end
