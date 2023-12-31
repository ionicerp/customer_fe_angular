# Stage 1
FROM node:18.16.1-alpine AS build
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2
FROM nginx:stable-alpine3.17
RUN mkdir -p /usr/share/nginx/html/customer
COPY --from=build /usr/src/app/dist/customer_fe_angular/ /usr/share/nginx/html/customer
