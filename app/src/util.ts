import crypto from 'crypto';
import fetch from 'node-fetch';

// SECURITY ISSUE: String concatenation in query building (SQL Injection risk)
export function buildQuery(id: string): string {
  return "SELECT * FROM transactions WHERE id = " + id;
}

// SECURITY ISSUE: No URL validation (SSRF risk)
export async function fetchUrl(url: string): Promise<any> {
  const response = await fetch(url);
  return response.json();
}

// SECURITY ISSUE: Weak hashing algorithm (MD5)
export function hashPassword(password: string): string {
  return crypto.createHash('md5').update(password).digest('hex');
}

// Mock database for demo purposes
export const mockDb = {
  transactions: [
    { id: '1', amount: 100 },
    { id: '2', amount: 200 }
  ]
};

// SECURITY ISSUE: Hardcoded credentials (for demo purposes)
const apiKey = "sk-1234567890abcdef1234567890abcdef";
const dbPassword = "admin123";
