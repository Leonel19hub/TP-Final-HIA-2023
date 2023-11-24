FROM node:14.15.4  as build-step

RUN mkdir -p /app

WORKDIR /app

COPY package.json /app

RUN npm install

COPY . /app

RUN npm run build --prod

FROM nginx:alpine

# RUN rm etc/nginx/conf.d/default.conf
COPY --from=build-step /app/dist/proy-frontend-grupo07 /usr/share/nginx/html
COPY --from=build-step /app/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

