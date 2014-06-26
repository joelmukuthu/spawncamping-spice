require 'test_helper'
require 'sp_api'

class SpApiTest < Minitest::Test
  def test_should_create_a_url_encoded_string_from_params_hash
    hash = { a: 'a', b: 'b' }
    assert_equal SpApi.send(:create_query_string, hash), "a=a&b=b"
  end

  def test_should_generate_correct_hashkey
    # generate hashkey using data from the example in the docs
    params = {
      appid: 157,
      uid: 'player1',
      ip: '212.45.111.17',
      locale: 'de',
      device_id: '2b6f0cc904d137be2e1730235f5664094b831186',
      ps_time: 1312211903,
      pub0: 'campaign2',
      page: 2,
      timestamp: 1312553361
    }
    Rails.application.config.sp_api_key = 'e95a21621a1865bcbae3bee89c4d4f84'
    assert_equal SpApi.send(:create_hashkey, params), '7a2b1604c03d46eec1ecd4a686787b75dd693c4d'
  end

  def test_should_return_array_of_offers
    Rails.application.config.sp_api_key = ENV['SP_API_KEY']
    offers = SpApi.fetch_offers 'player1', 'campaign2', 1
    assert_equal offers.is_a?(Array), true
  end

  def test_should_raise_bad_request_exception_for_invalid_params
    exception = assert_raises(RuntimeError) do 
      Rails.application.config.sp_api_key = ENV['SP_API_KEY']
      offers = SpApi.fetch_offers 'player1', 'campaign2', 'bad_page_param'
    end
    assert_equal exception.message, "Request failed[400]: Bad Request"
  end

  def test_should_raise_unauthorized_exception_for_invalid_api_key
    exception = assert_raises(RuntimeError) do 
      Rails.application.config.sp_api_key = 'BAD_KEY'
      offers = SpApi.fetch_offers 'player1', 'campaign2', 1
    end
    assert_equal exception.message, "Request failed[401]: Unauthorized"
  end
end