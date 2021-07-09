# Node-RED Weather Routing Logistics Dashboard
Build a Node-RED Dashboard which overlays TWC weather maps on a HERE truck routing map

This example might be useful for a package logistics company who wants to build logistics applications using TWC APIs that can help improve route planning, driver safety and equipment safety.  Using The Weather Company APIs to alert drivers of storm warnings and forecasts, wind advisories, winter conditions, and real time driving updates can improve package delivery times and protect drivers.

It uses [The Weather Company APIs](https://www.ibm.com/products/weather-operations-center/data-packages) to display a near real-time North America Satellite / Radar Weather map on a [Node-RED](https://nodered.org) Dashboard. It could be extended to display TWC forecast map tiles of winter advisories, hail alerts, wind conditions, etc.

This Node-RED flow retrieves map tiles from the [TWC Current Conditions](https://ibm.co/TWCecc) package and, specifically, the [Current Conditions Gridded Tiler APIs](https://ibm.co/v2EHCg). There are many TWC weather map tile layers available.  One of the APIs returns satellite and weather radar tiles. See the [Node-RED-TWC-Weather-Radar-Map](https://github.com/johnwalicki/Node-RED-TWC-Weather-Radar-Map) repository for additional examples.

It also uses the [HERE.com Routing APIs](https://developer.here.com/documentation#routing_and_navigation_section) to build a map navigation dashboard and plots the truck route on a [Node-RED](https://nodered.org) Dashboard.

To assist the driver during hazardous driving conditions, it uses the [Watson Text to Speech](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-about#about) service to narrate the route.

This example flow and Node-RED Dashboard might be useful as part of a [Call for Code](https://developer.ibm.com/callforcode/) solution that uses TWC and HERE Technologies APIs.  Natural disaster applications could guide someone to safety.

### Prerequistes

- [Install Node-RED](https://nodered.org/docs/getting-started/) on your system or in the cloud
  - This flow can be deployed to [IBM Cloud](https://cloud.ibm.com/registration) by creating a [Node-RED Starter Application](https://developer.ibm.com/components/node-red/tutorials/how-to-create-a-node-red-starter-application/)
- This flow requires Node-RED v1.3 or higher
- [Add the following nodes](https://nodered.org/docs/user-guide/runtime/adding-nodes) to your Node-RED palette
  - [node-red-dashboard](https://flows.nodered.org/node/node-red-dashboard)
  - [node-red-contrib-here-maps](https://github.com/johnwalicki/node-red-contrib-here-maps)
  - [node-red-node-ui-table](https://flows.nodered.org/node/node-red-node-ui-table)
  - [node-red-contrib-web-worldmap](https://flows.nodered.org/node/node-red-contrib-web-worldmap)
  - [node-red-node-watson](https://flows.nodered.org/node/node-red-node-watson)
- Signup for a [HERE Developer account](https://developer.here.com)
- Signup for an [IBM Cloud](https://cloud.ibm.com/registration) account
- Create a (free) instance of [Watson Text to Speech](https://cloud.ibm.com/catalog/services/text-to-speech)
- If you are participating in the [2021 Call for Code](https://developer.ibm.com/callforcode/) you can [register](https://developer.ibm.com/callforcode/tools/weather/) for a time limited TWC API key.
- Learn more about the TWC APIs used in this Node-RED flow by reading the [TWC Current Conditions API documentation](https://ibm.co/TWCecc)

## API Keys

Set your TWC API, HERE API and Watson Text to Speech keys as environment variables before starting Node-RED

```sh
export TWCAPIKEY=<TWC API KEY>
export HEREAPIKEY=<HERE API KEY>
export WATSON_TTS=<Watson Text to Speech API KEY>
```

## Node-RED flow in this repository:
---
### A flow that displays a Weather Map and Navigation Route

![Weather Routing Logistics Navigation Dashboard](screenshots/Node-RED-TWC-Logistics-Routing-Dashboard.png?raw=true "Weather Logistics Navigation Dashboard")
<p align="center">
  <strong>Get the Code: <a href="flow.json">Node-RED flow for Weather Logistics Routing / Navigation</strong></a>
</p>

![Weather Routing Logistics flow](screenshots/Node-RED-WeatherRoutingLogistics-flow.png?raw=true "Weather Logistics Navigation flow")

This flow has four sections:
1. The **Starting and Destination Locations / Geocode** section displays a Node-RED Dashboard form which prompts the navigator
to enter their starting location and ending destination.  The flow then calls the [HERE Geocode Search API](https://developer.here.com/documentation/geocoding-search-api/dev_guide/index.html) to determine the latitude and longitude of the two waypoints.
1. The **Request Driving Navigation Instructions** section calls the [HERE Routing API](https://developer.here.com/documentation/routing/dev_guide/topics/introduction.html) to calculate the route between the two locations.  It builds a table of these driving instructions and displays a summary of the route distance and driving duration.
1. The **Draw Map and Route** section moves the truck on the node-red-contrib-web-worldmap as the navigator clicks on the **Navigation Preview** button. It loads the TWC Weather Satellite Radar tile overlays onto the worldmap to warn the driver of impending weather conditions.
1. The **Read the Driving Instructions** section determines if the mute slider is on / off and uses the Watson Text to Speech service to read the driving instructions aloud. Paste your Watson Text to Speech credentials into the node.
---

## Containerization

You might want to deploy this Node-RED flow to IBM Cloud Code Engine.  The first step is to build a container.  This repository includes a `Makefile` and a `Dockerfile` to assist in building a container.

- Log into your Docker Hub account so the container can be hosted for Cloud deployment.

  ```sh
  docker login
  ```

- Edit the variable at the top of the Makefile, if necessary. If you plan to push it to a Docker registry, make sure you enter your docker ID.
  - Change the following `Makefile` line:

    ```make
    DOCKERHUB_ID:=<your docker registry account>
    ```

- Enter the TWC, HERE, Watson TTS API Keys in the .env file (see .env.example for formatting)

- Build the container, run the container, test the Node-RED Dashboard in the container, push the container to the Docker registry.

  ```sh
  make build
  make run
  make test
  make ui
  make push
  ```

### Authors

- [John Walicki](https://github.com/johnwalicki)

---

Enjoy! Give us [feedback](https://github.com/johnwalicki/Node-RED-Weather-Routing-Logistics/issues) if you have suggestions on how to improve this tutorial.

## License

This tutorial is licensed under the Apache Software License, Version 2.  Separate third party code objects invoked within this code pattern are licensed by their respective providers pursuant to their own separate licenses. Contributions are subject to the [Developer Certificate of Origin, Version 1.1 (DCO)](https://developercertificate.org/) and the [Apache Software License, Version 2](http://www.apache.org/licenses/LICENSE-2.0.txt).