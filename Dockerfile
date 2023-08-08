FROM node:alpine AS build-stage
WORKDIR /app
COPY package.json .
COPY package-lock.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine
# WORKDIR /usr/share/nginx/html
# RUN rm -rf ./*
# COPY --from=builder /app/build/ .
COPY --from=build-stage /app/build/ /usr/share/nginx/html
# ENTRYPOINT ["nginx", "-g","daemon off;"]