
.PHONY: cluster
cluster:
	(cd cluster && make all)

.PHONY: helm
helm: cluster
	(cd helm && make)

