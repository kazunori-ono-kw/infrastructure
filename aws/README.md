# ssh login
```
$ ssh -i kubeec2 ubuntu@[IP Address]

```



# install microkube

```

$ sudo snap install microk8s --classic --channel=1.18/stable

$ sudo microk8s status --wait-ready

$ sudo microk8s enable dashboard dns registry istio

$ sudo microk8s kubectl get all --all-namespaces

$ sudo microk8s kubectl get all --all-namespaces

$ sudo microk8s dashboard-proxy

```