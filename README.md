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

A local user has been configured to use the dashboards: username: `ood` => password: `ood`

### Dynamic Configuration
The configuration for the OOD Demo application can be found under [./config/demo/ondemand.d](./config/demo/ondemand.d)

The Demo has been customized to dynamically load configuration changes to facilitate development and exploring new features. No application restart required.

### Announcements
The demo OOD application has been configured to use the local folder [./config/demo/public/announcements](./config/demo/public/announcements) to load announcements.

For more information on announcements, see the [OOD documentation](https://osc.github.io/ood-documentation/latest/customizations.html#announcements)

## Widgets Partials
To illustrate how Widget Partials work, we created a partially implemented feature: "Favorite Sessions".
The idea for this feature is to store your important sessions into a list and create a view that only shows these sessions.

Code: [./dev/widget_partials](./dev/widget_partials)

The partial implementation uses Widgets Partials to handle some of its functionality:
 - Post session id and store it in the user settings file.
 - Render the currently stored sessions component to display on the sessions page.
 - WebService to return the currently stored sessions as a JSON payload.

To install "Favorite Sessions" run:
```
make install_widgets
# restart your dashboard to load new code
# help > Restart Webserver
```

### How to Review
This feature adds a clickable star to the session cards. When the star is clicked, the session id is stored in the user settings.

To see it working, create a new interactive session, eg: RStudio.
When the session page is displayed, click in the star on the session card. This action will add the session id into the Favorites left hand menu.

```
# Session Page
GET https://localhost:33000/pun/sys/dashboard/batch_connect/sessions

# Widget Partial: Favorites Menu. Renders HTML partial
GET https://localhost:33000/pun/sys/dashboard/widgets/favorites

# Widget Partial: Favorites List. Renders JSON
GET https://localhost:33000/pun/sys/dashboard/widgets/favorites.json
Response: [ "9e752b3e-4e28-4a1d-9ba4-198d5d266bb7", "fb3ef806-078c-463a-957b-392e79d11980"]

# Widget Partial: Adds a session id to the user settings.
  Returns a JSON response.
POST https://localhost:33000/pun/sys/dashboard/widgets/add_favorite
Payload: { "session_id": "fb3ef806-078c-463a-957b-392e79d11980" }
```


## Plugins
