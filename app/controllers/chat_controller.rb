class ChatController < WebsocketRails::BaseController
  def initialize_session
    # perform application setup here
    controller_store[:message_count] = 0
  end

  def client_connected
  	puts 'Client connected to websocket!'
    connection_store[:chat_users] = message
    users = connection_store.collect_all(:chat_users)
    WebsocketRails[:chatroom].trigger(:client_connected, users.to_json)
  end

  def new_message
  	puts 'New message received.'
    @sanitized_message = {
      :id => message[:id],
      :username => message[:username],
      :body => ActionController::Base.helpers.sanitize(message[:body], tags: %w(strong em a h1 h2 h3 h4 h5 h6 p pre br), attributes: %w(href))
    }

    if @sanitized_message[:body] != ''
      WebsocketRails[:chatroom].trigger(:chat_message, @sanitized_message )
    end
  end

  # def new_user
  # 	puts 'New user action'
  # end

  # def change_username
  # 	puts 'Change username action'
  # end

  def delete_user
  	puts 'Delete user action'
    users = connection_store.collect_all(:chat_users)
    WebsocketRails[:chatroom].trigger(:client_disconnected, users.to_json)
  end
end