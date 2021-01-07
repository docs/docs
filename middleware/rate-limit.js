const rateLimit = require('express-rate-limit')
const RedisStore = require('rate-limit-redis')
const Redis = require('ioredis')

const isProduction = process.env.NODE_ENV === 'production'
const { REDIS_URL } = process.env
const rateLimitDatabaseNumber = 0

module.exports = rateLimit({
  // 1 minute (or practically unlimited outside of production)
  windowMs: isProduction ? (60 * 1000) : 1,
  // limit each IP to X requests per windowMs
  max: 250,
  // Don't rate limit requests for 200s and redirects
  // Or anything with a status code less than 400
  skipSuccessfulRequests: true,
  // When available, use Redis
  store: REDIS_URL && new RedisStore({ client: new Redis(REDIS_URL, { db: rateLimitDatabaseNumber }) })
})
