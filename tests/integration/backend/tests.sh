#!/bin/sh

rm -rf /app/dist
rm -rf /app/node_modules


cp -r /app /test_dir

cd /test_dir

yarn install --frozen-lockfile
npx prisma generate || { echo 'Prisma Generation Failed'; exit 1; }
npx prisma migrate deploy || { echo 'Prisma Migration Failed'; exit 1; }

yarn test:e2e