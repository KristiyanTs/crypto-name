Wordnik.configure do |config|
  config.api_key = '3232d58663812a234407b0d40c80f8b2711b09209f4da325f'
  config.response_format = 'json'             # defaults to json, but xml is also supported
  config.logger = Logger.new('/dev/null')     # defaults to Rails.logger or Logger.new(STDOUT). Set to Logger.new('/dev/null') to disable logging.
end