# default run ood locally
all:: start_ood
.PHONY: start_ood stop_ood clean

OOD_UID := $(shell id -u)
OOD_GID := $(shell id -g)
DEMO_OOD_IMAGE := hmdc/sid-ood:ood-good25.el8
DEMO_SLURM_IMAGE := hmdc/sid-slurm:v3-slurm-21-08-6-1
PLUGINS_DIR := ./plugins

ENV := env DEMO_SLURM_IMAGE=$(DEMO_SLURM_IMAGE) DEMO_OOD_IMAGE=$(DEMO_OOD_IMAGE) OOD_UID=$(OOD_UID) OOD_GID=$(OOD_GID)

start_ood: stop_ood
	$(ENV) docker compose up --build || :

stop_ood:
	$(ENV) docker compose down -v || :

clean: clean_plugins

clean_plugins:
	rm -rf ./plugins/*/

install_samples: clean_plugins
	cp -r ./dev/samples $(PLUGINS_DIR)

install_favorites: clean_plugins
	cp -r ./dev/favorites $(PLUGINS_DIR)

install_partitions: clean_plugins
	cp -r ./dev/cluster $(PLUGINS_DIR)

install_metrics: clean_plugins
	cp -r ./dev/metrics $(PLUGINS_DIR)
	cp -r ./dev/session_metrics $(PLUGINS_DIR)

install_all: clean_plugins
	cp -r ./dev/* $(PLUGINS_DIR)

