# Set the base image for the build stage
FROM node:alpine as builder
WORKDIR '/app'

# Copy the package.json to be used by npm install
COPY package.json .

# Run npm install
RUN npm install

# Copy the rest of the source
COPY . .

# Run the build
RUN npm run build

# Set the base image for the run stage (leverage nginx as web server)
FROM nginx

# Copy, from builder phase, the build folder into the containers app/build folder
COPY --from=builder /app/build /usr/share/nginx/html
