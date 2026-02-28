require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference "User.count", 1 do
      post users_url, params: {
        user: {
          display_name: "New User",
          email_address: "new@example.com",
          password: "password123"
        }
      }
    end

    assert_redirected_to new_session_path
  end
end
