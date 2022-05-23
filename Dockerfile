# Set stage base image ~ Using an alias 'as' set the base image 
# to use for any subsequent instructions that follow and also give 
# this build stage a name.
FROM node:16.7.0-alpine3.13 as build

# Defines working directory
WORKDIR /home/node/app

# Copy dependencies file
COPY ./package.json /home/node/app

# Install dependencies
RUN npm install

# Copy source code
COPY . /home/node/app/

# Run build
RUN npm run build

# All the static files that we need to run our web application
# Are on the folder /home/node/app/build 
# This folder is our target to the next phase

# A second FROM statement declares the end of the previous phase
# A block of instructions belongs only to a single FROM statement
FROM nginx

EXPOSE 80

# Copy source code from previous build stage
COPY --from=build /home/node/app/build /usr/share/nginx/html
