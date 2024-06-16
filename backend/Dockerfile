FROM node:20-alpine as base 

WORKDIR /app

COPY package.json package-*.json yarn.lock ./ 

RUN yarn install

FROM node:20-alpine as builder

WORKDIR /app

COPY --from=base --chown=node:node /app/node_modules ./node_modules
COPY . . 

ENV NODE_ENV production

RUN npx prisma generate && yarn build && yarn cache clean --force

FROM node:20-alpine as runner

WORKDIR /app

USER node 

COPY --from=builder --chown=node:node /app/package*.json /app/yarn.lock ./
COPY --from=builder --chown=node:node /app/node_modules ./node_modules
COPY --from=builder --chown=node:node /app/dist ./dist
COPY --from=builder --chown=node:node /app/prisma  ./prisma

EXPOSE 3000

CMD ["node", "dist/main.js"]
