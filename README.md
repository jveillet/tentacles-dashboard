<div align="center">
  <img alt="Tentacles" src="https://raw.githubusercontent.com/jveillet/tentacles-dashboard/master/app/webpacker/images/logo.png" width="256px">
  <h1>Tentacles</h1>
  <strong>Pull requests dashboard</strong>
</div>

[![Actions Status](https://github.com/jveillet/tentacles-dashboard/workflows/Ruby/badge.svg)](https://github.com/jveillet/tentacles-dashboard/actions)

Tentacles displays all the pull requests from your repositories, and the organizations you belong to, curated into a single interface.

[![Tentacles](https://raw.githubusercontent.com/jveillet/tentacles-dashboard/master/app/webpacker/images/tentacles_screenshot.png)](#features)

## Prerequisites

* Ruby 2.6.3
* Yarn 1.17.3
* PostgreSQL 11.5

## Features

* Sign In with your Github account, no need to create an account and remember a password!
* Select the repositories you want to track pull requests with, and save your preferences.
* Display the dashboard of pull requests to review, it's automatically sorted from oldest to newest, and an empahsys is
made to those that are superior than 6 month/3 month/1 month/15 days old.
* Pull request's CI status is updating every 15 minutes.

## Configuration

This application is storing the configuration of the environment in a `.env` file, it uses the principles behind a [twelve-factor app](https://12factor.net/).

You can find an example of this file in the [.env.example](https://github.com/jveillet/tentacles-dashboard/blob/master/.env.example) file.

### GitHub App

You will first need need to create a GitHub app. Instructions are described in the [Creating a GitHub App](https://developer.github.com/apps/building-github-apps/creating-a-github-app/) documentation page.

Copy the GitHub client Id and secrets into the `.env`.

```
GITHUB_CLIENT_ID=your_app_client_id
GITHUB_CLIENT_SECRET=your_app_client_secret
```

### Database

Generate a random secret for the database password and put them in the `.env`.
```
# Test and Dev
TENTACLES_DEV_DATABASE_PASSWORD=random_string_secret
# Production
TENTACLES_DATABASE_PASSWORD=random_string_secret
```

### GraphQL Schema

This project uses GitHub's [GraphQL API](https://developer.github.com/v4/).
To (re)generate the GraphQL schema, you will need to create a personal access token on GitHub.
Instruction are described in the [Creating a personal access token for the command line](https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line) documentation page.

Add this personnal token named `GITHUB_ACCESS_TOKEN` into the `.env`.

Then request a newer version of the schema using rails:
```
$ rails schema:update
```

## Installing

```
$ yarn install
$ bundle install
```

## Database initialisation

```
$ bundle exec rails db:migrate
```

## Usage
The server is available by default on the port 3000.

```
$ bundle exec rails s -p 3000 -b '0.0.0.0'
```

To access the app in your local browser, go to `http://localhost:3000`.

In development mode, you also need to launch the webpack dev server:
```
$ ./bin/webpack-dev-server
```

The webpack dev server will run on the 3035 port.

## Tests

```
$ bundle exec rspec
```

## Contributing

Thanks for thinking about contributing! Contributors are always welcome! :thumbsup:

There are different ways to contibute:
* Documentation
* Fixing bugs
* Implementing new features
* Adding tests

### Bugs

If you find bugs, first go to the [issues page](https://github.com/jveillet/tentacles-dashboard/issues) and search if a related
issue isn't already listed there. Otherwise, feel free to create new ones 😎.

Create a new issue and include any informations that can help to reproduce the observed behavior:

* Stack trace
* Expected bahevior
* Current behavior
* OS / Browser

Consider adding the [bug](https://github.com/jveillet/tentacles-dashboard/labels) label on your ticket.

### Feature requests

Create a new issue on the [issues page](https://github.com/jveillet/tentacles-dashboard/issues) and add a clear description of what
the new feature should look like.

Consider adding the [feature request](https://github.com/jveillet/tentacles-dashboard/labels) label on your ticket.

### Pull Requests

1. Fork tentacles-dashboard `https://github.com/jveillet/tentacles-dashboard/fork`
2. Clone your fork `git clone https://github.com/$YOUR_USERNAME/tentacles-dashboard && cd tentacles-dashboard`
3. Create new branch `git checkout -b new-branch`
4. Make your changes, and commit `git commit -am "your message"`
5. Push your changes to origin!

## Licence.

Tentacles is a free software: you can redistribute it and/or modify it under the terms of the [GNU GPL v3](LICENCE).

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see
http://www.gnu.org/licenses/.
