/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        pageBase: '#FAFAF8',
        surface: '#F2F0EA',
        cardLight: '#FFFFFF',
        cardDark: '#111318',
        cardDarkAlt: '#181B22',
        inputDark: '#1E2128',
        borderDark: '#2C2F38',
        ink: '#0D0D0D',
        gold: '#F5C518',
        textMuted: '#888780',
        textLight: '#C8C6C0',
        green: '#16A34A',
        red: '#B91C1C',
        borderLight: '#E8E5DC',
      },
      fontFamily: {
        sans: ['-apple-system', 'BlinkMacSystemFont', 'Inter', 'sans-serif'],
      },
      letterSpacing: {
        tighter: '-0.04em',
        wide: '0.08em',
        wider: '0.1em',
      },
      boxShadow: {
        'dark-card': '0 8px 40px rgba(0,0,0,0.35), 0 2px 8px rgba(0,0,0,0.2), inset 0 1px 0 rgba(255,255,255,0.06)',
        'light-card': '0 2px 12px rgba(0,0,0,0.06), 0 1px 3px rgba(0,0,0,0.04)',
        'yellow-btn': '0 4px 14px rgba(245,197,24,0.45), 0 1px 3px rgba(0,0,0,0.15)',
        'dark-btn': '0 4px 14px rgba(0,0,0,0.35), inset 0 1px 0 rgba(255,255,255,0.08)',
        'input-focus': 'inset 0 2px 4px rgba(0,0,0,0.2), 0 0 0 3px rgba(245,197,24,0.15)',
        'gold-glow': '0 0 6px rgba(245,197,24,0.6)',
        'pill-active': '0 0 0 1px rgba(245,197,24,0.13)',
      },
    },
  },
  plugins: [],
}
