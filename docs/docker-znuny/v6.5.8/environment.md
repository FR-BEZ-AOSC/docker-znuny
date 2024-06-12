Environment Variables:

* `ZNUNY_TIMEZONE`: The service timezone
    * `Description`: *Defines the timezone for the Znuny application.*
    * `Necessity`: *Ensuring that all time-related operations within the application use the correct local time.*
    * `Function`: *It sets the timezone for all operations within the Znuny system, affecting how times and dates are displayed and processed*
* `ZNUNY_LOG_PATH`: Enable or not the secure mode
    * `Description`: *Specifies the file path where the application logs are stored.*
    * `Necessity`: *Essential for troubleshooting and monitoring the application's behavior through log analysis.*
    * `Function`: *Directs the application to store its operational logs at the specified path, aiding in diagnostics and system monitoring.*
* `ZNUNY_SECURE_MODE`: The log file path
    * `Description`: *Toggles the secure mode of the application.*
    * `Necessity`: *To enhance the security measures of the application when handling sensitive data.*
    * `Function`: *Activates additional security features such as enhanced data validation, encryption, and secure communication protocols.*
* `ZNUNY_DATABASE_HOST`: The database host
    * `Description`: *Defines the hostname or IP address of the database server used by Znuny.*
    * `Necessity`: *To establish a connection to the correct database server where the application data is stored.*
    * `Function`: *It configures the application to connect to the database server at the specified host for all data operations.*
* `ZNUNY_DATABASE_PORT`: The database port
    * `Description`: *Specifies the port number on which the database server is listening.*
    * `Necessity`: *To connect to the database server on the correct port, especially when default database ports are not used.*
    * `Function`: *Ensures that the application attempts to connect to the database server using the specified port.*
* `ZNUNY_DATABASE_NAME`: The database name
    * `Description`: *The name of the database that Znuny should use.*
    * `Necessity`: *To direct the application to the correct database schema for operations.*
    * `Function`: *Configures the application to access the specified database for storing and retrieving data.*
* `ZNUNY_DATABASE_USER`: The database user
    * `Description`: *The username for database access.*
    * `Necessity`: *To authenticate the application's access to the database.*
    * `Function`: *It provides the necessary credentials for the application to log into the database.*
* `ZNUNY_DATABASE_PASSWORD`: The database password
    * `Description`: *The password associated with the database user.*
    * `Necessity`: *To secure and authenticate the database connection.*
    * `Function`: *Used in conjunction with the database user to authenticate the application's database access securely.*
* `ZNUNY_USER_ADMIN_NAME`: The admin user name
    * `Description`: *Specifies the username for the admin user of the Znuny application.*
    * `Necessity`: *To set or reset the administrative credentials needed for application management.*
    * `Function`: *Defines the username for the administrator account, used for logging into the admin panel.*
* `ZNUNY_USER_ADMIN_PASSWORD`: The admin user password
    * `Description`: *The password for the admin user of Znuny.*
    * `Necessity`: *To secure the administrator's access to the application.*
    * `Function`: *Sets the password for the administrative user, used in conjunction with the admin username to access admin-level functions.*
* `ZNUNY_MAILING_TYPE`: The mailing type
    * `Description`: *Specifies the type of mailing system used by the application (e.g., SMTP, sendmail).*
    * `Necessity`: *To configure the mailing system according to the setup and requirements of the organization.*
    * `Function`: *Determines how emails are sent from the application, affecting configurations for email communications.*
* `ZNUNY_MAILING_HOST`: The mailing host
    * `Description`: *The hostname or IP address of the mail server used by Znuny.*
    * `Necessity`: *To specify where to send outgoing mail.*
    * `Function`: *Configures the application to use the specified mail server for sending emails.*
* `ZNUNY_MAILING_PORT`: The mailing port
    * `Description`: *The port number used by the mailing server.*
    * `Necessity`: *To ensure that the application can connect to the mail server on the correct port.*
    * `Function`: *Specifies the port to use when connecting to the mail server, which is critical if non-standard ports are used.*
* `ZNUNY_MAILING_USER`: The mailing user
    * `Description`: *The username used to authenticate with the mail server.*
    * `Necessity`: *To authenticate the application's ability to send emails through the specified mail server.*
    * `Function`: *Provides credentials that allow the application to log into and send email through the mail server.*
* `ZNUNY_MAILING_PASSWORD`: The mailing password
    * `Description`: *The password for the mailing server user.*
    * `Necessity`: *To securely authenticate the mailing operations.*
    * `Function`: *Works with the mailing user to authenticate and secure email sending processes.*
* `ZNUNY_APACHE_DOMAIN`: The application domain
    * `Description`: *Specifies the domain for which Apache is configured in the context of Znuny.*
    * `Necessity`: *To ensure that the Apache server correctly handles requests for the specific domain.*
    * `Function`: *Sets up Apache to respond to requests for the specified domain, crucial for hosting setups.*
* `ZNUNY_APACHE_REWRITE_RULES`: A custom rewrite rule
    * `Description`: *Defines custom Apache rewrite rules for the application.*
    * `Necessity`: *To customize how URLs are processed and rewritten by the server, enhancing SEO or user experience.*
    * `Function`: *Implements specific rules for redirecting or rewriting URL requests within the Apache configuration.*
* `ZNUNY_AUTHENTICATIONS_BACKENDS`: Users authentication settings
    * `Description`: *Lists the authentication backends used for user verification.*
    * `Necessity`: *To configure multiple authentication mechanisms for enhanced security or to support various user databases.*
    * `Function`: *Specifies the systems (like LDAP, OAuth) that Znuny will use to authenticate users logging into the application.*
* `ZNUNY_ADDONS`: List of application extensions to add
    * `Description`: *Enumerates additional modules or extensions to be added to the Znuny application.*
    * `Necessity`: *To expand the functionality of the application with specific features not included in the base installation.*
    * `Function`: *Instructs the application to include specified add-ons or extensions during setup or runtime.*
* `ZNUNY_CONFIGURATIONS_OVERRIDES_DIRECTORY`: Directory path of custom configurations overrides
    * `Description`: *Specifies the directory path where custom configuration overrides are stored.*
    * `Necessity`: *To allow for customization of the application without altering the core configuration files, facilitating easier updates and maintenance.*
    * `Function`: *Directs the application to load custom configuration files from the specified directory, overriding default settings as necessary.*
* `ZNUNY_HEALTHSTATUS_APIKEY`: Api key to use with the plugin healthstatus
    * `Description`: *Provides an API key for accessing the health status plugin of Znuny.*
    * `Necessity`: *To authenticate and enable access to the health status monitoring features of the application.*
    * `Function`: *Uses the API key to access and interact with health monitoring tools or plugins, ensuring secure and authorized use of these features.*

