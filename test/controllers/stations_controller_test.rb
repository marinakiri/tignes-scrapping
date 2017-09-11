require 'test_helper'

class StationsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get stations_show_url
    assert_response :success
  end

end
