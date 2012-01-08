require 'test_helper'

class RequestsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get show" do
    get(:show, {"uid" => "player1", "pub0" => "campaign2", "page" => 1})
    assert_response :success
    assert_select 'h2', "Real response: true"
    assert_not_nil assigns(:res_code)
    assert_not_nil assigns(:res_body_message)
    assert_not_nil assigns(:res_offers)
  end

end
