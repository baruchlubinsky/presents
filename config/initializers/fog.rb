CarrierWave.configure do |config| 
  config.storage = :fog
  config.fog_credentials = { 
    :provider               => 'AWS', 
    :aws_access_key_id      => 'AKIAIRY5P4NTVFEJ7PTQ', 
    :aws_secret_access_key  => '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', 
    :region                 => 'eu-west-1'
  } 
  #config.fog_host = 'https://s3-eu-west-1.amazonaws.com'
  if Rails.env.production?
    config.fog_directory  = 'presentsinthepost' 
  else
    config.fog_directory  = 'presentsdevelopment'
  end   
  config.fog_public = true 
end