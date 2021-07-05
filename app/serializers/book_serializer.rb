class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :author, include: :user_books
end
