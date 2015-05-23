require_relative '../test_helper'

class UserSeesHomepageTest < FeatureTest
  def test_the_user_sees_welcome
    visit '/'
    within("#welcome") do
      assert page.has_content?("Welcome to Robot World!")
    end
  end

  def test_the_user_sees_average_age
    RobotWorld.create({:name => "Benny", :birthday => "2015-04-20"})
    RobotWorld.create({:name => "Benny", :birthday => "2011-04-20"})
    visit '/'
    within("#average_age") do
      assert page.has_content?("Average Age at Robot World: 2")
    end
  end
end
