## Prerequisites

[K3D](https://k3d.io/) is the tool choose to have a local kubernetes development cluster.  

Install K3D with the next command :

``` bash
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
```

!!! tips
    Refer to the documentation for other installation methods.  
    <div align="center">
    [Go to K3D documentation](https://k3d.io/v5.5.1/#install-current-latest-release){ .md-button }
    </div>

## Create a development cluster

Use the following kind of configuration file of k3d to deploy a cluster.

``` yaml title="k3d/cluster.yaml" linenums="1"
--8<-- "k3d/cluster.yaml"
```

The default domain used by the development cluster is **znuny-dev-cluster**.  
Ensure to add it at the local name resolution in the file ***/etc/hosts*** :

``` ini title="/etc/hosts" linenums="1"
127.0.0.1 znuny.domain.tld
```

Create the cluster :

``` bash
k3d cluster create -c ./k3d/cluster.yaml
```

Delete cluster :

``` bash
k3d cluster delete znuny-dev-cluster
```

## Templating

Create templates to check compliance of deployed resources from the project root :

```bash
helm template znuny ./helm
```

