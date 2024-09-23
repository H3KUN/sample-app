# frozen_string_literal: true

class ReplyName
  include Comparable
  attr_reader :user_id

  def initialize(user_id, user_name)
    @user_id = user_id
    @name = user_name
  end

  def <=>(other)
    to_s <=> other.to_s
  end

  def to_s
    "@#{@user_id}-#{@name.gsub(/\s/, '-')}"
  end

  def valid?
    !!@user_id && !!@name
  end
end
