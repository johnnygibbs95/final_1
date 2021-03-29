# frozen_string_literal: true
require 'bundler'
Bundler.require

require_relative "final_1/version"
require_relative "final_1/cli"
require_relative "final_1/list_breweries_api"
require_relative 'final_1/brewery'
require_relative "final_1/note"
require_relative "final_1/user"

module Final1
  class Error < StandardError; end
  # Your code goes here...
end
