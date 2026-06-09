import { useState, useEffect, useContext, useRef } from 'react';
import axios from 'axios';
import { AuthContext } from '../context/AuthContext';
import { motion, AnimatePresence } from 'framer-motion';
import {
  Play, Download, Users, Brain, Zap, FileText, Award, BarChart3,
  TrendingUp, Sparkles, ChevronRight, BookOpen, Lightbulb,
  Shield, Wifi, CheckCircle, AlertCircle, Clock, ArrowRight,
  Star, GraduationCap, Network, Beaker, Rocket, Target,
  Activity, Layers
} from 'lucide-react';

/* ================================================================
   PALETTE — SumUp-inspired brand tokens
   ================================================================ */
const P = {
  pageBase:    '#FAFAF8',
  surface:     '#F2F0EA',
  cardLight:   '#FFFFFF',
  cardDark:    '#111318',
  cardDarkAlt: '#181B22',
  inputDark:   '#1E2128',
  borderDark:  '#2C2F38',
  ink:         '#0D0D0D',
  gold:        '#F5C518',
  textMuted:   '#888780',
  textLight:   '#C8C6C0',
  green:       '#16A34A',
  red:         '#B91C1C',
  borderLight: '#E8E5DC',
};

/* ================================================================
   SHADOW TOKENS
   ================================================================ */
const S = {
  darkCard:   '0 8px 40px rgba(0,0,0,0.35), 0 2px 8px rgba(0,0,0,0.2), inset 0 1px 0 rgba(255,255,255,0.06)',
  lightCard:  '0 2px 12px rgba(0,0,0,0.06), 0 1px 3px rgba(0,0,0,0.04)',
  yellowBtn:  '0 4px 14px rgba(245,197,24,0.45), 0 1px 3px rgba(0,0,0,0.15)',
  darkBtn:    '0 4px 14px rgba(0,0,0,0.35), inset 0 1px 0 rgba(255,255,255,0.08)',
  goldGlow:   '0 0 6px rgba(245,197,24,0.6)',
};

/* ================================================================
   REUSABLE BUTTON ATOMS
   ================================================================ */
const DarkBtn = ({ children, onClick, disabled, style, ...rest }) => {
  const [hovered, setHovered] = useState(false);
  return (
    <button
      onClick={onClick}
      disabled={disabled}
      onMouseEnter={() => setHovered(true)}
      onMouseLeave={() => setHovered(false)}
      style={{
        display: 'inline-flex', alignItems: 'center', gap: 8,
        padding: '13px 28px', borderRadius: 12,
        background: P.ink, color: '#fff',
        fontWeight: 600, fontSize: 14, border: 'none', cursor: disabled ? 'not-allowed' : 'pointer',
        boxShadow: hovered ? '0 8px 24px rgba(0,0,0,0.45), inset 0 1px 0 rgba(255,255,255,0.08)' : S.darkBtn,
        transform: hovered && !disabled ? 'translateY(-1px)' : 'translateY(0)',
        transition: 'all 0.2s cubic-bezier(0.4,0,0.2,1)',
        opacity: disabled ? 0.5 : 1,
        fontFamily: 'inherit',
        letterSpacing: '-0.01em',
        ...style,
      }}
      {...rest}
    >
      {children}
    </button>
  );
};

const GoldBtn = ({ children, onClick, style, ...rest }) => {
  const [hovered, setHovered] = useState(false);
  return (
    <button
      onClick={onClick}
      onMouseEnter={() => setHovered(true)}
      onMouseLeave={() => setHovered(false)}
      style={{
        display: 'inline-flex', alignItems: 'center', gap: 8,
        padding: '13px 28px', borderRadius: 12,
        background: P.gold, color: P.ink,
        fontWeight: 700, fontSize: 14, border: 'none', cursor: 'pointer',
        boxShadow: hovered ? '0 8px 24px rgba(245,197,24,0.55), 0 2px 6px rgba(0,0,0,0.2)' : S.yellowBtn,
        transform: hovered ? 'translateY(-1px)' : 'translateY(0)',
        transition: 'all 0.2s cubic-bezier(0.4,0,0.2,1)',
        fontFamily: 'inherit',
        letterSpacing: '-0.01em',
        ...style,
      }}
      {...rest}
    >
      {children}
    </button>
  );
};

/* ================================================================
   SECTION LABEL
   ================================================================ */
const SectionLabel = ({ number, text }) => (
  <div style={{
    fontSize: 10, fontWeight: 700, letterSpacing: '0.1em',
    textTransform: 'uppercase', color: P.textMuted, marginBottom: 16,
  }}>
    {number && <span style={{ color: P.gold }}>.</span>}{number && ' '}{text}
  </div>
);

/* ================================================================
   PIPELINE STATUS CARD
   ================================================================ */
const pipelineSteps = [
  { icon: FileText, label: 'Survey Collection', desc: 'Student survey data ingestion' },
  { icon: Sparkles, label: 'AI Cleaning', desc: 'Tech-term normalization & dedup' },
  { icon: Network, label: 'Community Discovery', desc: 'K-Means clustering with taxonomy' },
  { icon: Users, label: 'Student Matching', desc: 'Cosine similarity pairing' },
  { icon: BarChart3, label: 'Report Generation', desc: 'PDF, PPTX, Excel output' },
];

const PipelineCard = ({ running, success }) => {
  const status = running ? 'running' : success === true ? 'complete' : success === false ? 'error' : 'idle';
  const statusColors = {
    idle: P.textMuted,
    running: P.gold,
    complete: P.green,
    error: P.red,
  };
  const statusLabel = {
    idle: 'Ready',
    running: 'Processing...',
    complete: 'Complete',
    error: 'Failed',
  };

  return (
    <div style={{
      background: P.cardDark, borderRadius: 22,
      padding: 32, boxShadow: S.darkCard,
      minWidth: 340,
    }}>
      <div style={{ display: 'flex', alignItems: 'center', gap: 10, marginBottom: 24 }}>
        <div style={{
          width: 8, height: 8, borderRadius: '50%',
          background: statusColors[status],
          boxShadow: status === 'running' ? `0 0 10px ${P.gold}` : status === 'complete' ? `0 0 10px ${P.green}` : 'none',
          animation: status === 'running' ? 'pulse-dot 1.5s infinite' : 'none',
        }} />
        <span style={{ fontSize: 11, fontWeight: 700, letterSpacing: '0.1em', textTransform: 'uppercase', color: statusColors[status] }}>
          {statusLabel[status]}
        </span>
      </div>
      <div style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
        {pipelineSteps.map((step, i) => {
          const Icon = step.icon;
          const isActive = running && i <= 2; // simulate progress
          return (
            <div key={i} style={{
              display: 'flex', alignItems: 'center', gap: 14,
              padding: '12px 16px', borderRadius: 12,
              background: isActive ? P.cardDarkAlt : 'transparent',
              border: `1px solid ${isActive ? P.borderDark : 'transparent'}`,
              transition: 'all 0.3s ease',
            }}>
              <div style={{
                width: 36, height: 36, borderRadius: 10,
                background: isActive ? 'rgba(245,197,24,0.12)' : 'rgba(255,255,255,0.04)',
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                transition: 'all 0.3s ease',
              }}>
                <Icon size={16} color={isActive ? P.gold : P.textLight} />
              </div>
              <div>
                <div style={{ fontSize: 13, fontWeight: 600, color: isActive ? '#fff' : P.textLight }}>{step.label}</div>
                <div style={{ fontSize: 11, color: P.textMuted }}>{step.desc}</div>
              </div>
              {success && i <= 4 && (
                <CheckCircle size={14} color={P.green} style={{ marginLeft: 'auto' }} />
              )}
            </div>
          );
        })}
      </div>
    </div>
  );
};

/* ================================================================
   STAT PILL
   ================================================================ */
const StatPill = ({ icon: Icon, label, value, sub }) => (
  <div style={{ flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 4, padding: '24px 16px' }}>
    <span style={{ fontSize: 10, fontWeight: 700, letterSpacing: '0.1em', textTransform: 'uppercase', color: P.textMuted }}>
      {label}
    </span>
    <span style={{ fontSize: 28, fontWeight: 900, letterSpacing: '-0.04em', color: P.ink }}>
      {value}
    </span>
    {sub && <span style={{ fontSize: 11, color: P.textMuted }}>{sub}</span>}
  </div>
);

/* ================================================================
   COMMUNITY CARD
   ================================================================ */
const CommunityCard = ({ name, size, health, interests, index }) => {
  const [hovered, setHovered] = useState(false);
  const healthColor = health >= 70 ? P.green : health >= 45 ? P.gold : P.red;
  const healthLabel = health >= 70 ? 'Excellent' : health >= 45 ? 'Good' : 'Needs Attention';
  const icons = [Brain, Shield, Rocket, GraduationCap, Beaker, Target, Layers, Activity];
  const Icon = icons[index % icons.length];

  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ delay: index * 0.08 }}
      onMouseEnter={() => setHovered(true)}
      onMouseLeave={() => setHovered(false)}
      style={{
        background: P.cardDark, borderRadius: 18, padding: 28,
        boxShadow: hovered ? '0 12px 48px rgba(0,0,0,0.45), inset 0 1px 0 rgba(255,255,255,0.08)' : S.darkCard,
        transform: hovered ? 'translateY(-2px)' : 'translateY(0)',
        transition: 'all 0.25s cubic-bezier(0.4,0,0.2,1)',
        cursor: 'default',
      }}
    >
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 18 }}>
        <div style={{
          width: 42, height: 42, borderRadius: 12,
          background: 'rgba(245,197,24,0.1)',
          display: 'flex', alignItems: 'center', justifyContent: 'center',
        }}>
          <Icon size={20} color={P.gold} />
        </div>
        <div style={{
          display: 'flex', alignItems: 'center', gap: 6,
          padding: '4px 10px', borderRadius: 20,
          background: `${healthColor}18`, border: `1px solid ${healthColor}30`,
        }}>
          <div style={{ width: 6, height: 6, borderRadius: '50%', background: healthColor, boxShadow: `0 0 6px ${healthColor}` }} />
          <span style={{ fontSize: 10, fontWeight: 700, color: healthColor, letterSpacing: '0.06em' }}>{healthLabel}</span>
        </div>
      </div>
      <div style={{ fontSize: 16, fontWeight: 700, color: '#fff', marginBottom: 6, letterSpacing: '-0.02em' }}>{name}</div>
      <div style={{ fontSize: 12, color: P.textMuted, marginBottom: 16 }}>{size} students</div>
      <div style={{ display: 'flex', gap: 6, flexWrap: 'wrap' }}>
        {(interests || []).slice(0, 3).map((t, i) => (
          <span key={i} style={{
            padding: '4px 10px', borderRadius: 20, fontSize: 10, fontWeight: 600,
            background: 'rgba(255,255,255,0.06)', color: P.textLight,
            border: `1px solid ${P.borderDark}`,
          }}>{t}</span>
        ))}
      </div>
      <div style={{ marginTop: 16, height: 4, borderRadius: 4, background: 'rgba(255,255,255,0.06)', overflow: 'hidden' }}>
        <div style={{
          height: '100%', width: `${health}%`, borderRadius: 4,
          background: `linear-gradient(90deg, ${healthColor}, ${healthColor}cc)`,
          boxShadow: `0 0 8px ${healthColor}40`,
          transition: 'width 0.6s ease',
        }} />
      </div>
    </motion.div>
  );
};

/* ================================================================
   RECOMMENDATION CARD
   ================================================================ */
const RecommendationCard = ({ rec, index }) => {
  const icons = [Lightbulb, Beaker, BookOpen, Rocket, Target, Star, GraduationCap, Award];
  const Icon = icons[index % icons.length];
  return (
    <motion.div
      initial={{ opacity: 0, x: -10 }}
      animate={{ opacity: 1, x: 0 }}
      transition={{ delay: index * 0.06 }}
      style={{
        display: 'flex', alignItems: 'flex-start', gap: 14,
        padding: '18px 20px', borderRadius: 14,
        background: P.cardDarkAlt,
        border: `1px solid ${P.borderDark}`,
      }}
    >
      <div style={{
        width: 34, height: 34, borderRadius: 10, flexShrink: 0,
        background: 'rgba(245,197,24,0.1)',
        display: 'flex', alignItems: 'center', justifyContent: 'center',
      }}>
        <Icon size={15} color={P.gold} />
      </div>
      <div style={{ fontSize: 13, color: P.textLight, lineHeight: 1.6, fontWeight: 400 }}>
        {rec}
      </div>
    </motion.div>
  );
};

/* ================================================================
   MAIN DASHBOARD COMPONENT
   ================================================================ */
const DashboardPage = () => {
  const { user } = useContext(AuthContext);
  const [stats, setStats] = useState(null);
  const [loading, setLoading] = useState(true);
  const [generating, setGenerating] = useState(false);
  const [pipelineMessage, setPipelineMessage] = useState('');
  const [pipelineSuccess, setPipelineSuccess] = useState(null);
  const resultsRef = useRef(null);

  useEffect(() => { fetchStats(); }, []);

  const fetchStats = async () => {
    try {
      const res = await axios.get('/reports/stats');
      setStats(res.data);
    } catch (err) {
      console.error('Failed to load stats:', err);
    } finally {
      setLoading(false);
    }
  };

  const runPipeline = async () => {
    setGenerating(true);
    setPipelineMessage('');
    setPipelineSuccess(null);
    try {
      const res = await axios.post('/reports/generate');
      setPipelineMessage(res.data.message || 'AI Pipeline executed successfully! Reports are ready for download.');
      setPipelineSuccess(true);
      await fetchStats();
    } catch (err) {
      setPipelineMessage('Pipeline failed: ' + (err.response?.data?.message || err.message));
      setPipelineSuccess(false);
    } finally {
      setGenerating(false);
    }
  };

  const downloadReport = async (filename) => {
    try {
      const res = await axios.get(`/reports/download/${filename}`, { responseType: 'blob' });
      const url = window.URL.createObjectURL(new Blob([res.data]));
      const link = document.createElement('a');
      link.href = url;
      link.setAttribute('download', filename);
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
    } catch (err) {
      alert('Failed to download report. Ensure the pipeline has finished running.');
    }
  };

  if (loading) {
    return (
      <div style={{ minHeight: '100vh', display: 'flex', alignItems: 'center', justifyContent: 'center', background: P.pageBase }}>
        <div style={{ textAlign: 'center' }}>
          <div style={{
            width: 40, height: 40, border: `3px solid ${P.borderLight}`,
            borderTopColor: P.gold, borderRadius: '50%',
            animation: 'spin 0.8s linear infinite', margin: '0 auto 16px',
          }} />
          <div style={{ fontSize: 13, color: P.textMuted, fontWeight: 500 }}>Loading Intelligence Dashboard...</div>
        </div>
      </div>
    );
  }

  // Mock data for communities/recs (these will come from pipeline output in production)
  const mockCommunities = [
    { name: 'AI & Machine Learning', size: stats?.totalUsers ? Math.round(stats.totalUsers * 0.3) : 9, health: 85, interests: ['TensorFlow', 'Data Science', 'Deep Learning'] },
    { name: 'Web Development', size: stats?.totalUsers ? Math.round(stats.totalUsers * 0.25) : 7, health: 72, interests: ['React.js', 'Node.js', 'JavaScript'] },
    { name: 'Cyber Security', size: stats?.totalUsers ? Math.round(stats.totalUsers * 0.2) : 6, health: 68, interests: ['Penetration Testing', 'Ethical Hacking', 'Network Security'] },
    { name: 'Robotics & IoT', size: stats?.totalUsers ? Math.round(stats.totalUsers * 0.15) : 5, health: 55, interests: ['Arduino', 'Embedded Systems', 'Sensors'] },
    { name: 'Entrepreneurship', size: stats?.totalUsers ? Math.round(stats.totalUsers * 0.1) : 3, health: 42, interests: ['Startup', 'Product Management', 'Leadership'] },
  ];

  const mockRecommendations = [
    'Create an AI Research Lab with GPU compute access for student projects.',
    'Launch a Kaggle Competition Club with weekly leaderboard challenges.',
    'Organize a semester-long Web Development Bootcamp for skill building.',
    'Conduct a Capture the Flag (CTF) Competition each semester.',
    'Build a Robotics Innovation Lab with 3D printing and hardware tools.',
    'Launch a Startup Incubator with faculty mentors and seed funding.',
  ];

  const topInterests = stats?.interests?.slice(0, 5) || [];
  const topSkills = stats?.skills?.slice(0, 5) || [];

  return (
    <div style={{ minHeight: '100vh', background: P.pageBase, fontFamily: "-apple-system, BlinkMacSystemFont, 'Inter', sans-serif" }}>
      {/* ── CSS Keyframes ─────────────────────────────────── */}
      <style>{`
        @keyframes spin { to { transform: rotate(360deg); } }
        @keyframes pulse-dot { 0%, 100% { opacity: 1; } 50% { opacity: 0.4; } }
        @keyframes fadeInUp { from { opacity: 0; transform: translateY(16px); } to { opacity: 1; transform: translateY(0); } }
        @keyframes shimmer {
          0% { background-position: -200% 0; }
          100% { background-position: 200% 0; }
        }
        .skeleton-line {
          height: 12px; border-radius: 6px; margin-bottom: 10px;
          background: linear-gradient(90deg, rgba(255,255,255,0.04) 25%, rgba(255,255,255,0.08) 50%, rgba(255,255,255,0.04) 75%);
          background-size: 200% 100%;
          animation: shimmer 1.6s infinite;
        }
      `}</style>

      {/* ── HERO SECTION ──────────────────────────────────── */}
      <section style={{
        padding: '120px 48px 80px',
        maxWidth: 1320, margin: '0 auto',
        display: 'flex', alignItems: 'flex-start', gap: 64,
      }}>
        {/* Left Column */}
        <div style={{ flex: 1, paddingTop: 20 }}>
          {/* Live Badge */}
          <div style={{
            display: 'inline-flex', alignItems: 'center', gap: 8,
            padding: '6px 14px', borderRadius: 20,
            background: 'rgba(22,163,74,0.08)', border: '1px solid rgba(22,163,74,0.2)',
            marginBottom: 28,
          }}>
            <div style={{ width: 6, height: 6, borderRadius: '50%', background: P.green, boxShadow: `0 0 8px ${P.green}`, animation: 'pulse-dot 2s infinite' }} />
            <span style={{ fontSize: 11, fontWeight: 700, letterSpacing: '0.08em', textTransform: 'uppercase', color: P.green }}>
              Intelligence Platform Active
            </span>
          </div>

          {/* Three-Line Headline */}
          <div style={{ marginBottom: 28 }}>
            <div style={{ fontSize: 52, fontWeight: 900, letterSpacing: '-0.04em', lineHeight: 1.08, color: P.ink, textShadow: '0 1px 2px rgba(0,0,0,0.06)' }}>
              Transform Student Data
            </div>
            <div style={{ fontSize: 52, fontWeight: 900, letterSpacing: '-0.04em', lineHeight: 1.08, color: P.textLight }}>
              Into Community
            </div>
            <div style={{ fontSize: 52, fontWeight: 900, letterSpacing: '-0.04em', lineHeight: 1.08, color: P.gold, textShadow: '0 4px 16px rgba(245,197,24,0.3)' }}>
              Intelligence
            </div>
          </div>

          <p style={{ fontSize: 15, color: P.textMuted, lineHeight: 1.7, maxWidth: 480, marginBottom: 36 }}>
            AI-powered analysis that discovers student communities, surfaces collaboration opportunities, and generates actionable faculty insights — all from survey data.
          </p>

          <DarkBtn onClick={runPipeline} disabled={generating}>
            {generating ? (
              <>
                <div style={{ width: 16, height: 16, border: '2px solid rgba(255,255,255,0.2)', borderTopColor: P.gold, borderRadius: '50%', animation: 'spin 0.8s linear infinite' }} />
                Running Pipeline...
              </>
            ) : (
              <>
                <Play size={15} /> Run Intelligence Pipeline
              </>
            )}
          </DarkBtn>
        </div>

        {/* Right Column — Pipeline Status */}
        <PipelineCard running={generating} success={pipelineSuccess} />
      </section>

      {/* ── PIPELINE MESSAGE ──────────────────────────────── */}
      <AnimatePresence>
        {pipelineMessage && (
          <motion.div
            initial={{ opacity: 0, y: -10 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -10 }}
            style={{
              maxWidth: 1320, margin: '-40px auto 0', padding: '0 48px',
            }}
          >
            <div style={{
              display: 'flex', alignItems: 'center', gap: 12,
              padding: '16px 24px', borderRadius: 14,
              background: pipelineSuccess ? 'rgba(22,163,74,0.06)' : 'rgba(185,28,28,0.06)',
              border: `1px solid ${pipelineSuccess ? 'rgba(22,163,74,0.15)' : 'rgba(185,28,28,0.15)'}`,
            }}>
              {pipelineSuccess
                ? <CheckCircle size={18} color={P.green} />
                : <AlertCircle size={18} color={P.red} />}
              <span style={{ fontSize: 13, fontWeight: 500, color: pipelineSuccess ? P.green : P.red }}>
                {pipelineMessage}
              </span>
            </div>
          </motion.div>
        )}
      </AnimatePresence>

      {/* ── FACULTY METRICS RIBBON ────────────────────────── */}
      <section style={{
        background: P.surface, margin: '48px 0', padding: '8px 0',
        borderTop: `1px solid ${P.borderLight}`,
        borderBottom: `1px solid ${P.borderLight}`,
      }}>
        <div style={{
          maxWidth: 1320, margin: '0 auto', padding: '0 48px',
          display: 'flex', alignItems: 'center',
        }}>
          <StatPill label="Students Analyzed" value={stats?.totalUsers || 0} sub="Survey Participants" />
          <div style={{ width: 1, height: 40, background: P.borderLight }} />
          <StatPill label="Communities Found" value={mockCommunities.length} sub="Canonical Themes" />
          <div style={{ width: 1, height: 40, background: P.borderLight }} />
          <StatPill label="Survey Sessions" value={stats?.totalSessions || 0} sub="Completed" />
          <div style={{ width: 1, height: 40, background: P.borderLight }} />
          <StatPill label="Data Points" value={stats?.totalAnswers || 0} sub="Individual Answers" />

          {/* Gold Badge */}
          <div style={{ marginLeft: 'auto', display: 'flex', alignItems: 'center', gap: 12 }}>
            <div style={{
              width: 44, height: 44, borderRadius: 12,
              background: P.gold, display: 'flex', alignItems: 'center', justifyContent: 'center',
              boxShadow: '0 4px 14px rgba(245,197,24,0.35)',
            }}>
              <Award size={22} color={P.ink} />
            </div>
            <div>
              <div style={{ fontSize: 11, fontWeight: 700, letterSpacing: '0.06em', color: P.ink }}>AI-Powered</div>
              <div style={{ fontSize: 10, color: P.textMuted }}>Intelligence Platform</div>
            </div>
          </div>
        </div>
      </section>

      {/* ── COMMUNITY INTELLIGENCE ────────────────────────── */}
      <section style={{ maxWidth: 1320, margin: '0 auto', padding: '48px 48px' }}>
        <SectionLabel number="01" text="Community Intelligence" />
        <div style={{
          display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(260px, 1fr))',
          gap: 20,
        }}>
          {mockCommunities.map((c, i) => (
            <CommunityCard key={i} {...c} index={i} />
          ))}
        </div>
      </section>

      {/* ── DISTRIBUTION INSIGHTS ─────────────────────────── */}
      <section style={{ maxWidth: 1320, margin: '0 auto', padding: '16px 48px 48px' }}>
        <SectionLabel number="02" text="Distribution Insights" />
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 24 }}>
          {/* Interest Distribution */}
          <div style={{
            background: P.cardDark, borderRadius: 18, padding: 28,
            boxShadow: S.darkCard,
          }}>
            <div style={{ fontSize: 14, fontWeight: 700, color: '#fff', marginBottom: 20, letterSpacing: '-0.02em' }}>
              Top Student Interests
            </div>
            <div style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
              {topInterests.length > 0 ? topInterests.map((item, i) => (
                <div key={i} style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
                  <div style={{ width: 140, fontSize: 12, color: P.textLight, fontWeight: 500, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
                    {item.label}
                  </div>
                  <div style={{ flex: 1, height: 8, borderRadius: 4, background: 'rgba(255,255,255,0.06)', overflow: 'hidden' }}>
                    <div style={{
                      height: '100%',
                      width: `${Math.min(100, (parseInt(item.count) / (parseInt(topInterests[0]?.count) || 1)) * 100)}%`,
                      borderRadius: 4,
                      background: `linear-gradient(90deg, ${P.gold}, ${P.gold}cc)`,
                      boxShadow: S.goldGlow,
                      transition: 'width 0.6s ease',
                    }} />
                  </div>
                  <span style={{ fontSize: 12, fontWeight: 700, color: P.gold, minWidth: 24, textAlign: 'right' }}>{item.count}</span>
                </div>
              )) : (
                <div style={{ fontSize: 13, color: P.textMuted, padding: 16, textAlign: 'center' }}>Run pipeline to see interest data</div>
              )}
            </div>
          </div>

          {/* Department Distribution */}
          <div style={{
            background: P.cardDark, borderRadius: 18, padding: 28,
            boxShadow: S.darkCard,
          }}>
            <div style={{ fontSize: 14, fontWeight: 700, color: '#fff', marginBottom: 20, letterSpacing: '-0.02em' }}>
              Department Breakdown
            </div>
            <div style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
              {(stats?.departments || []).slice(0, 5).map((item, i) => (
                <div key={i} style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
                  <div style={{ width: 140, fontSize: 12, color: P.textLight, fontWeight: 500, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
                    {item.label}
                  </div>
                  <div style={{ flex: 1, height: 8, borderRadius: 4, background: 'rgba(255,255,255,0.06)', overflow: 'hidden' }}>
                    <div style={{
                      height: '100%',
                      width: `${Math.min(100, (parseInt(item.count) / (parseInt(stats?.departments?.[0]?.count) || 1)) * 100)}%`,
                      borderRadius: 4,
                      background: 'linear-gradient(90deg, #7c3aed, #a78bfa)',
                      transition: 'width 0.6s ease',
                    }} />
                  </div>
                  <span style={{ fontSize: 12, fontWeight: 700, color: '#a78bfa', minWidth: 24, textAlign: 'right' }}>{item.count}</span>
                </div>
              ))}
              {(!stats?.departments?.length) && (
                <div style={{ fontSize: 13, color: P.textMuted, padding: 16, textAlign: 'center' }}>Run pipeline to see department data</div>
              )}
            </div>
          </div>
        </div>
      </section>

      {/* ── FACULTY RECOMMENDATIONS ───────────────────────── */}
      <section style={{ maxWidth: 1320, margin: '0 auto', padding: '16px 48px 48px' }}>
        <SectionLabel number="03" text="Faculty Recommendations" />
        <div style={{
          background: P.cardDark, borderRadius: 22, padding: 36,
          boxShadow: S.darkCard,
        }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 12, marginBottom: 24 }}>
            <div style={{
              width: 38, height: 38, borderRadius: 10,
              background: 'rgba(245,197,24,0.12)',
              display: 'flex', alignItems: 'center', justifyContent: 'center',
            }}>
              <Sparkles size={18} color={P.gold} />
            </div>
            <div>
              <div style={{ fontSize: 15, fontWeight: 700, color: '#fff', letterSpacing: '-0.02em' }}>AI-Generated Action Items</div>
              <div style={{ fontSize: 11, color: P.textMuted }}>Based on community analysis and student interest patterns</div>
            </div>
          </div>
          <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 12 }}>
            {mockRecommendations.map((rec, i) => (
              <RecommendationCard key={i} rec={rec} index={i} />
            ))}
          </div>
        </div>
      </section>

      {/* ── REPORTS CENTER ────────────────────────────────── */}
      <section style={{ maxWidth: 1320, margin: '0 auto', padding: '16px 48px 80px' }}>
        <SectionLabel number="04" text="Reports Center" />
        <div style={{
          background: P.cardLight, borderRadius: 22, padding: 40,
          boxShadow: S.lightCard,
          border: `1px solid ${P.borderLight}`,
        }}>
          <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 32 }}>
            <div>
              <div style={{ fontSize: 20, fontWeight: 800, color: P.ink, letterSpacing: '-0.03em', marginBottom: 6 }}>
                Professional Reports
              </div>
              <div style={{ fontSize: 13, color: P.textMuted, lineHeight: 1.6, maxWidth: 520 }}>
                Download comprehensive reports generated by the STEMValley AI Clustering Agent. These contain detailed community analysis, collaboration metrics, and faculty recommendations.
              </div>
            </div>
            <div style={{
              width: 52, height: 52, borderRadius: 14,
              background: P.gold, display: 'flex', alignItems: 'center', justifyContent: 'center',
              boxShadow: S.yellowBtn,
            }}>
              <BarChart3 size={24} color={P.ink} />
            </div>
          </div>

          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: 16 }}>
            {[
              { label: 'Faculty Report', sub: 'PDF Document', desc: 'Full community analysis with charts', file: 'faculty_report.pdf', icon: FileText },
              { label: 'Cleaned Dataset', sub: 'Excel Spreadsheet', desc: 'Normalized student survey data', file: 'cleaned_data.xlsx', icon: Layers },
              { label: 'Presentation', sub: 'PowerPoint', desc: 'Board-ready slide deck', file: 'faculty_report.pptx', icon: BarChart3 },
            ].map((report, i) => {
              const Icon = report.icon;
              return (
                <div
                  key={i}
                  onClick={() => downloadReport(report.file)}
                  style={{
                    padding: 24, borderRadius: 16, cursor: 'pointer',
                    background: P.surface,
                    border: `1px solid ${P.borderLight}`,
                    transition: 'all 0.2s ease',
                  }}
                  onMouseEnter={e => {
                    e.currentTarget.style.borderColor = P.gold;
                    e.currentTarget.style.boxShadow = '0 4px 16px rgba(245,197,24,0.12)';
                    e.currentTarget.style.transform = 'translateY(-2px)';
                  }}
                  onMouseLeave={e => {
                    e.currentTarget.style.borderColor = P.borderLight;
                    e.currentTarget.style.boxShadow = 'none';
                    e.currentTarget.style.transform = 'translateY(0)';
                  }}
                >
                  <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 14 }}>
                    <div style={{
                      width: 38, height: 38, borderRadius: 10,
                      background: P.cardDark,
                      display: 'flex', alignItems: 'center', justifyContent: 'center',
                    }}>
                      <Icon size={16} color={P.gold} />
                    </div>
                    <Download size={16} color={P.textMuted} />
                  </div>
                  <div style={{ fontSize: 14, fontWeight: 700, color: P.ink, marginBottom: 2 }}>{report.label}</div>
                  <div style={{ fontSize: 11, fontWeight: 600, color: P.gold, marginBottom: 8, letterSpacing: '0.04em' }}>{report.sub}</div>
                  <div style={{ fontSize: 12, color: P.textMuted, lineHeight: 1.5 }}>{report.desc}</div>
                </div>
              );
            })}
          </div>
        </div>
      </section>

      {/* ── FOOTER ────────────────────────────────────────── */}
      <footer style={{
        borderTop: `1px solid ${P.borderLight}`,
        padding: '32px 48px',
        maxWidth: 1320, margin: '0 auto',
        display: 'flex', alignItems: 'center', justifyContent: 'space-between',
      }}>
        <div style={{ fontSize: 12, color: P.textMuted }}>
          STEMValley University Intelligence Platform &middot; {new Date().getFullYear()}
        </div>
        <div style={{ fontSize: 11, color: P.textLight }}>
          Powered by AI Community Discovery Engine
        </div>
      </footer>
    </div>
  );
};

export default DashboardPage;
