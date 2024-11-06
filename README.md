Ranked.
=======

Ranked is a website where users can create a list of things, such as baseball
teams or colors or baby names, and they and other users can then rank those
items. Ranking is done by presenting the user with each possible pair of items,
and having the user choose the better of the two. The results of each of these
matches is then given to an implementation of the Elo algorithm to determine the
score and therefore final ranking.

This is the Ruby on Rails back-end for the Ranked stack.

Architecture
------------

The website is architected to use the database and backend as little as
possible. The {Stack} record contains multiple {Card} records, one for each item
to be ranked. No other data is stored in the database. As users complete
matches, the result of each match is encoded in the URL. When the user wishes to
see their ranking, the encoded results array is included in the final ranking
URL. This allows users to share their results with others without the
application needing to save their results to a database.

The backend is a Ruby on Rails application and PostgreSQL database deployed
using Fly.io. There is no authentication, nor any need for user accounts. See
{ApplicationController} for more information about controller API responses.

Development
-----------

The back-end requires Ruby 3.3 and PostgreSQL. You can check out the repository
and run `bundle` to install all dependencies, then `rails setup` to set up
the development and test databases.

Run `rails server -b 127.0.0.1` to run the development server. You must bind to
127.0.0.1 instead of the default localhost. The production files are deployed
automatically by Fly.io once the Travis CI build passes.

In order to develop with the full stack, you will need to check out and run the
front-end too. An example Procfile that does this:

```
backend: cd Backend && rvm 3.3.6@ranked exec rails server -b 127.0.0.1
frontend: cd Frontend && yarn dev
```

Documentation
-------------

Comprehensive documentation of all controllers and models is available by
running `rake yard` and opening the generated HTML website in `doc`.

Tests
-----

Models have comprehensive unit tests, and controllers comprehensive integration
tests, using RSpec and FactoryBot. Specs can be run using `rspec spec`.
