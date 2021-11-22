# Helm chart for FuseML installation

This chart runs the fuseml-installer in your Kubernetes cluster.

By default it installs FuseML with its main dependencies (*istio*, *gitea*, *tekton*). By selecting appropriate `extensions` values you can provide additional extensions that should be installed.

Providing specific value to `installerCmd` option, you could pass any command [fuseml-installer](https://github.com/fuseml/fuseml) accepts.

Uninstalling the Helm chart will uninstall FuseML from your cluster too.

# Example usage:

```
helm install fuseml . --namespace fuseml-installer --create-namespace --set systemDomain=example.com  --set extensions.mlflow=true --set extensions.kserve=true
```
