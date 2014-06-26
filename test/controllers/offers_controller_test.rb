require 'test_helper'

class OffersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should be able to submit form data" do
    post :index
    assert_response :success
  end

  test "should get form validation error if all form fields are not filled in" do
    post :index
    assert_equal 'Please fill all the form fields', flash[:alert]
  end

  test "should handle incorrect page param gracefully" do
    post :index, { uid: 'player1', pub0: 'campaign2', page: 'invalid_page' }
    assert_select 'form input[name="page"]' do
      assert_select '[value=?]', 1
    end
  end

  test "should get 'no offers' message if no offers are found" do
    post :index, { uid: 'non_existent_player', pub0: 'campaign2', page: 1 }
    assert_select 'div.no_offers'
  end

  test "should get offers listing if offers are found" do
    # TODO: fails as these params don't actually return any offers
    post :index, { uid: 'player1', pub0: 'campaign2', page: 1 }
    assert_select 'div.offers'
  end

  test "should handle api errors gracefully" do
    post :index, { uid: '##@#$@#$ invalid param', pub0: 'campaign2', page: 1 }
    assert_equal 'Sorry, an API error occurred', flash[:alert]
  end

end
