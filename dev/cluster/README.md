## IQSS Partition Widget For OnDemand
Open OnDemand partition widget displaying information about all the partitions in the Slurm cluster with metrics about partition state, nodes, CPUs, and memory.


### Implementation Summary
The implementation consists of three components
- OOD Slurm adapter and NodeInfo class extensions
- ./initializers
- Partition service and utility classes
- ./lib/slurm_cluster
- Partition widget
- ./views/widgets/cluster

### Deployment
Using the customization feature from OnDemand, with the default location under: `/etc/ood/config/apps/dashboard`
- copy `./initializers/*` into `/etc/ood/config/apps/dashboard/intializers`
- copy `./lib/slurm_cluster` folder into `/etc/ood/config/apps/dashboard/lib`
- copy `./views/widgets` folder into `/etc/ood/config/apps/dashboard/views`

Restart the OnDemand application for the customizations to take effect.