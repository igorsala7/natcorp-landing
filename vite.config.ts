import path from 'node:path'
import react from '@vitejs/plugin-react'
import { defineConfig } from 'vite'
import { logosPortais } from './vite/plugin-logos.js'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react(), logosPortais()],
  resolve: {
    alias: {
      '@': path.resolve(import.meta.dirname, './src'),
    },
  },
  build: {
    target: 'es2022',
    cssMinify: 'lightningcss',
    rolldownOptions: {
      output: {
        // Vendors estáveis em chunks próprios: cache de longa duração entre deploys.
        advancedChunks: {
          groups: [
            { name: 'react', test: /node_modules[\\/](react|react-dom|scheduler)[\\/]/, priority: 20 },
            { name: 'motion', test: /node_modules[\\/](motion|framer-motion|motion-dom|motion-utils)[\\/]/, priority: 10 },
          ],
        },
      },
    },
  },
})
