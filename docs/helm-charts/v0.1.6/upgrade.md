Znuny's application image has been designed to play database schema upgrade scripts.  
Each time the Znuny container is started, these scripts are played to ensure that Znuny and its database are on 
the same version and up to date with the target version.

The upgrade mechanism means that you must always be on the minor version just above the one previously installed.  
This means that if you're on version 6.3.x, you can only upgrade to version 6.4.x. A jump to version 6.5.x will not work.

For further details, please refer to the official [documentation](https://doc.znuny.org/znuny_lts/releases/installupdate/update.html)

To upgrade, simply update your Helm deployment.

If the base image for higher-level Helm charts includes a new image version by default, then upgrading the Helm release to a higher chart version will suffice.

```bash
helm upgrade znuny aosc/znuny \
  --version 0.1.6 \
  --reuse-values
```

Otherwise, you'll need to specify the desired image version.

```bash
helm upgrade znuny aosc/znuny \
  --version 0.1.6 \
  --set image.tag=beta-6.5.8 \
  --reuse-values
```



