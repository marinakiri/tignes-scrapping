require 'test_helper'

class ClassifiedsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get classifieds_index_url
    assert_response :success
  end

end
