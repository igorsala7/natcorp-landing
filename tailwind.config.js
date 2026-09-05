/** @type {import('tailwindcss').Config} */
export default {
  darkMode: ['class'],
  content: ['./index.html', './src/**/*.{ts,tsx}'],
  theme: {
    container: {
      center: true,
      padding: { DEFAULT: '1.25rem', sm: '1.5rem', lg: '2rem' },
      screens: { '2xl': '1280px' },
    },
    extend: {
      colors: {
        border: 'hsl(var(--border))',
        input: 'hsl(var(--input))',
        ring: 'hsl(var(--ring))',
        background: 'hsl(var(--background))',
        foreground: 'hsl(var(--foreground))',
        primary: { DEFAULT: 'hsl(var(--primary))', foreground: 'hsl(var(--primary-foreground))' },
        secondary: { DEFAULT: 'hsl(var(--secondary))', foreground: 'hsl(var(--secondary-foreground))' },
        destructive: { DEFAULT: 'hsl(var(--destructive))', foreground: 'hsl(var(--destructive-foreground))' },
        muted: { DEFAULT: 'hsl(var(--muted))', foreground: 'hsl(var(--muted-foreground))' },
        accent: { DEFAULT: 'hsl(var(--accent))', foreground: 'hsl(var(--accent-foreground))' },
        popover: { DEFAULT: 'hsl(var(--popover))', foreground: 'hsl(var(--popover-foreground))' },
        card: { DEFAULT: 'hsl(var(--card))', foreground: 'hsl(var(--card-foreground))' },
        /* Paleta oficial — Manual de Identidade Visual Natcorp v1.2 */
        brand: {
          purple: '#511C76', // Roxo Natcorp — cor primária
          'purple-hover': '#3E1A6F',
          blue: '#2C1A63', // Azul Profundo — fundos escuros, fim do gradiente
          pink: '#C95788', // Rosa Natcorp — acento, dados, CTAs secundários
          'mix-80': '#692878', // Roxo 80 / Rosa 20
          'mix-60': '#81347D', // Roxo 60 / Rosa 40
          plum: '#9A408A', // Ameixa — início do gradiente
          ink: '#1B1238', // Tinta — texto principal e wordmark
          graphite: '#4A4460', // Grafite — texto secundário
          gray: '#8E88A3', // Cinza — legendas, ícones inativos
          mist: '#E9E5F1', // Névoa — bordas e divisores
          'off-white': '#F4F2F7', // Fundo de páginas e telas
          'dark-bg': '#120C24', // Modo escuro — fundo
          'dark-surface': '#1F1640', // Modo escuro — superfícies
        },
      },
      fontFamily: {
        sans: ['Manrope', 'ui-sans-serif', 'system-ui', 'Arial', 'sans-serif'],
      },
      letterSpacing: {
        brand: '-0.02em',
      },
      borderRadius: {
        lg: 'var(--radius)',
        md: 'calc(var(--radius) - 2px)',
        sm: 'calc(var(--radius) - 4px)',
        '4xl': '2rem',
        '5xl': '2.5rem',
      },
      boxShadow: {
        soft: '0 1px 2px rgba(27, 18, 56, 0.04), 0 8px 24px -8px rgba(27, 18, 56, 0.12)',
        lift: '0 2px 4px rgba(27, 18, 56, 0.05), 0 24px 48px -16px rgba(81, 28, 118, 0.25)',
        glow: '0 0 0 1px rgba(255,255,255,0.06), 0 30px 80px -20px rgba(154, 64, 138, 0.45)',
        'inner-mist': 'inset 0 0 0 1px #E9E5F1',
      },
      backgroundImage: {
        'brand-gradient': 'linear-gradient(135deg, #9A408A 0%, #511C76 50%, #2C1A63 100%)',
        'brand-gradient-soft': 'linear-gradient(135deg, #692878 0%, #511C76 60%, #2C1A63 100%)',
        'grid-45': 'linear-gradient(45deg, rgba(81,28,118,0.06) 1px, transparent 1px), linear-gradient(-45deg, rgba(81,28,118,0.06) 1px, transparent 1px)',
      },
      transitionTimingFunction: {
        brand: 'cubic-bezier(0.22, 1, 0.36, 1)',
        'in-out-brand': 'cubic-bezier(0.65, 0, 0.35, 1)',
      },
      keyframes: {
        'accordion-down': { from: { height: '0' }, to: { height: 'var(--radix-accordion-content-height)' } },
        'accordion-up': { from: { height: 'var(--radix-accordion-content-height)' }, to: { height: '0' } },
        marquee: { from: { transform: 'translateX(0)' }, to: { transform: 'translateX(-50%)' } },
        float: { '0%, 100%': { transform: 'translateY(0)' }, '50%': { transform: 'translateY(-8px)' } },
        'pulse-soft': { '0%, 100%': { opacity: '1' }, '50%': { opacity: '0.55' } },
        shimmer: { from: { backgroundPosition: '200% 0' }, to: { backgroundPosition: '-200% 0' } },
      },
      animation: {
        'accordion-down': 'accordion-down 0.25s cubic-bezier(0.22, 1, 0.36, 1)',
        'accordion-up': 'accordion-up 0.2s cubic-bezier(0.22, 1, 0.36, 1)',
        marquee: 'marquee 60s linear infinite',
        float: 'float 6s ease-in-out infinite',
        'pulse-soft': 'pulse-soft 2.4s ease-in-out infinite',
        shimmer: 'shimmer 2.5s linear infinite',
      },
    },
  },
  plugins: [],
}
