FROM node:20-alpine

WORKDIR /

ENV NODE_OPTIONS="--max-old-space-size=4096"

COPY . ./

RUN npm install
RUN cd apps/tunnel && npm install 
RUN cd apps/internal-check && npm install
RUN cd apps/cron && npm install 
RUN cd apps/web && npm install

# RUN cd apps/web && npm run db:generate-auth || true
# RUN cd apps/web && npm run db:migrate || true

RUN cd apps/tunnel && npm run build
RUN cd apps/internal-check && npm run build
RUN cd apps/cron && npm run build
RUN cd apps/web && npm run build


# ENV NODE_ENV=production


