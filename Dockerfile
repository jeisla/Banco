FROM node:12.14.0-alpine AS builder
WORKDIR /opt/web
COPY package.json package-lock.json ./
RUN npm install --no-package-lock
ENV PATH="./node_modules/.bin:$PATH"
COPY . ./
RUN ng build --prod
FROM nginx:1.17-alpine
COPY nginx.config /etc/nginx/conf.d/default.conf
COPY --from=builder /opt/web/dist/angularfull /usr/share/nginx/html