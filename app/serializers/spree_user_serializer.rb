class SpreeUserSerializer < ActiveModel::Serializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :created_at
end
