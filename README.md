# Seltzer API

[project.com](https://project.com)

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

## Getting Client ID & Client Secret for your clients

You will need to get the `client_id` and `client_secret` for the frontend react client or other clients you decide to create. You

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
