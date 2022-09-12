class ContactSerializer
  include JSONAPI::Serializer
  attributes :id,
             :first_name,
             :last_name,
             :email,
             :role,
             :image,
             :created_at,
             :updated_at,
             :avatar_url
end
