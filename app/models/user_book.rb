class UserBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  enum status: {Prestado: 0, Devuelto: 1}
end
