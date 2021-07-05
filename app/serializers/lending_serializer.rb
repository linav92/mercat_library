class LendingSerializer < ActiveModel::Serializer
  attributes :id, :status, :user_id, :book_id, :lending_at, :expire, include: ['book','user']
end