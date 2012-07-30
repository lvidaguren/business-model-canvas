require 'test_helper'

class InvitationsControllerTest < ActionController::TestCase
  test "should get invite" do
    get :invite
    assert_response :success
  end

end
