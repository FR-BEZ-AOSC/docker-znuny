## Required configurations

Not all features are active by default, and therefore don't necessarily need to be configured.

Others, on the other hand, do require configuration during deployment.

These features are as follows:

* Database configuration

!!!example
    The most basic deployment should include an image and the environment variables for the database connection.

    If necessary, add configuration elements such as port forwarding, container name, hostname, etc.

    ``` yaml title="docker-compose.yaml" linenums="1" hl_lines="6 11-17"
    ---
    version: "3"

    services:
      app:
        image: ghcr.io/fr-bez-aosc/znuny:beta-6.1.1
        container_name: znuny
        ports:
          - 8080:80
        environment:
          ZNUNY_DATABASE_HOST: db
          ZNUNY_DATABASE_PORT: 5432
          ZNUNY_DATABASE_NAME: znuny
          ZNUNY_DATABASE_USER: znuny
          ZNUNY_DATABASE_PASSWORD: password
    ```

## Optional configurations

Deployment of the containerized application is fully configurable via environment variables.

Each feature therefore has a variable capable of enabling or disabling it, and customizing its configuration.

### Mails

!!!example

    ``` yaml title="docker-compose.yaml" linenums="1" hl_lines="16-20"
    ---
    version: "3"

    services:
      app:
        image: ghcr.io/fr-bez-aosc/znuny:beta-6.1.1
        container_name: znuny
        ports:
        - 8080:80
        environment:
          ZNUNY_DATABASE_HOST: db
          ZNUNY_DATABASE_PORT: 5432
          ZNUNY_DATABASE_NAME: znuny
          ZNUNY_DATABASE_USER: znuny
          ZNUNY_DATABASE_PASSWORD: password
          ZNUNY_MAILING_TYPE: external
          ZNUNY_MAILING_HOST: smpt.domain.tld
          ZNUNY_MAILING_PORT: 25
          ZNUNY_MAILING_USER: znuny
          ZNUNY_MAILING_PASSWORD: password
    ```

!!!info
    To enable mail sending via an external server, the `ZNUNY_MAILING_TYPE` variable must be set to `external`.  
    Otherwise, this variable will be set to `internal` and all other mail configuration variables will be ignored when the application will be configured.

### Logs

!!!example

    ``` yaml title="docker-compose.yaml" linenums="1" hl_lines="16"
    ---
    version: "3"

    services:
      app:
        image: ghcr.io/fr-bez-aosc/znuny:beta-6.1.1
        container_name: znuny
        ports:
        - 8080:80
        environment:
          ZNUNY_DATABASE_HOST: db
          ZNUNY_DATABASE_PORT: 5432
          ZNUNY_DATABASE_NAME: znuny
          ZNUNY_DATABASE_USER: znuny
          ZNUNY_DATABASE_PASSWORD: password
          ZNUNY_LOG_PATH: /var/log/znuny
    ```

!!!info
    By default, the application **Znuny** uses **Rsyslog** to manage its logging.  
    However, with this method, the amount of logging is often low or non-existent.  
    The variable `ZNUNY_LOG_PATH` allows you to dispense with **Rsyslog** for log management. 
    The application will simply write to a single log file, whose path can be customized.

    The **Znuny** application does not write all its activity in its log files.  
    Only actions performed via the application's command line are logged.  
    Daemon and cron logs are output directly in the standard *json* container output.

### Apache

!!!example

    ``` yaml title="docker-compose.yaml" linenums="1" hl_lines="16-20"
    ---
    version: "3"

    services:
      app:
        image: ghcr.io/fr-bez-aosc/znuny:beta-6.1.1
        container_name: znuny
        ports:
        - 8080:80
        environment:
          ZNUNY_DATABASE_HOST: db
          ZNUNY_DATABASE_PORT: 5432
          ZNUNY_DATABASE_NAME: znuny
          ZNUNY_DATABASE_USER: znuny
          ZNUNY_DATABASE_PASSWORD: password
          ZNUNY_APACHE_DOMAIN: znuny.domain.tld
          ZNUNY_APACHE_REWRITE_RULES: |-
            RewriteRule ^/$ https://%{HTTP_HOST}/otrs/customer.pl
            RewriteRule ^/otrs/$ https://%{HTTP_HOST}/otrs/customer.pl
            RewriteRule ^/otrs$ https://%{HTTP_HOST}/otrs/customer.pl
    ```

!!!info
    If required, you can set up a web domain for the virtualhost of the Apache2 server.  
    This can be especially useful if you want to have a record of it in the server logs.  
    If no domain is specified, then the Apache2 server will be configured with a "default" 
    value for the virtualhost's ServerNmae option.

    If required, you can also configure request rewriting rules directly in the virtualhost configuration.

### User

!!!example

    ``` yaml title="docker-compose.yaml" linenums="1" hl_lines="16-17"
    ---
    version: "3"

    services:
      app:
        image: ghcr.io/fr-bez-aosc/znuny:beta-6.1.1
        container_name: znuny
        ports:
        - 8080:80
        environment:
          ZNUNY_DATABASE_HOST: db
          ZNUNY_DATABASE_PORT: 5432
          ZNUNY_DATABASE_NAME: znuny
          ZNUNY_DATABASE_USER: znuny
          ZNUNY_DATABASE_PASSWORD: password
          ZNUNY_USER_ADMIN_NAME: root@localhost
          ZNUNY_USER_ADMIN_PASSWORD: password
    ```

!!!info
    Local administrator user configuration only works if LDAP agent configurations are not specified.  
    If agent LDAP configurations are defined, those of the local administrator user become obsolete.

### Customers

!!!example

    ``` yaml title="docker-compose.yaml" linenums="1" hl_lines="16-37"
    ---
    version: "3"

    services:
      app:
        image: ghcr.io/fr-bez-aosc/znuny:beta-6.1.1
        container_name: znuny
        ports:
        - 8080:80
        environment:
          ZNUNY_DATABASE_HOST: db
          ZNUNY_DATABASE_PORT: 5432
          ZNUNY_DATABASE_NAME: znuny
          ZNUNY_DATABASE_USER: znuny
          ZNUNY_DATABASE_PASSWORD: password
          ZNUNY_CUSTOMER_BACKEND_1: |-
            $$Self->{AuthModule} = 'Kernel::System::Auth::LDAP';
            $$Self->{'AuthModule::LDAP::Host'} = 'ldap.example.com';
            $$Self->{'AuthModule::LDAP::BaseDN'} = 'dc=example,dc=com';
            $$Self->{'AuthModule::LDAP::UID'} = 'uid';
            $$Self->{'AuthModule::LDAP::GroupDN'} = 'cn=znuny-allow,ou=posixGroups,dc=example,dc=com';
            $$Self->{'AuthModule::LDAP::AccessAttr'} = 'memberUid';
            $$Self->{'AuthModule::LDAP::UserAttr'} = 'UID';
            $$Self->{'AuthModule::LDAP::UserAttr'} = 'DN';
          ZNUNY_CUSTOMER_SYNCHRO_1: |-
            $$Self->{'AuthSyncModule'} = 'Kernel::System::Auth::Sync::LDAP';
            $$Self->{'AuthSyncModule::LDAP::Host'} = 'ldap.example.com';
            $$Self->{'AuthSyncModule::LDAP::BaseDN'} = 'dc=example,dc=com';
            $$Self->{'AuthSyncModule::LDAP::UID'} = 'uid';
            $$Self->{'AuthSyncModule::LDAP::SearchUserDN'} = '';
            $$Self->{'AuthSyncModule::LDAP::SearchUserPw'} = '';
            $$Self->{'AuthSyncModule::LDAP::AlwaysFilter'} = '';
            $$Self->{'AuthSyncModule::LDAP::UserSyncMap'} = {
                UserFirstname => 'givenName',
                UserLastname  => 'sn',
                UserEmail     => 'mail',
            };
    ```

!!!info
    This step is almost mandatory to keep user management simple and efficient.

    Environment variables ending in `_X` are repeatable variables and are therefore suffixed with a number.  
    The `X` character must be replaced by a number between 1 and 9, allowing multiple LDAP connection backends to be configured.

    Use of any other number will be ignored.

### Agents

!!!example

    ``` yaml title="docker-compose.yaml" linenums="1" hl_lines="16-47"
    ---
    version: "3"

    services:
      app:
        image: ghcr.io/fr-bez-aosc/znuny:beta-6.1.1
        container_name: znuny
        ports:
        - 8080:80
        environment:
          ZNUNY_DATABASE_HOST: db
          ZNUNY_DATABASE_PORT: 5432
          ZNUNY_DATABASE_NAME: znuny
          ZNUNY_DATABASE_USER: znuny
          ZNUNY_DATABASE_PASSWORD: password
          ZNUNY_AGENT_BACKEND_1: |-
            $$Self->{AuthModule} = 'Kernel::System::Auth::LDAP';
            $$Self->{'AuthModule::LDAP::Host'} = 'ldap.example.com';
            $$Self->{'AuthModule::LDAP::BaseDN'} = 'dc=example,dc=com';
            $$Self->{'AuthModule::LDAP::UID'} = 'uid';
            $$Self->{'AuthModule::LDAP::GroupDN'} = 'cn=znuny-allow,ou=posixGroups,dc=example,dc=com';
            $$Self->{'AuthModule::LDAP::AccessAttr'} = 'memberUid';
            $$Self->{'AuthModule::LDAP::UserAttr'} = 'UID';
            $$Self->{'AuthModule::LDAP::UserAttr'} = 'DN';
          ZNUNY_AGENT_SYNCHRO_1: |-
            $$Self->{'AuthSyncModule'} = 'Kernel::System::Auth::Sync::LDAP';
            $$Self->{'AuthSyncModule::LDAP::Host'} = 'ldap.example.com';
            $$Self->{'AuthSyncModule::LDAP::BaseDN'} = 'dc=example,dc=com';
            $$Self->{'AuthSyncModule::LDAP::UID'} = 'uid';
            $$Self->{'AuthSyncModule::LDAP::SearchUserDN'} = '';
            $$Self->{'AuthSyncModule::LDAP::SearchUserPw'} = '';
            $$Self->{'AuthSyncModule::LDAP::AlwaysFilter'} = '';
            $$Self->{'AuthSyncModule::LDAP::UserSyncMap'} = {
                UserFirstname => 'givenName',
                UserLastname  => 'sn',
                UserEmail     => 'mail',
            };
    ```

!!!info
    This step is almost mandatory to keep operator management simple and efficient.

    LDAP configuration for agents disables local users.

    Environment variables ending in `_X` are repeatable variables and are therefore suffixed with a number.  
    The `X` character must be replaced by a number between 1 and 9, allowing multiple LDAP connection backends to be configured.

    Use of any other number will be ignored.
