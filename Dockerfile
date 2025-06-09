FROM node:20-bullseye-slim

# Install ca-certificates package FIRST
RUN apt-get update && apt-get install -y \
    ca-certificates \
    python3 \
    make \
    g++ \
    sqlite3 \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy certificates (convert .pem to .crt or rename them)
COPY ca.bulwarx.goskope.com.crt /usr/local/share/ca-certificates/ca.bulwarx.goskope.com.crt
COPY CertServiceCA.crt /usr/local/share/ca-certificates/CertServiceCA.crt

# Update the certificate store
RUN update-ca-certificates

# Configure Node.js to use the system certificate bundle
ENV NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt

# Optional: Verify certificates were added
RUN ls -la /usr/local/share/ca-certificates/

WORKDIR /app

COPY package.json ./
COPY server/package.json ./server/
COPY client/package.json ./client/

RUN npm install
RUN cd server && npm install
RUN cd client && npm install

COPY ./server ./server
COPY ./client ./client

EXPOSE 8000 5173
CMD ["npm", "run", "dev"]