#!/bin/sh

rm -rf /app/dist
rm -rf /app/node_modules

cd /app

yarn install
npx prisma generate || { echo 'Prisma Generation Failed'; exit 1; }
npx prisma migrate || { echo 'Prisma Migration Failed'; exit 1; }

yarn run test:e2e