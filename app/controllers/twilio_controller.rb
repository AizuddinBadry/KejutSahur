require 'twilio-ruby'

class TwilioController < ApplicationController

  before_action :authenticate_twilio_request, :only => [
    :connect
  ]
  # Render home page
  def index
    render 'index'
  end

  # Handle a POST from our web form and connect a call via REST API
  def call
  @@twilio_sid = '#'
  @@twilio_token = '#'
  @@twilio_number = '#'
  @@api_host = '#'

    contact = Contact.new
    contact.user_phone  = params[:userPhone]
      @client = Twilio::REST::Client.new @@twilio_sid, @@twilio_token
      # Connect an outbound call to the number submitted
      @call = @client.calls.create(
        :from => @@twilio_number,
        :to => contact.user_phone,
        :timeout => 29,
        :url => "#{@@api_host}/lagu" # Fetch instructions from this URL when the call connects
      )
      # Let's respond to the ajax call with some positive reinforcement
      @msg = { :message => 'Phone call incoming!', :status => 'ok' }
  end

  def lagu
    response = Twilio::TwiML::Response.new do |r|
      r.Play "http://twilight3g.com/mp3-ringtones/tone/2015/xmas/raya1_YtkpbVP6.mp3"
    end
    render :xml => response.to_xml
  end

  # Authenticate that all requests to our public-facing TwiML pages are
  # coming from Twilio. Adapted from the example at
  # http://twilio-ruby.readthedocs.org/en/latest/usage/validation.html
  # Read more on Twilio Security at https://www.twilio.com/docs/security
  private
  def authenticate_twilio_request
    twilio_signature = request.headers['HTTP_X_TWILIO_SIGNATURE']
    # Helper from twilio-ruby to validate requests.
    @validator = Twilio::Util::RequestValidator.new(@@twilio_token)

    # the POST variables attached to the request (eg "From", "To")
    # Twilio requests only accept lowercase letters. So scrub here:
    post_vars = params.reject {|k, v| k.downcase == k}

    is_twilio_req = @validator.validate(request.url, post_vars, twilio_signature)

    unless is_twilio_req
      render :xml => (Twilio::TwiML::Response.new {|r| r.Hangup}).text, :status => :unauthorized
      false
    end
  end

end
