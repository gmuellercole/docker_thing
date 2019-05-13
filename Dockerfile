##########  SECTION 1 #######
FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .

#emits runtime content to the build folder
RUN npm run build

##########  SECTION 2 #######

# inline FROM delineates the start of a second phase
FROM nginx

# the from specifies the name of the section we want to collect from
# we know the destination because we read the nginx doc at docker hun
COPY --from=builder /app/build /usr/share/nginx/html

# we don't need to specify an explicit startup command bc the ngix
# image start nginx by default