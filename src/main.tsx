import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'
import App from './App.tsx'
import { iniciarAnalytics } from '@/lib/analytics'

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <App />
  </StrictMode>,
)

// Tags de marketing: só carregam se já houver aceite (ver src/lib/consent.ts).
iniciarAnalytics()
