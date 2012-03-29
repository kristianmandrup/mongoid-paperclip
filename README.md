Mongoid::Paperclip - Making Paperclip play nice with Mongoid ODM
================================================================

As the title suggests: `Mongoid::Paperclip` makes it easy to hook up [Paperclip](https://github.com/thoughtbot/paperclip) with [Mongoid](http://mongoid.org/).

This is actually easier and faster to set up than when using Paperclip and the ActiveRecord ORM.
This example assumes you are using **Ruby on Rails 3** and **Bundler**. However it doesn't require either.

Paperclip 3.0
-------------
Paperclip 3.0 introduces a non-backward compatible change in your attachment
path. This will help to prevent attachment name clashes when you have
multiple attachments with the same name. If you didn't alter your
attachment's path and are using Paperclip's default, you'll have to add
`:path` and `:url` to your `has_attached_file` definition. For example:

    has_attached_file :avatar,
      :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
      :url => "/system/:attachment/:id/:style/:filename"

Rails 3 Dummy app
-----------------
This project should contain a Rails 3 dummy app or siilar in order to test the functionality.


Setting it up
-------------

Simply define the `mongoid-paperclip` gem inside your `Gemfile`. Additionally, you can define the `aws-s3` gem if you want to upload your files to Amazon S3. *You do not need to explicitly define the `paperclip` gem itself, since this is handled by `mongoid-paperclip`.*

**Rails.root/Gemfile - Just define the following:**

    gem "mongoid-paperclip", :require => "mongoid_paperclip"
    gem "aws-s3",            :require => "aws/s3"

Next let's assume we have a User model and we want to allow our users to upload an avatar.

**Rails.root/app/models/user.rb - include the Mongoid::Paperclip module and invoke the provided class method**

    class User
      include Mongoid::Document
      include Mongoid::Paperclip

      has_mongoid_attached_file :avatar
    end


That's it
--------

That's all you have to do. Users can now upload avatars. Unlike ActiveRecord, Mongoid doesn't use migrations, so we don't need to define the Paperclip columns in a separate file. Invoking the `has_mongoid_attached_file` method will automatically define the necessary `:avatar` fields for you in the background.


A more complex example
----------------------

Just like Paperclip, Mongoid::Paperclip takes a second argument (hash of options) for the `has_mongoid_attached_file` method, so you can do more complex things such as in the following example.

    class User
      include Mongoid::Document
      embeds_many :pictures
    end

    class Picture
      include Mongoid::Document
      include Mongoid::Paperclip

      embedded_in :user, :inverse_of => :pictures

      has_mongoid_attached_file :attachment,
        :path           => ':attachment/:id/:style.:extension',
        :storage        => :s3,
        :url            => ':s3_alias_url',
        :s3_host_alias  => 'something.cloudfront.net',
        :s3_credentials => File.join(Rails.root, 'config', 's3.yml'),
        :styles => {
          :original => ['1920x1680>', :jpg],
          :small    => ['100x100#',   :jpg],
          :medium   => ['250x250',    :jpg],
          :large    => ['500x500>',   :jpg]
        },
        :convert_options => { :all => '-background white -flatten +matte' }
    end

    @user.pictures.each do |picture|
      <%= picture.attachment.url %>
    end


There you go
------------

Quite a lot of people have been looking for a solution to use Paperclip with Mongoid so I hope this helps!

If you need more information on either [Mongoid](http://mongoid.org/) or [Paperclip](https://github.com/thoughtbot/paperclip) I suggest checking our their official documentation and website.