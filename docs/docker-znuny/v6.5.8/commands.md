Zcli is a simple command line interface built to manage the image of Znuny.

## Usage

Zcli can be used as following :

* `zcli COMMAND`
* `zcli [COMMAND] --help | -h`
* `zcli --version | -v`

## Global commands

The are many main commands which can be run :

* `config`: *Manage the configuration of znuny*
    * `Description`: *This command is used to manage and adjust the various configuration settings of the Znuny application.*
    * `Necessity`: *Configuration management is essential to ensure that the application is set up correctly according to the specific needs and infrastructure of the organization using it. Proper configuration affects everything from functionality and user access to security and performance.*
    * `Function`: *It provides a set of tools or sub-commands that allow administrators to customize and manage different aspects of the application's setup and operation.*
    * `apache`: 
        *This sub-command configures virtual hosts for the Apache web server. A virtual host allows the server to manage multiple domains on a single server.*
        *It's necessary for setting up Apache to host multiple websites or web applications on the same physical server, each with its own domain configuration.*
        *It configures the necessary settings in Apache to recognize and respond differently based on the requested domain or sub-domain.*
    * `crons`:
        * `--` *This command creates all necessary cron jobs for the Znuny application.*
        * `--` *Cron jobs are used to automate recurring operations without manual intervention, such as database backups, regular updates, and session cleanups.*
        * `--` *It schedules and configures automated tasks that need to run at regular intervals on the server where Znuny is installed.*
    * `database`:
        * `Description`: *This sub-command sets up and prepares the initial database for the Znuny application.*
        * `Necessity`: *Essential for setting up the application's data storage before use, ensuring all necessary tables and data structures are properly created.*
        * `Function`: *It executes SQL scripts or migrations necessary to create and configure the database as required by the application.*
    * `locales`:
        * `--` *This command configures the application's local settings, such as language and regional formats.*
        * `--` *Important for internationalizing the application, allowing it to adapt the interface and functionalities to the linguistic and regional preferences of users.*
        * `--` *It adjusts settings for language and formatting of dates, times, and currencies to meet local standards of the user.*
    * `modules`:
        * `--` *Installs additional modules or extensions into the Znuny application.*
        * `--` *Allows for the extension or customization of Znuny functionalities by adding specific features not included in the base installation.*
        * `--` *It downloads and installs selected modules, integrating new capabilities or integrations into the base system.*
    * `override`:
        * `--` *This command allows for modifying or replacing existing configurations with custom settings.*
        * `--` *Useful for customizing or adjusting the application's behavior without altering the original configuration files, thus facilitating future application updates without losing customizations.*
        * `--` *It replaces or modifies configuration settings with values specified by the user, which can be stored in a specific file or directory.*
    * `timezone`:
        * `--` *Sets the timezone for the Znuny application.*
        * `--` *Crucial for ensuring that all time-based operations, like ticket timestamps and task scheduling, are correct and consistent with the geographical location of the business or user.*
        * `--` *It adjusts the application's internal clock to match the desired timezone, affecting how dates and times are managed throughout the application.
*
    * `znuny`:
        * `--` *This sub-command generates the main configuration file for the Znuny application.*
        * `--` *Fundamental for initializing the application with all essential settings that define how the application should operate and interact with its environment.*
        * `--` *It creates and stores basic and advanced settings in a central configuration file, which will be read by the application at startup.*
* `check`: *Check some features or resources*
    * `Description`: *This command is designed to verify and validate certain features or resources that are crucial for the proper functioning of the Znuny application.*
    * `Necessity`: *Regular checks ensure that all necessary components and configurations of the application are functioning correctly and are set up as expected. This helps in maintaining the reliability and stability of the application.*
    * `Function`: *It provides a framework for running specific verification tasks on components like Perl modules and database configurations to ensure they meet the required specifications for optimal performance.*
    * `modules`: *Check Perl modules*
        * `Description`: *This sub-command is used to check the Perl modules installed on the system which are required by the Znuny application.*
        * `Necessity`: *Perl modules are often essential for various operations within Znuny, such as scripting and automation. Ensuring that the correct modules are installed and functional is key to preventing runtime errors and application malfunctions.*
        * `Function`: *It scans the system to confirm the presence and correct versions of the required Perl modules, reporting any missing or outdated modules which might impede the application s functionality.*
    * `config`: *Check the built configuration in database*
        * `Description`: *This sub-command assesses the configurations stored within the application s database to ensure they are correctly implemented and complete.*
        * `Necessity`: *Proper configuration in the database is critical for the application to run smoothly. Incorrect settings can lead to operational failures or security vulnerabilities.*
        * `Function`: * It verifies that the configuration settings stored in the database match the expected values or defaults necessary for the system’s operations. This check helps identify and rectify discrepancies that could affect performance or security.*
* `download`: *Download the znuny archive*
    * `Description`: *This command facilitates the downloading of the Znuny software archive.*
    * `Necessity`: *To install or update the Znuny application, you need to download the latest or a specific version of the software. This command ensures that you can retrieve the exact version required directly from a command line interface.*
    * `Function`: *It connects to the server where Znuny archives are stored and downloads the specified version of the Znuny software.*
    * `Flags`: 
        * `-r (release)`: *This flag specifies the release version of Znuny that you want to download. It is required because you must define which version of the software is needed, ensuring that the correct and intended version is obtained.*
        * `-s (signature)`: *This flag is used to specify the checksum signature of the Znuny release. It is required to verify the integrity of the downloaded file, ensuring that it has not been altered or corrupted during the download process. The signature helps prevent the installation of tampered or maliciously modified software.*
* `init`: *Initialize the container*
    * `Description`: *This command sets up the initial environment for the Znuny application container.*
    * `Necessity`: *Initialization is crucial for preparing the container with all necessary configurations, software dependencies, and environmental settings to ensure that the Znuny application runs smoothly and is ready for further configuration or use.*
    * `Function`: *It likely performs tasks such as setting up the base directory structure, installing basic packages, configuring network settings, and other prerequisites for the Znuny application within the container.*
* `job`: *Commands for kubernetes job*
    * `Description`: *This command group is designed to handle tasks related to Kubernetes jobs, particularly for operations like database migrations.*
    * `Necessity`: *Managing database migrations through Kubernetes jobs allows for scalable and manageable operations, especially useful in cloud environments where Znuny might be deployed.*
    * `Function`: *It provides a set of commands to manage and execute database migrations within the Kubernetes ecosystem, ensuring data consistency and minimizing downtime.*
    * `migration`: *Migrate an existing database from a PostgreSQL server to the application database*
        * `Description`: *This command orchestrates the migration of databases between PostgreSQL servers and the application-specific database.*
        * `Necessity`: *Migration is essential when moving to a new version of the database, changing hosting environments, or consolidating databases for better management.*
        * `Function`: *It facilitates the transfer of data, ensuring that all data from the original database is correctly and securely migrated to the new database environment.*
        * `database`: *Migrate an existing database from a working server*
            * `Description`: *Migrates an existing database from one server to another.*
            * `Necessity`: *This is crucial for situations where database servers are upgraded, or data needs to be synchronized between different environments.*
            * `Function`: *It connects to both the source and destination databases and transfers data between them.*
            * `Flags`:
                * `-h (host)`: *Specifies the hostname or IP address of the database server from which data is being migrated.*
                * `-p (port)`: *Specifies the port number on which the database server is listening.*
                * `-n (name)`: *Specifies the name of the database to be migrated.*
                * `-u (user)`: *Specifies the username required to access the database.*
                * `-w (password)`: *Specifies the password required to access the database.*
                * `-f (force)`: *Allows the migration to proceed without manual confirmation or to override certain checks during the migration process.*
        * `local`: *Migrate an existing database from a dump file on the local filesystem*
            * `Description`: *Migrates a database using a dump file stored locally.*
            * `Necessity`: *Useful for restoring backups or moving data from a local development environment to a production environment.*
            * `Function`: *It reads a database dump file from the local file system and imports it into the specified database.*
            * `Args`:
                * `path`: *The file path of the dump file that contains the database data.*
            * `Flags`:
                * `f (force)`: *Similar to the database sub-command, it forces the import process to proceed, potentially bypassing usual checks or confirmations.*
* `run`: *Run Znuny*
    * `Description`: *This command is used to start various components of the Znuny application.*
    * `Necessity`: *It allows for manual control over starting different parts of the application, which is essential for both development and production environments to ensure components are actively running when needed.*
    * `Function`: *Provides an interface to launch different processes related to the Znuny system.*
    * `apache2`: *Run Apache2 web server*
        * `Description`: *Starts the Apache2 web server which hosts the web interface of Znuny.*
        * `Necessity`: *Apache2 serves the web pages for Znuny, making it accessible via a web browser for user interaction.*
        * `Function`: *It initializes the Apache2 service, ensuring that the web server is active to handle incoming HTTP requests.*
    * `cron`: *Run the crons of Znuny*
        * `Description`: *Activates the scheduled cron jobs for Znuny.*
        * `Necessity`: *Cron jobs are used to perform periodic tasks automatically, such as sending out email notifications, ticket cleanup, and other background tasks that help maintain the application’s operations.*
        * `Function`: *It ensures that all scheduled tasks are running as configured to maintain routine operations without manual intervention.*
    * `daemon`: *Run the daemon of Znuny*
        * `Description`: *Starts the background daemon process for Znuny.*
        * `Necessity`: *The daemon is essential for handling background processes that must run continuously, such as queue management and asynchronous data processing.*
        * `Function`: *It starts the daemon so it can continuously run and process tasks that are critical for the smooth functioning of the application.*
    * `znuny`: *Run Znuny*
        * `Description`: *Launches the main Znuny application.*
        * `Necessity`: *To make the Znuny ticketing system operational after initial setup or a shutdown.*
        * `Function`: *It starts the core services of Znuny, making the system operational for users to create, manage, and resolve tickets.*
* `upgrade`: *Ensure Znuny is up to date*
    * `Description`: *This command updates the Znuny application to the latest version.*
    * `Necessity`: *Regular updates ensure that the system benefits from the latest features, security patches, and performance improvements.*
    * `Function`: *It checks for available updates and applies them to upgrade the system to the latest release, ensuring the application remains current and secure.*
* `user`: *Manage users*
    * `Description`: *Provides tools to manage user accounts within the Znuny application.*
    * `Necessity`: *Effective user management is essential for maintaining the security and operational integrity of the system, allowing for appropriate access controls and user permissions.*
    * `Function`: *It includes commands for creating users and setting their permissions, which is critical for controlling access to various parts of the application.*
    * `admin`: *Create the admin user*
        * `Description`: *Sets up an administrative user account.*
        * `Necessity`: *The admin user has elevated privileges necessary for managing the application, including configuring settings and managing other user accounts.*
        * `Function`: *It creates an administrator account with the necessary permissions to manage Znuny comprehensively.*
    * `permissions`: *Set the user permissions*
        * `Description`: *Configures the access levels and permissions for users.*
        * `Necessity`: *To ensure that users have the appropriate permissions to perform their roles without compromising the security or functionality of the system.*
        * `Function`: *It adjusts the permissions settings for users, dictating what actions they can perform within the Znuny system.*
    * `system`: *Create the system user*
        * `Description`: *Establishes a system user account, typically used for automated processes or tasks that require system-level access.*
        * `Necessity`: *System users are often necessary for scripts, APIs, or background processes that interact with the Znuny system at a fundamental level.*
        * `Function`: *It creates a user account that is specifically tailored for system operations and automated tasks, often without direct human interaction but with necessary system privileges.*

## Global options

* `--help` ou `-h`: *Show this help*
* `--version` ou `-v`: *Show version number*

