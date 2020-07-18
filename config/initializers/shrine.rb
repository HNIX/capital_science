require "shrine"
require "shrine/storage/s3"

s3_options = Rails.application.credentials.s3

Shrine.storages = {
  cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options),
  store: Shrine::Storage::S3.new(**s3_options),
}

Shrine.plugin :activerecord           # load Active Record integration
Shrine.plugin :cached_attachment_data # for retaining cached file on form redisplays
Shrine.plugin :restore_cached_data    # refresh metadata for cached files