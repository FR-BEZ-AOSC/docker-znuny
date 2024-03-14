Zcli is e simple command line interface built to manage the image of Znuny.

## Usage

Zcli can be used as following :

* `zcli COMMAND`
* `zcli [COMMAND] --help | -h`
* `zcli --version | -v`

## Global commands

The are many main commands which can be run :

* `config`: *Manage the configuration of znuny*
    * `apache`: *Create virtualhosts*
    * `crons`: *Create all crons*
    * `customers`: *Create customers authentications*
    * `database`: *Initialize the database*
    * `operators`: *Create operators authentications*
    * `znuny`: *Create the main configuration file of Znuny*
* `check`: *Check some features or resources*
    * `modules`: *Check Perl modules*
    * `config`: *Check the built configuration in database*
* `download`: *Download the znuny archive*
* `init`: *Initialize the container*
* `run`: *Run Znuny*
    * `cron`: *Run the crons of Znuny*
    * `daemon`: *Run the daemon of Znuny*
    * `znuny`: *Run Znuny*
* `user`: *Manage users*
    * `admin`: *Create the admin user*
    * `permissions`: *Set the user permissions*
    * `system`: *Create the system user*
* `job`: *Commands for kubernetes job*
    * `upgrade`: *Upgrade database schemas*
    * `migration`: *Migrate an existing database from a PostgreSQL server to the application database*
* `shell`: *Commands for TTY shell*
    * `upgrade`: *Upgrade database schemas*

## Global options

* `--help` ou `-h`: *Show this help*
* `--version` ou `-v`: *Show version number*

## Environment variables

Zcli is designed to be as dynamic configurable as posible.  
All features supported can be set with environment variables.  

Environement variables availables :

* `ZNUNY_LOG_PATH`: *The log file path*
* `ZNUNY_DATABASE_HOST`: *The database host*
* `ZNUNY_DATABASE_NAME`: *The database name*
* `ZNUNY_DATABASE_USER`: *The database user*
* `ZNUNY_DATABASE_PASSWORD`: *The database password*
* `ZNUNY_USER_ADMIN_NAME`: *The admin user name*
* `ZNUNY_USER_ADMIN_PASSWORD`: *The admin user password*
* `ZNUNY_MAILING_TYPE`: *The mailing type*
* `ZNUNY_MAILING_HOST`: *The mailing host*
* `ZNUNY_MAILING_PORT`: *The mailing port*
* `ZNUNY_MAILING_USER`: *The mailing user*
* `ZNUNY_MAILING_PASSWORD`: *The mailing password*
* `ZNUNY_APACHE_DOMAIN`: *The application domain*
* `ZNUNY_APACHE_REWRITE_RULES`: *A custom rewrite rule*
* `ZNUNY_CUSTOMER_BACKEND_X`: *Customers authentication backend*
* `ZNUNY_CUSTOMER_SYNCHRO_X`: *Customers authentication synchronization*
* `ZNUNY_AGENTS_BACKEND_X`: *Agents authentication backend*
* `ZNUNY_AGENTS_SYNCHRO_X`: *Agents authentication synchronization*

!!!info
    Environment variables ending in `_X` are repeatable variables and are therefore suffixed with a number.  
    The `X` character must be replaced by a number between 1 and 9, allowing multiple LDAP connection backends to be configured.

    Use of any other number will be ignored.


