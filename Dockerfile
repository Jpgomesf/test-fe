# Stage 1: Build the Angular app
FROM node:latest as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build -- --output-path=./dist/out --configuration=production

# Stage 2: Serve the Angular app with nginx
FROM nginx:alpine
COPY --from=build-stage /app/dist/out /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

