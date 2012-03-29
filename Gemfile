source :rubygems

gem "mongoid",            '~> 3.0', :git => 'git://github.com/mongoid/mongoid.git'

group :development do
  gem "rdoc", 		">= 3.12"
  gem "bundler", 	">= 1.0.0"
  gem "jeweler", 	">= 1.8.3"
  gem "simplecov",">= 0.5"
end

group :development, :test do
  gem "rspec", 		">= 2.8.0"
end

group :test do
	gem "bson_ext",           '>= 1.6.1'
end

# Specify gem dependencies in mongoid-paperclip.gemspec
gemspec
