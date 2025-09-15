import { Router } from 'express';
import { buildQuery, fetchUrl, mockDb } from './util';

const router = Router();

router.get('/search', (req, res) => {
  const { q } = req.query;
  if (!q || typeof q !== 'string') {
    return res.status(400).json({ error: 'Missing query parameter' });
  }

  // Intentionally vulnerable: uses string concatenation
  const query = buildQuery(q);
  
  // Mock query execution
  const results = mockDb.transactions.filter(t => t.id === q);
  
  res.json({ query, results });
});

router.get('/fetch', async (req, res) => {
  const { url } = req.query;
  if (!url || typeof url !== 'string') {
    return res.status(400).json({ error: 'Missing URL parameter' });
  }

  try {
    // Intentionally vulnerable: no URL validation
    const data = await fetchUrl(url);
    res.json(data);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch URL' });
  }
});

export default router;
