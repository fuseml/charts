# Helm chart for FuseML installation

This chart runs the fuseml-installer in your Kubernetes cluster.

By default it installs [FuseML](fuseml.github.io) with its main dependencies (*istio*, *gitea*, *tekton*). By filling `extensions` value you can provide additional extensions that should be installed.

Providing specific value to `installerCmd` option, you could pass any command [fuseml-installer](https://github.com/fuseml/fuseml) accepts.

Uninstalling the Helm chart will uninstall FuseML from your cluster too.
