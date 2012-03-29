class User
  include Mongoid::Document
  embeds_many :pictures
end

