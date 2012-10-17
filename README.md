rails-wedding
=============

This project contains a rails app I've built to manage RSVP submissions
for our wedding. It's designed to provide a lot of automation, and to
perform well.


How to Use
==========

If you decide you like the site and would like to use it for your own wedding,
you will need to customize a few things:


Configuration
-------------

Most of the configuration is stored into environment variables. I'm using the
[`dotenv`][1] gem to allow you to provide different values in development than
in production.


### In Development

To configure the development environment, create a file named `.env` at the root
directory of the application, and enter your values directly in that file.

The full listing of available environment variables is listed below.


### In Production

The `.env` file will be ignored in production. Instead, you should set those
variables in the shell for the user that will be running the app in production.

On a Linux or OSX system, use the following syntax in the `.profile` file
in the production user's home directory:

```bash
export VAR=value
```

### Note for Capistrano Deployments

I use Capistrano to perform remote deployments to my production server.
Because Capistrano calls the `assets:precompile` task, most of the environment
variables used throughout the app must be available to the capistrano process.

To make those variables available, you need to enter them in the following
format in a file called `.environment` in the deployment user's `$HOME/.ssh` 
directory:

```sh
VAR=value
```


### Environment Variables Listing


```sh
# AssetSync configuration
AWS_ACCESS_KEY_ID=AWS_KEY
AWS_SECRET_ACCESS_KEY=AWS_PASSWORD
FOG_DIRECTORY=assets.yourdomain.com
FOG_PROVIDER=AWS
ASSET_SYNC_GZIP_COMPRESSION=true
ASSET_SYNC_MANIFEST=false

# Database Configuration
DATABASE_NAME=wedding_production
DATABASE_USER=POSTGRES_USER
DATABASE_PASSWORD=POSTGRES_PASSWORD

# Sendgrid Credentials for Emails
SENDGRID_USERNAME=username
SENDGRID_PASSWORD=password
SENDGRID_DOMAIN=yourdomain.com
SENDGRID_SERVER=smtp.sendgrid.net
SENDGRID_PORT=587

# Airbrake Exception Notifications
AIRBRAKE_API_KEY=airbrake_key

# ActiveAdmin Configuration
ACTIVEADMIN_SITE_TITLE=Our Wedding

# Email Source for User Management System
DEVISE_EMAILS_FROM=no-reply@yourdomain.com

# Site Configuration
SITE_NAME=yourdomain.com
SITE_TITLE=X and Y, Month Day, Year
DEFAULT_EMAIL_FOOTER=
DEFAULT_EMAIL_HEADER=

# Google Analytics ID for tracking
GOOGLE_ANALYTICS_ID=UA-XXX-X
```


Features and Design
===================

I've implemented the following features, which will hopefully come in handy for 
somebody else:


RSVP Management for guests
--------------------------

The submission process allows the visitor to RSVP for an arbitrary amount of
guests.

I've used the [`cocoon`][2] gem to dynamically add/remove guest forms to the
RSVP entry page.

I added validation rules for the guest form fields, and typeahead completion for
the dietary restriction fields.

[2]: https://github.com/nathanvda/cocoon "Cocoon on Github"


Management Interface
--------------------

I've set up [`ActiveAdmin`][3] to manage RSVP submission, guests and application
users.

I haven't spent too much time configuring the ActiveAdmin dashboards, because
out of the box, it provides enough functionality to do everything I needed it to.

[3]: http://activeadmin.info/ "ActiveAdmin"


Static Content
--------------

The static content pages (located at `app/views/static`) use the same layout
as the rest of the app, but are set up to be cached the first time they are
generated. The cached pages will be saved in the `public` directory, which
means they will be served directly from the web server without going through
rails.

Since `public` is cleared on capistrano deployments, they will also get swept
automatically during each new deployment.


Error Notification
------------------

I've added support for the [`Airbrake`][4] gem which will
notify their web service when an exception is encountered anywhere in the app.

The service offers free plans, and can email you when an exception is sent.

[4]: http://airbrake.io "AirBrake"


Twitter Bootstrap styling
-------------------------

I've used the [`bootstrap-sass-rails`][5] gem to cherry-pick selected components
from Twitter's [`Bootstrap`][6] UI framework.

I've made extensive use of most of the CSS components provided by the framework,
and a fair amount of the JS plugins.

[5]: https://github.com/yabawock/bootstrap-sass-rails "bootstrap-sass-rails  on Github"
[6]: http://twitter.github.com/bootstrap/ "Twitter Bootstrap"


Clean, Semantic Markup
----------------------

The markup used in the application layout and the static content pages is
highly readable free of clutter such as inline styling.

The markup is generated from haml templates, and the CSS stylesheets are built
using the SASS indented syntax.


Process Automation
------------------

I use the [`foreman`][7] gem to manage the processes the app depends on. I 
provided the `Procfile` and Procfile.production` files to define what those 
processes are.

In development mode, simply type `foreman start` and the app will instantiate
a development web server, a background worker to process emails, and the
[`mailcatcher`][8] app to catch mail sent by the background worker and display 
it in your browser.

In production, the deployment system will automatically use foreman's
`export` feature to generate [`upstart`][9] scripts, which is used by most 
modern Linux distros to manage processes. That script will ensure the app is 
started at boot-time, along with all its dependencies.

[7]: https://github.com/ddollar/foreman "Foreman on Github"
[8]: https://github.com/sj26/mailcatcher "Mailcatcher on Github"
[9]: http://upstart.ubuntu.com/ "Upstart Website"


Deployment Automation
---------------------

The app ships with a capistrano config for deploying to remote hosts.
I've configured capistrano to do a few cool things too:

* Precompile assets, and push them to an [Amazon S3][10] bucket
* Update [RVM][11], and update the [MRI][12] interpreter if needed
* Creates the app gemset in RVM if needed
* Create a logrotate config on first deployment
* Run `bundle install` on the target servers
* Export the foreman config into a set of `upstart` scripts
* Use `upstart` to restart the web worker and background worker processes

[10]: http://aws.amazon.com/s3/ "Amazon S3 Storage"
[11]: https://rvm.io/ "Ruby Version Manager"
[12]: http://www.ruby-lang.org/en/ "Matz's Ruby Interpreter"


Background Emails
-----------------

I'm using [`sidekiq`][13] to process emails in the background instead of 
processing them during the request workflow.

[13]: http://mperham.github.com/sidekiq/ "SideKiq"


Zero-Downtime Deployments
-------------------------

I'm using the [`unicorn`][14] web server, and I've provided a config file in
`config/unicorn/production.rb` that preloads the app and manages database
connections before/after fork to provide rolling restarts.

[14]: http://unicorn.bogomips.org/ "Unicorn Web Server"


Email Styling
-------------

I use the [`premailer`][15] gem, which allows you to use a stylesheet for your
emails, and will then extract the used style definitions and alter the email's
markup to include inline styling for the generated emails.

This is unfortunately necessary, since consistent email styling support is
hard to accomplish across the board with email clients.

[15]: https://github.com/alexdunae/premailer "Premailer on Github"


How to Contribute
=================

* [Fork the project][16]
* Create a new branch
* Make your changes
* Issue a pull request

[16]: https://help.github.com/articles/fork-a-repo "Github Help: Fork a Project"


TODO
====

* Provide full test suite
* Use templates for capistrano, nginx and unicorn config recipes
* Provide chef recipes for server provisioning
* Consult the project's [`issue list`][17] for complete list.

[18]: https://github.com/loginx/rails-wedding/issues?state=open

License
=======

This work is licensed under a 
[Creative Commons Attribution-ShareAlike 3.0 Unported License][19].

[19]: http://creativecommons.org/licenses/by-sa/3.0/ "CC ShareAlike License"
