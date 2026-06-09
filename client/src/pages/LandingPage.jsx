import { Link } from 'react-router-dom';
import { ArrowRight, BrainCircuit, Users, LineChart, Sparkles } from 'lucide-react';
import { motion } from 'framer-motion';

// SumUp palette tokens
const P = {
  pageBase: '#FAFAF8',
  cardLight: '#FFFFFF',
  cardDark: '#111318',
  inputDark: '#1E2128',
  borderDark: '#2C2F38',
  gold: '#F5C518',
  textMuted: '#888780',
  textLight: '#C8C6C0',
  ink: '#0D0D0D',
  borderLight: '#E8E5DC',
};

const LandingPage = () => {
  return (
    <div style={{ minHeight: '100vh', background: P.pageBase, fontFamily: "-apple-system, BlinkMacSystemFont, 'Inter', sans-serif" }}>
      
      {/* Hero Section */}
      <main style={{ padding: '120px 24px 80px', textAlign: 'center', maxWidth: 960, margin: '0 auto' }}>
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5 }}
        >
          <div style={{
            display: 'inline-flex', alignItems: 'center', gap: 8, padding: '8px 16px',
            borderRadius: 20, background: 'rgba(245,197,24,0.15)', border: `1px solid rgba(245,197,24,0.3)`,
            color: P.ink, fontSize: 13, fontWeight: 700, marginBottom: 32, letterSpacing: '0.02em'
          }}>
            <Sparkles size={16} color={P.ink} />
            <span>Next-Generation College Community</span>
          </div>
          
          <h1 style={{
            fontSize: 'clamp(48px, 6vw, 72px)', fontWeight: 900, color: P.ink,
            letterSpacing: '-0.04em', lineHeight: 1.1, marginBottom: 24,
            textWrap: 'balance'
          }}>
            Connect intelligently with <span style={{ color: P.gold }}>like-minded peers.</span>
          </h1>
          
          <p style={{
            fontSize: 18, color: P.textMuted, maxWidth: 640, margin: '0 auto 48px',
            lineHeight: 1.6, fontWeight: 500, textWrap: 'balance'
          }}>
            Our AI-powered platform discovers your interests, analyzes your skills, and builds the perfect communities. No more feeling lost in the crowd.
          </p>
          
          <Link to="/auth" style={{ textDecoration: 'none' }}>
            <button
              onMouseEnter={e => {
                e.currentTarget.style.transform = 'translateY(-2px)';
                e.currentTarget.style.boxShadow = '0 12px 32px rgba(245,197,24,0.5), 0 4px 12px rgba(0,0,0,0.15)';
              }}
              onMouseLeave={e => {
                e.currentTarget.style.transform = 'translateY(0)';
                e.currentTarget.style.boxShadow = '0 6px 20px rgba(245,197,24,0.4), 0 2px 6px rgba(0,0,0,0.1)';
              }}
              style={{
                display: 'inline-flex', alignItems: 'center', gap: 12, padding: '16px 36px',
                borderRadius: 14, background: P.gold, color: P.ink, fontSize: 17, fontWeight: 700,
                border: 'none', cursor: 'pointer',
                boxShadow: '0 6px 20px rgba(245,197,24,0.4), 0 2px 6px rgba(0,0,0,0.1)',
                transition: 'all 0.2s cubic-bezier(0.4, 0, 0.2, 1)',
              }}
            >
              Get Started <ArrowRight size={20} />
            </button>
          </Link>
        </motion.div>
      </main>

      {/* Features Grid */}
      <section style={{ padding: '0 24px 120px', maxWidth: 1200, margin: '0 auto' }}>
        <div style={{
          display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))', gap: 24
        }}>
          {[
            {
              title: "AI Chatbot Survey",
              desc: "An interactive, friendly AI chatbot that learns about your goals, skills, and passions in minutes.",
              icon: BrainCircuit,
              color: "#3B82F6" // Blue
            },
            {
              title: "Data Cleaning AI",
              desc: "Our intelligent agent automatically normalizes and cleans the survey data, fixing spelling and junk entries.",
              icon: Sparkles,
              color: "#10B981" // Emerald
            },
            {
              title: "Smart Clustering",
              desc: "Machine learning groups students into meaningful communities based on deep semantic similarities.",
              icon: Users,
              color: "#8B5CF6" // Violet
            },
            {
              title: "Faculty Analytics",
              desc: "Comprehensive dashboard and downloadable PDF/Excel reports to understand the student body.",
              icon: LineChart,
              color: P.gold // Gold
            }
          ].map((feature, idx) => (
            <motion.div
              key={idx}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.5, delay: 0.1 * (idx + 1) }}
              onMouseEnter={e => {
                e.currentTarget.style.transform = 'translateY(-4px)';
                e.currentTarget.style.boxShadow = '0 20px 40px rgba(0,0,0,0.15), 0 4px 12px rgba(0,0,0,0.08)';
              }}
              onMouseLeave={e => {
                e.currentTarget.style.transform = 'translateY(0)';
                e.currentTarget.style.boxShadow = '0 8px 24px rgba(0,0,0,0.06), 0 2px 8px rgba(0,0,0,0.04)';
              }}
              style={{
                background: P.cardLight, borderRadius: 24, padding: 32,
                border: `1px solid ${P.borderLight}`,
                boxShadow: '0 8px 24px rgba(0,0,0,0.06), 0 2px 8px rgba(0,0,0,0.04)',
                transition: 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)', cursor: 'default'
              }}
            >
              <div style={{
                width: 48, height: 48, borderRadius: 14, background: 'rgba(17,19,24,0.04)',
                display: 'flex', alignItems: 'center', justifyContent: 'center', marginBottom: 24
              }}>
                <feature.icon size={24} color={feature.color} />
              </div>
              <h3 style={{ fontSize: 20, fontWeight: 800, color: P.ink, letterSpacing: '-0.02em', marginBottom: 12 }}>
                {feature.title}
              </h3>
              <p style={{ fontSize: 15, color: P.textMuted, lineHeight: 1.6, fontWeight: 500 }}>
                {feature.desc}
              </p>
            </motion.div>
          ))}
        </div>
      </section>
    </div>
  );
};

export default LandingPage;
