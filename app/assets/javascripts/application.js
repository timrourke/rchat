// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require websocket_rails/main

$(document).on('ready', function() {

	var user = window.user || undefined;

	if (user) {
		var dispatcher = new WebSocketRails('localhost:3000/websocket');

		var channel = dispatcher.subscribe('chatroom');

		dispatcher.on_open = function(data) {
		  console.log('Connection has been established: ', data);

		  var message = {};

		  message.id 	= user.id;
		  message.username	= user.username;

		  dispatcher.trigger('client_connected', message);
		  // You can trigger new server events inside this callback if you wish.
		}	

		$chatForm = $('#js-chat-input-form');
		$chatFormInput = $('#js-chat-input');
		$chatMessages = $('#js-chat-messages');
		$chatMessagesPane = $('#js-chat-messages-pane');
		$chatUsers = $('#js-chat-users');

		function userConnectedMessage(connectedUser) {
			if (connectedUser.username == '' || !connectedUser.hasOwnProperty('username') || connectedUser.id == user.id) {
				return;
			}

			var messageItem = $('<li class="chat__system"><em>' + connectedUser.username + ' has joined chat.</em></li>')

			$chatMessagesPane.animate({
				scrollTop: $chatMessagesPane.height()
			}, 10);

			$chatMessages.append(messageItem);
		}

		function userDisconnectedMessage(disconnectedUser) {
			if (disconnectedUser.username == '' || !disconnectedUser.hasOwnProperty('username') || disconnectedUser.id == user.id) {
				return;
			}

			var messageItem = $('<li class="chat__system"><em>' + disconnectedUser.username + ' has left chat.</em></li>')

			$chatMessagesPane.animate({
				scrollTop: $chatMessagesPane.height()
			}, 10);

			$chatMessages.append(messageItem);
		}

		$chatForm.on('submit', function(e){
			e.preventDefault();

			//Don't submit if nothing in input
			if ($chatFormInput.val().trim() == '') {
				return;
			}

			var message = {};

			message.id	 = user.id;
			message.username = user.username;
			message.body 		 = $chatFormInput.val();

			dispatcher.trigger('new_message', message);

			//Clear input after submission.
			$chatFormInput.val('');

			return false;
		});

		channel.bind('chat_message', function(message) {
			var messageClass;

			if (message.id == user.id) {
				messageClass = 'chat__self';
			}

			var messageItem = $('<li class="' + messageClass + '">' + message.username + ': ' + message.body + '</li>')

			$chatMessagesPane.animate({
				scrollTop: $chatMessagesPane.height()
			}, 10);

			$chatMessages.append(messageItem);
		});

		channel.bind('client_connected', function(message) {
			var chatUsers = '';

			var json = JSON.parse(message);
			
			if (Array.isArray(json)) {
				for (var index in json) {
					if (json[index].hasOwnProperty('username')) {
						chatUsers += '<li>' + json[index].username + '</li>';
						userConnectedMessage(json[index]);	
					}
				}					
			} else {
				if (json.hasOwnProperty('username')) {
					chatUsers += '<li>' + json.username + '</li>';
					userConnectedMessage(json);	
				}
			}
			
			$chatUsers.html($(chatUsers));
		});

		channel.bind('client_disconnected', function(message) {
			var chatUsers = '';

			console.log('disconnected message')
			console.log(message);

			var json = JSON.parse(message);
			
			if (Array.isArray(json)) {
				for (var index in json) {
					if (json[index].hasOwnProperty('username')) {
						chatUsers += '<li>' + json[index].username + '</li>';
						userDisconnectedMessage(json[index]);	
					}
				}
			} else {
				if (json.hasOwnProperty('username')) {
					chatUsers += '<li>' + json.username + '</li>';
					userDisconnectedMessage(json);	
				}
			}
					
			$chatUsers.html($(chatUsers));
		});
	}

	$('body').on('click', '.js-form-login-toggle', function() {
		$('.site-login-form').toggleClass('open');
	});
});
