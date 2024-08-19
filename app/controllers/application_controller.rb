# frozen_string_literal: true

class ApplicationController < ActionController::Base # rubocop:disable Style/Documentation
  def hello
    render html: 'hello, world!'
  end
end
