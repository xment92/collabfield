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
end
