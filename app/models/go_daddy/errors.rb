# frozen_string_literal: true

module GoDaddy
  module Errors
    class Error < StandardError; end
    class NotFound < Error; end
  end
end
