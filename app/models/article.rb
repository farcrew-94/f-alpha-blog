class Article < ActiveRecord::Base
  # The validations
  #The attribute is needed and cannot be null and the length must be consider as follow
  validates :title, presence:true, length: {minimum: 3, maximum: 50}
  validates :description, presence:true, length: {minimum: 10, maximum: 300}

end
