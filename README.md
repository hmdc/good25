# IQSS Research Computing - GOOD25
Demo project with a local environment with OODv4.0.2 and a Slurm cluster.

This project will be use to share some of the plugins that the IQSS Research Computing team at Harvard has developed.

## Requirements
- Docker (Tested with Docker version 24.0.2)
- Make (Tested with GNU Make 3.81)
- Tested with a Mac with Intel i7 and M1 chipsets

## Demo Environment
To deploy the OOD demo environment locally execute:
```
make
```

The OOD Demo environment is based on OOD Version 4.0.2 and is deployed under: [https://localhost:33000/pun/sys/dashboard](https://localhost:33000/pun/sys/dashboard)

Both dashboards use the local credentials `ood` => `ood`

### Dynamic Configuration
The configuration for the OOD Demo application can be found under [./config/demo/ondemand.d](./config/demo/ondemand.d)

The Demo has been customized to dynamically load configuration changes to facilitate development and trying new features. No application restart required.

### Announcements
The demo OOD application has been configured to use the local folder [./config/demo/public/announcements](./config/demo/public/announcements) to load announcements.

For more information on announcements, see the [OOD documentation](https://osc.github.io/ood-documentation/latest/customizations.html#announcements)

## Widgets Partials

## Plugins
