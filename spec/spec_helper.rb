require 'chefspec'
require 'chefspec/berkshelf'

Dir['libraries/*.rb'].each { |f| require File.expand_path(f) }

ALMA_8 = {
  platform: 'almalinux',
  version: '8',
}.freeze

ALMA_9 = {
  platform: 'almalinux',
  version: '9',
}.freeze

ALL_PLATFORMS = [
  ALMA_8,
  ALMA_9,
].freeze

RSpec.configure do |config|
  config.log_level = :warn
end
