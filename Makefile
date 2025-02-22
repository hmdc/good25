# default run ood locally
all:: start_ood
.PHONY: start_ood stop_ood clean

OOD_UID := $(shell id -u)
OOD_GID := $(shell id -g)
SID_OOD_IMAGE := hmdc/sid-ood:ood-4.0.2.el8
SID_SLURM_IMAGE := hmdc/sid-slurm:v3-slurm-21-08-6-1

ENV := env SID_SLURM_IMAGE=$(SID_SLURM_IMAGE) SID_OOD_IMAGE=$(SID_OOD_IMAGE) OOD_UID=$(OOD_UID) OOD_GID=$(OOD_GID)

start_ood: stop_ood
	$(ENV) docker compose up --build || :

stop_ood:
	$(ENV) docker compose down -v || :

clean:
	rm -rf ./ondemand/apps/dashboard/data
	rm -rf ./ondemand/apps/dashboard/node_modules
	rm -rf ./ondemand/apps/dashboard/vendor/bundle
	rm -rf ./ondemand/apps/dashboard/app_overrides
	rm -rf ./ondemand/apps/dashboard/plugins
	rm -rf ./ondemand/apps/dashboard/.env*