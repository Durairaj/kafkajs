FROM node:12.13.0 AS builder

WORKDIR /usr/src/app

COPY ./ /usr/src/app

RUN npm ci --quiet && npm run build
FROM node:12.13.0-slim

WORKDIR /app
ENV NODE_ENV=production

COPY package*.json ./
COPY tsconfig.build.json ./
COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY --from=builder /usr/src/app/dist ./dist
EXPOSE 3000

CMD npm run start:prod
