require 'test_helper'

class MicropostDecoratorTest < ActiveSupport::TestCase
  def setup
    # ActionViewのヘルパーメソッドを使用するためview_contextをセットする
    controller = ApplicationController.new
    controller.request = ActionDispatch::TestRequest.create
    ActiveDecorator::ViewContext.push controller.view_context
    @micropost = ActiveDecorator::Decorator.instance.decorate(microposts(:orange))
  end

  test "decorated content include user link when reply" do
    @archer = users(:archer)
    @micropost.content = "#{@archer.reply_name} content"
    @micropost.in_reply_to = @archer
    assert_match /<a href=.*>/i, @micropost.decorated_content
  end

  test "decorated content equal content when micropost" do
    content = "content"
    @micropost.content = content
    assert_equal content, @micropost.decorated_content
  end
end
