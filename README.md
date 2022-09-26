# Seltzer API

Rails API and starter project for [Seltzer CLI](https://github.com/fizzypop-studio/seltzer) or yourself.

## Install

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 3.1.2`

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv) (it could take a while):

```shell
rbenv install 3.1.2
```

### Install dependencies

Using postgresql for the database so you will need that unless you want to configure your own setup. In order to successfully go throught the initial `bundle install` you will need it installed via [Homebrew](https://brew.sh/)

```shell
brew install postgresql@14
```

You can also install the [Postgres app](https://postgresapp.com/downloads.html) as well for a nice way to manage your local databases with a GUI.

Using [Bundler](https://github.com/bundler/bundler)

```shell
bundle install
```

### Initialize the database

```shell
rails db:setup
```

## Serve

```shell
rails s
```

This project is setup to automatically run on port `3001` since the client runs on `3000`

## Getting Client ID & Client Secret for your clients

This applciation utilizes [Doorkeeper](https://github.com/doorkeeper-gem/doorkeeper) to authorize users to your API and makes it easy to introduce OAuth 2 provider functionality to your Ruby on Rails application.. You will need to get the `client_id` and `client_secret` for the frontend react client or other clients you decide to create. 

1. Open rails console

```shell
rails c
```

2. Set Application variable in console
   
```shell
@application = Doorkeeper::Application.find_by(name: "React Client")
```

3. Retrieve client id

```shell
@application.uid
```

4. Retrieve client secret

```shell
@application.secret
```
