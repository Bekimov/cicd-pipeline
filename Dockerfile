FROM node:7.8.0

WORKDIR /opt

COPY package.json package-lock.json ./
RUN npm install

COPY src ./src
COPY public ./public

CMD ["npm", "start"]
