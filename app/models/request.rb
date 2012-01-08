class Request

  # Initialize/GET SponsorPay offers.
  # Request parameters (except uid, pub0, page, timestamp) are defined in
  # config/request.yml.

  API_URL = 'http://api.sponsorpay.com/feed/v1/offers.json?'
  API_KEY = 'b07a12df7d52e6c118e5d47d3f9e60135b109a1f'
  
  attr_reader :appid, :format, :device_id, :locale, :ip,
              :offer_types, :sp_url, :uid, :pub0, :page, :timestamp

  attr_writer :uid, :pub0, :page, :timestamp

  def initialize
    # Initialize/Load constants from YAML
    config = YAML::load(File.open("#{Rails.root}/config/request.yml"))
    @appid       = config['appid']
    @format      = config['format']
    @device_id   = config['device_id']
    @locale      = config['locale']
    @ip          = config['ip']
    @offer_types = config['offer_types']
    date_time    = Time.new
    @timestamp   = date_time.to_time.to_i
  end

  def get_offers
    params  =  ActiveSupport::JSON.decode(self.to_json).to_query
    # Hash with SHA1 request parameters + API_KEY
    hashkey = Digest::SHA1.hexdigest(params + "&" + API_KEY)
    return Net::HTTP::get_response(URI.parse(API_URL + params + "&hashkey=#{hashkey}"))
  end
end
