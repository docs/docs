import express, { Request, Response } from 'express'

import catchMiddlewareError from '#src/observability/middleware/catch-middleware-error.js'
import { aiSearchProxy } from '../lib/ai-search-proxy'

const router = express.Router()

router.post(
  '/v1',
  catchMiddlewareError(async (req: Request, res: Response) => {
    await aiSearchProxy(req, res)
  }),
)

// Redirect to most recent version
router.post('/', (req, res) => {
  res.redirect(307, req.originalUrl.replace('/ai-search', '/ai-search/v1'))
})

export default router
