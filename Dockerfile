# First stage - build static content
FROM node:alpine as builder

WORKDIR /opt/frontend-app

COPY package.json .
RUN npm install

COPY . .
RUN npm run build

# Second stage - copy static files to nginx server and start it
FROM nginx
EXPOSE 80
COPY --from=builder /opt/frontend-app/build /usr/share/nginx/html