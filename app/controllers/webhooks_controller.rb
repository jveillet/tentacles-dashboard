# frozen_string_literal: true

require 'json'

##
# Webhooks controller.
#
class WebhooksController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    push = JSON.parse(request.body.read)
    puts "I got some JSON: #{push.inspect}"
    puts "I got some headers: #{params.inspect}"
  end
end
