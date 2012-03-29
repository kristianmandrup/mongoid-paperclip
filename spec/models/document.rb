class Document
	include Mongoid::Document
  include Mongoid::Paperclip

  # Paperclip 3.0 compatibility
  has_mongoid_attached_file :avatar,
      :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
      :url => "/system/:attachment/:id/:style/:filename"
end