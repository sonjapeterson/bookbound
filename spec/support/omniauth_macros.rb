module OmniauthMacros
  def mock_auth_hash
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      'uid' => '123545',
      'provider' => 'facebook',
      'info' => {
        'email' => 'mock@gmail.com',
        'name' => 'mock user',
        'first_name' => 'mock',
        'last_name' => 'user',
        'image' => 'mock_user_thumbnail_url'
      },
      "credentials"=> {"token"=>
          "abc123",
          "expires_at"=>(Time.new(2050)),
          "expires"=>true },
       "extra"=>
        {"raw_info"=>
          {"id"=>"10152268356815017",
           "email"=>"mock@gmail.com",
           "first_name"=>"mock",
           "gender"=>"female",
           "last_name"=>"user",
           "locale"=>"en_US",
           "name"=>"mock user",
           "timezone"=>-4,
           "verified"=>true}
        }
      })
  end
end