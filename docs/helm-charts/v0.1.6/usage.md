## Configuration overload

By default, the root directory of the Znuny application is “/opt/otrs/”.  
All application configurations are located in the “/opt/otrs/Kernel/” directory.  
If you need to overload a configuration file, a simple method is available.  
Simply copy the resources with the appropriate tree structure into the “/opt/otrs/Custom” folder.  
Based on this principle, the file “/opt/otrs/Kernel/Langage/en.pm” will be overwritten by the file “/opt/otrs/Custom/Kernel/Langage/en.pm”.

To overcome the limitations of permissions on Kubernetes mounts, an automatic copy system has been set up.