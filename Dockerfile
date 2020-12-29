# test using the latest node container
FROM node:latest AS ci 

# mark it with a label so we can remove dangling images
LABEL cicd="hello"

WORKDIR /app
COPY package.json .
COPY package-lock.json .
COPY server.js .
RUN npm ci --development

# get production modules
RUN rm -rf node_modules && npm ci --production

# This is our runtime container that will end up running on the device
FROM node:alpine

# Mark it with a label so we can remove dangling images
LABEL cicd="hello"

# Copy our node_modules into our deployable container context
WORKDIR /app
COPY --from=ci /app/node_modules node_modules
COPY server.js server.js

# Launch our app
CMD ["node", "server.js"]
