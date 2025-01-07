This is to show different commands presented in the Skill Boost tasks


### List active accounts
```bash
gcloud auth list
```

### List project ID
```bash
gcloud config list project
```

### Enabling Cloud Run API
```bash
gcloud services enable run.googleapis.com
```

### Setting compute region
```bash
gcloud config set compute/region europe-west4
```
Note that the region depends on selected configuration

### Setting LOCATION as environment variable
```bash
LOCATION="europe-west4"
```

### Building container image
```bash
gcloud builds submit --tag gcr.io/$GOOGLE_CLOUD_PROJECT/helloworld
```
Note that this is used after the [Directories for task](#directories-for-task) was done

### Listing containers
```bash
gcloud container images list
```

### Registering Docker
```bash
gcloud auth configure-docker
```

### Run and Test application locally
```bash
docker run -d -p 8080:8080 gcr.io/$GOOGLE_CLOUD_PROJECT/helloworld
```
After running the command, you can `curl localhost:8080`

### Deploying cloud run
```bash
gcloud run deploy --image gcr.io/$GOOGLE_CLOUD_PROJECT/helloworld --allow-unauthenticated --region=$LOCATION
```

### Cleaning up
```bash
gcloud container images delete gcr.io/$GOOGLE_CLOUD_PROJECT/helloworld

gcloud run services delete helloworld --region=europe-west4
```

## Directories for Task
These is the provided files that is expected to be used to complete the given task
```bash
> mkdir helloworld && cd helloword
```

### package.json
```json
{
  "name": "helloworld",
  "description": "Simple hello world sample in Node",
  "version": "1.0.0",
  "main": "index.js",
  "scripts": {
    "start": "node index.js"
  },
  "author": "Google LLC",
  "license": "Apache-2.0",
  "dependencies": {
    "express": "^4.17.1"
  }
}
```

### index.js
```js
const express = require('express');
const app = express();
const port = process.env.PORT || 8080;

app.get('/', (req, res) => {
  const name = process.env.NAME || 'World';
  res.send(`Hello ${name}!`);
});

app.listen(port, () => {
  console.log(`helloworld: listening on port ${port}`);
});
```

### Dockerfile
```dockerfile
# Use the official lightweight Node.js 12 image.
# https://hub.docker.com/_/node
FROM node:12-slim

# Create and change to the app directory.
WORKDIR /usr/src/app

# Copy application dependency manifests to the container image.
# A wildcard is used to ensure copying both package.json AND package-lock.json (when available).
# Copying this first prevents re-running npm install on every code change.
COPY package*.json ./

# Install production dependencies.
# If you add a package-lock.json, speed your build by switching to 'npm ci'.
# RUN npm ci --only=production
RUN npm install --only=production

# Copy local code to the container image.
COPY . ./

# Run the web service on container startup.
CMD [ "npm", "start" ]
```


