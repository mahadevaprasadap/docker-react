FROM node:alpine

WORKDIR /app
COPY package*.json ./
RUN mkdir /app/node_module
RUN npm install
COPY --chown=node:node ./ ./
USER node
RUN npm run build
RUN npm config set unsafe-perm true

FROM nginx
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html