if ['staging', 'production'].include? Rails.env
  PAPERCLIP_OPTIONS = {
    path:        ':class/:attachment/:id_partition/:hash/:style.:extension',
    url:         ':class/:attachment/:id_partition/:hash/:style.:extension',
    hash_secret: (ENV['PAPERCLIP_SECRET'] || raise('You have to specify a PAPERCLIP_SECRET secret')),
    storage: :s3,
    bucket: (ENV['S3_BUCKET'] || raise('Specify an S3_BUCKET!!!')),
    s3_permissions: :public_read,
    s3_host_name: 's3-eu-west-1.amazonaws.com',
    s3_protocol: 'https',
    s3_credentials: {
      access_key_id: (ENV['S3_ACCESS_KEY'] || raise('Specify an S3_ACCESS_KEY')),
      secret_access_key: (ENV['S3_ACCESS_SECRET'] || raise('Specify an S3_ACCESS_SECRET'))
    }

  }
else
  PAPERCLIP_OPTIONS = {
    # specifying the rails env with a folder so that we can
    # automatically clean up test folder when we want (After in env.rb)
    path:        ':rails_root/public/system/:rails_env/:class/:attachment/:id_partition/:hash/:style.:extension',
    url:         '/system/:rails_env/:class/:attachment/:id_partition/:hash/:style.:extension',
    hash_secret: (ENV['PAPERCLIP_SECRET'] || raise('You have to specify a PAPERCLIP_SECRET secret'))
  }
end
Paperclip::Attachment.default_options.update(PAPERCLIP_OPTIONS)
