# frozen_string_literal: true

require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  setup { create(:doorkeeper_application) }
  test "should get home" do
    get root_path
    assert_response :success
  end
end
