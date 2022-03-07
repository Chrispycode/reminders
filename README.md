# Reminders


## Installation

Follow these easy steps to install and start the app:

### Set up Rails app

First, install the gems required by the application:

    bundle

next, install the npm packages required by the application:

    yarn install

Next, execute the database migrations/schema setup:

     bundle exec rails db:setup


### Start the app

Start the Rails app with a procces manager like [Hivemind](https://github.com/DarthSim/hivemind)

    hivemind Procfile.dev

or run these processes manually

    bin/rails server -p 3000 -b 0.0.0.0
    yarn build --watch
    yarn build:css --watch
    rake jobs:work

You can find your app now by pointing your browser to [http://localhost:3000](http://localhost:3000)
