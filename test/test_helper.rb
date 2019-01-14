$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'korbit_api'

require 'minitest/autorun'
# require 'pry'

require 'dotenv'
Dotenv.load '.env.test'
