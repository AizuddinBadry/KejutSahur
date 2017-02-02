# Click to Call Rails

An example application implementing Click to Call using Twilio.

[Read the full tutorial here](https://www.twilio.com/docs/tutorials/walkthrough/click-to-call/ruby/rails)!

## Installation

Step-by-step on how to deploy, configure and develop on this example app.

### Fastest Deploy

Use Heroku to deploy this app immediately:

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/TwilioDevEd/clicktocall-rails)

### Getting Started

1. Grab the latest source

```
git clone git://github.com/TwilioDevEd/clicktocall-rails.git
```

1. Navigate to folder and create new Heroku Cedar app

```
heroku create
```

1. Deploy to Heroku

```
git push heroku master
```

1. Scale your dynos

```
heroku scale web=1
```

1. Visit the home page of your new Heroku app to see your newly configured app!

```
heroku open
```


### Configuration

#### Setting Your Environment Variables

Are you using a bash shell? Use echo $SHELL to find out. For a bash shell edit the ~/.bashrc or ~/.bashprofile file and add:
```
export TWILIO_ACCOUNT_SID=ACxxxxxxxxxxxxxx
export TWILIO_AUTH_TOKEN=yyyyyyyyyyyyyyyyy
export TWILIO_NUMBER=+15556667777
export API_HOST=https://example.herokuapp.com
```

Are you using Windows or Linux? You can read more on how to set variables [here](https://www.java.com/en/download/help/path.xml).

### Development

Getting your local environment setup to work with this app is easy.  
After you configure your app with the steps above use this guide to
get going locally:

1. Install the dependencies

```
bundle install
```

1. Launch local development webserver

```
rails server
```

1. Open browser to [http://localhost:3000](http://localhost:3000)

1. Tweak away on `app/controllers/twilio_controller.rb`

## Meta

* No warranty expressed or implied.  Software is as is. Diggity.
* [MIT License](http://www.opensource.org/licenses/mit-license.html)
* Lovingly crafted by Twilio Developer Education.
