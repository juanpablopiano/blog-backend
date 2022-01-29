# Dev Build
FROM node:17.4.0-alpine3.14 AS development

WORKDIR /app

COPY package*.json ./

RUN npm i glob rimraf

RUN npm install --only=development

COPY . .

RUN npm run build

# Production Build
FROM node:17.4.0-alpine3.14 as production

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /app

COPY package*.json ./

RUN npm install --only=production

COPY . .

COPY --from=development /app/dist ./dist

CMD ["node", "dist/main"]
