class OrderConversationsService

  def initialize(params)
    @user = params[:user]
  end

  # get and order conversations by last messages' dates in descending order
  def call
    all_private_conversations = Private::Conversation.all_by_user(@user.id)
                                                    .includes(:messages)
    all_group_conversations = @user.group_conversations.includes(:messages)
    Rails.logger.debug("PrivateConvs: #{all_private_conversations.count}")
    Rails.logger.debug("GroupConvs: #{all_group_conversations.count}")
    all_conversations = all_private_conversations + all_group_conversations
    return all_conversations=all_conversations.sort do |a, b|
      # Handle empty message lists to avoid errors
      last_message_a = a.messages.last
      last_message_b = b.messages.last
      
      # Compare only if messages exist
      if last_message_a && last_message_b
        last_message_b.created_at <=> last_message_a.created_at
      else
        # If one of the conversations has no messages, give preference to the one with messages
        last_message_b ? 1 : -1
      end
    end
  end
end
