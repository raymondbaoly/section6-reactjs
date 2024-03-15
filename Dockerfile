FROM node:14.18.0 AS build

WORKDIR /app
COPY package.json .
RUN npm install
COPY . .

RUN npm run build

FROM nginx:1.19.0
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=build /app/build .
ENTRYPOINT ["nginx", "-g", "daemon off;"]