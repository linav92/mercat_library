class ReturnedSerializer < ActiveModel::Serializer
  attributes :id, :status, :user_id, :book_id, :returned_at, include: ['book','user']

end
