class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]
  
  has_many :posts, dependent: :destroy

  has_many :private_messages, class_name: 'Private::Message'
	has_many  :private_conversations, 
	          foreign_key: :sender_id, 
	          class_name: 'Private::Conversation'
  has_many :contacts
  has_many :all_received_contact_requests,  
            class_name: "Contact", 
            foreign_key: "contact_id"
            
  has_many :group_messages, class_name: 'Group::Message'
  has_and_belongs_to_many :group_conversations, class_name: 'Group::Conversation'
  
  has_many :accepted_sent_contact_requests, -> { where(contacts: { accepted: true}) }, 
            through: :contacts, 
            source: :contact
  has_many :accepted_received_contact_requests, -> { where(contacts: { accepted: true}) }, 
            through: :all_received_contact_requests, 
            source: :user
  has_many :pending_sent_contact_requests, ->  { where(contacts: { accepted: false}) }, 
            through: :contacts, 
            source: :contact
  has_many :pending_received_contact_requests, ->  { where(contacts: { accepted: false}) }, 
            through: :all_received_contact_requests, 
            source: :user
  
  
  # gets all your contacts
  def all_active_contacts
    accepted_sent_contact_requests | accepted_received_contact_requests
  end
  
  # gets your pending sent and received contacts
  def pending_contacts
    pending_sent_contact_requests | pending_received_contact_requests
  end
  
  # gets a Contact record
  def contact(contact)
    Contact.where(user_id: self.id, contact_id: contact.id)[0]
  end
  
  def self.from_google(u)
    create_with(uid: u[:uid], provider: 'google',
                password: Devise.friendly_token[0, 20]).find_or_create_by!(email: u[:email])
end

end
