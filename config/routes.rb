Rails.application.routes.draw do
  root 'twilio#index'

  get '/customerlist' => 'customers#customerphone'

  post '/call' => 'twilio#call'
  post '/connect/:sales_number' => 'twilio#connect'
  post '/voice' => 'twilio#voice'
  post '/store' => 'customers#store'

end
