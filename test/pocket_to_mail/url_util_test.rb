class UrlUtilTest < Minitest::Test
  def test_remove_utm
    base_url = "http://www.example.com/"

    assert_equal(base_url, remove_utm(base_url))

    assert_equal(base_url, remove_utm("#{base_url}?hmsr=123"))
    assert_equal(base_url, remove_utm("#{base_url}?utm_medium=abc"))
    assert_equal(base_url, remove_utm("#{base_url}?utm_source=def"))
    assert_equal(base_url, remove_utm("#{base_url}?utm_source=def&hmsr=123&utm_source=def"))

    assert_equal("#{base_url}abc?dd=ee&ff=gg", remove_utm("#{base_url}abc?dd=ee&ff=gg"))
    assert_equal(base_url, remove_utm("#{base_url}?"))

    assert_equal("#{base_url}abc?dd=%E5%AE%89%E5%AE%89", remove_utm("#{base_url}abc?dd=安安"))
  end

  def remove_utm(test_url)
    PocketToMail::UrlUtil.remove_utm(test_url)
  end
end
