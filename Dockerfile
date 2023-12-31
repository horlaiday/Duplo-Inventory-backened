FROM node:16.13.1-alpine3.15 AS development

LABEL maintainer = INVENTORY<test@tset.com>

# Set workdir
WORKDIR /var/www/inventory

COPY package*.json ./

RUN npm cache clean --force

# install dependencies
RUN npm install

# copy source
COPY . .

#Build app
RUN npx tsc

#STAGE
FROM node:16.13.1-alpine3.15 as production

# Set workdir
WORKDIR /var/www/inventory

COPY package*.json ./

#copy node_modules and package json
COPY --from=development /var/www/inventory/node_modules ./node_modules
COPY --from=development /var/www/inventory/package*.json ./

#copy api  doc
# COPY --from=development /var/www/inventory/public ./public

#copy the build output
COPY --from=development /var/www/inventory/build ./build
COPY --from=development /var/www/inventory/tsconfig.json .


EXPOSE 5050
## Launch the application
CMD ["npm",  "start"]
