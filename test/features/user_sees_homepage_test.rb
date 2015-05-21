require_relative '../test_helper'

class UserSeesHomepageTest < FeatureTest
  def test_the_user_sees_homepage
    visit '/'
    within("h1") do
      assert page.has_content?("Welcome to Robot World!")
    end
  end
end
