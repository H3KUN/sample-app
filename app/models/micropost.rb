class Micropost < ApplicationRecord
  belongs_to :user
  belongs_to :in_reply_to, class_name: 'User', foreign_key: 'in_reply_to_id', optional: true
  composed_of :content_object, class_name: 'MicropostContent', mapping: %w(content micropost_content)
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end
  default_scope -> { order(created_at: :desc) }
  before_validation :assign_in_reply_to
  validates :user_id, presence: true
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png], message: 'must be a valid image format'}, size: { less_than: 5.megabytes, message: 'should be less than 5MB'}
  validates :content, length: { maximum: 140 }
  validates :content_object, presence: true
  validates_with ReplyValidator, if: -> { content_object.reply? }

  class << self
    def looks(word)
      return Micropost.all unless word
      @micropost = Micropost.joins(:user).where('content LIKE? OR name LIKE?',"%#{word}%", "%#{word}%")
    end

    def including_replies(user_id)
      where('user_id = :user_id OR in_reply_to_id = :user_id', user_id: user_id)
    end
  end

  def reply?
    !in_reply_to.nil?
  end

  private
  def assign_in_reply_to
    if content_object.reply?
      self.in_reply_to = User.find_by(id: content_object.reply_name.user_id)
    end
  end
end
