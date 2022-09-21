class ContactSerializer
  include JSONAPI::Serializer
  attributes :id, :first_name, :last_name, :email, :role
  belongs_to :user
end
