algocd-up:
	kubectl port-forward svc/argocd-server -n argocd 8090:443