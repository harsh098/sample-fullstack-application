FROM node:20-alpine AS base

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm install

FROM node:20-alpine as builder

ARG NEXT_PUBLIC_BACKEND_BASE_URL

ENV NEXT_PUBLIC_BACKEND_BASE_URL ${NEXT_PUBLIC_BACKEND_BASE_URL}

ENV NODE_ENV production

WORKDIR /app

COPY --from=base /app/node_modules ./node_modules

COPY . .

RUN npm run build 

FROM node:20-alpine as runner 

ENV NEXT_TELEMETRY_DISABLED 1

RUN addgroup nodejs
RUN adduser -SDH nextjs
RUN mkdir .next
RUN chown nextjs:nodejs .next

COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static
COPY --from=builder --chown=nextjs:nodejs /app/public ./public

USER nextjs

EXPOSE 3000
ENV PORT 3000
ENV HOSTNAME "0.0.0.0"
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "wget", "-q0", "http://localhost:3000/health" ]


CMD [ "node", "server.js" ]

