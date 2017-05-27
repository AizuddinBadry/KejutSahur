require 'twilio-ruby'

class TwilioController < ApplicationController
  # Before we allow the incoming request to connect, verify
  # that it is a Twilio request
  before_action :authenticate_twilio_request, :only => [
    :connect
  ]

  # Define our Twilio credentials as instance variables for later use
 
  # Render home page
  def index
    render 'index'
  end

  # Handle a POST from our web form and connect a call via REST API
  def call
  @@twilio_sid = 'ACe9f7c8e82c2bb9b2d946d9714651f3d3'
  @@twilio_token = '1f52df9d6e239fc7fc0562fa238eec08'
  @@twilio_number = '+60162991318'
  @@api_host = 'https://bafe-sahur.herokuapp.com'

    contact = Contact.new
    contact.user_phone  = params[:userPhone]
      @client = Twilio::REST::Client.new @@twilio_sid, @@twilio_token
      # Connect an outbound call to the number submitted
      @call = @client.calls.create(
        :from => @@twilio_number,
        :to => contact.user_phone,
        :url => "http://twimlets.com/holdmusic?Bucket=com.twilio.music.classical&Message=Selamat%20Bersahur%20BAFE%20" # Fetch instructions from this URL when the call connects
      )
      # Let's respond to the ajax call with some positive reinforcement
      @msg = { :message => 'Phone call incoming!', :status => 'ok' }
  end

  # This URL contains instructions for the call that is connected with a lead
  # that is using the web form.
  def connect
    # Our response to this request will be an XML document in the "TwiML"
    # format. Our Ruby library provides a helper for generating one
    # of these documents
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Thanks for contacting our sales department. Our ' +
        'next available representative will take your call.', :voice => 'alice'
      r.Dial params[:sales_number]
    end
    render text: response.text
  end

  def voice
    response = Twilio::TwiML::Response.new do |r|
      r.Say "Terima kasih kerana menghubungi Bafe!", voice: "alice"
      r.Sms "Terima kasih kerana menghubungi Bafe!"
      r.Play "http://linode.rabasa.com/cantina.mp3"
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
