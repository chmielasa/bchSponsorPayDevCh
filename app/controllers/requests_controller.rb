class RequestsController < ApplicationController

  def new
  end

  def show
    # Set up Request instance (@req). Request class is overridden.
    req = Request.new
    req.uid = params[:uid]
    req.pub0 = params[:pub0]
    req.page = params[:page]

    res = req.get_offers

    # Ensure the validity of the response using X-Sponsorpay-Response-Signature
    res_hash = Digest::SHA1.hexdigest(res.body + Request::API_KEY)
    res_hash.eql?(res['X-Sponsorpay-Response-Signature'])? @res_valid = true : @res_valid = false

    # Other response information
    @res_code  = res.code
    @res_body_message = ActiveSupport::JSON.decode(res.body)['message']
    @res_offers = ActiveSupport::JSON.decode(res.body)['offers']
  end
end
