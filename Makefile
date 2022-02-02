.PHONY: help
help:
	@echo use:
	@echo - make install-argocd-sikademo
	@echo - make argocd-proxy
	@echo - make argocd-password

.PHONY: install-argocd-sikademo
install-argocd-sikademo:
	# (cd _argocd && helm dependency update)
	helm upgrade --install \
		argocd ./_argocd \
		--create-namespace \
		--namespace argocd \
		--wait \
		--values ./_argocd/values-sikademo.yaml

setup-sikademo:
	make install-argocd-sikademo
	kubectl apply -f ./meta/sikademo.yml

argocd-proxy:
	kubectl port-forward -n argocd svc/argocd-server 8443:443

argocd-password:
	@slu argocd initial-password
