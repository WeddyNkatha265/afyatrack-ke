FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY app/package*.json ./

# Install dependencies
RUN npm install --only=production

# Copy application code
COPY app/ ./

# Create app user for security
RUN addgroup -g 1001 -S nodejs && \
    adduser -S afyaapp -u 1001

# Change ownership to app user
RUN chown -R afyaapp:nodejs /app
USER afyaapp

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD node healthcheck.js

# Start application
CMD ["npm", "start"]