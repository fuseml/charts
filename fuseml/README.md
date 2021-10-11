This charts runs the fuseml-installer in your cluster.

By default it installs [FuseML](fuseml.github.io), but you can provide alternative commands to do anything what [fuseml-installer](https://github.com/fuseml/fuseml) accepts.

```
helm install fuseml . --namespace fuseml-installer --create-namespace --set systemDomain=example.com  --set extensions='{mlflow,cert-manager}'
```
