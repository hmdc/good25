## IQSS Metrics Widget For OnDemand
Open OnDemand metrics widget displaying information about fairshare, job status summary, memory, CPU, GPU, and time. Data is retrieved directly from Slurm using the `sacct` and `sshare` commands.

The metrics widget consist of four panels:
- Fairshare
- CPU Jobs by state
- GPU Jobs by state
- Jobs Stats Summary

The metrics help widget is just a blurb of text.

### Implementation Summary
The implementation consist of three components
- OOD Slurm adapter extension
- ./initializers/slurm_extension.rb
- Metrics calculations utility classes
- ./lib/slurm_metrics
- Metrics widget and help templates
- ./views/widgets/metrics

### Deployment
Using the customization feature from OnDemand, with the default location under: `/etc/ood/config/apps/dashboard`
- copy `./initializers/slurm_extension.rb` into `/etc/ood/config/apps/dashboard/intializers`
- copy `./lib/slurm_metrics` folder into `/etc/ood/config/apps/dashboard/lib`
- copy `./views/widgets` folder into `/etc/ood/config/apps/dashboard/views`

Restart the OnDemand application for the customizations to take effect.