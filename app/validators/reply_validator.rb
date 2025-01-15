# frozen_string_literal: true

class ReplyValidator < ActiveModel::Validator
  def validate(record)
    if record.in_reply_to.nil? || !record.in_reply_to.activated
      record.errors.add('content', 'User ID does not exist or account is unactivated.')
    elsif record.in_reply_to.reply_name != record.content_object.reply_name
      record.errors.add('content', 'Reply name is invalid.')
    end
  end
end
