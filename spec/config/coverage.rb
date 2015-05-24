require './spec/config/default'

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'coveralls'
Coveralls.wear!
