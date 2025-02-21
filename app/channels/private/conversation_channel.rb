class Private::ConversationChannel < ApplicationCable::Channel
  def subscribed
    current_user=connection.current_user
    if current_user.id
      stream_for "private_conversations_#{current_user.id}"
    else
      reject
    end
  end

  def unsubscribed
    stop_all_streams
  end
  def send_message(data)
    message_params = data['message'].each_with_object({}) do |el, hash|
      hash[el['name']] = el['value']
    end
    Private::Message.create(message_params)
  end
end
