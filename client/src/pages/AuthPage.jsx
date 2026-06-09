import { useState, useContext, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { AuthContext } from '../context/AuthContext';
import { Mail, Lock, User, Building, ArrowRight } from 'lucide-react';
import { motion } from 'framer-motion';

const AuthPage = () => {
  const [isLogin, setIsLogin] = useState(true);
  const [formData, setFormData] = useState({
    fullName: '',
    email: '',
    password: '',
    department: ''
  });
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const [focusedInput, setFocusedInput] = useState(null);
  
  const { login, signup, user } = useContext(AuthContext);
  const navigate = useNavigate();

  useEffect(() => {
    if (user) {
      if (user.role === 'admin') navigate('/dashboard');
      else navigate('/survey');
    }
  }, [user, navigate]);

  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
    setError('');
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setLoading(true);

    try {
      let res;
      if (isLogin) {
        res = await login(formData.email, formData.password);
      } else {
        res = await signup(formData.fullName, formData.email, formData.password, formData.department);
      }
      if (res && res.user && res.user.role === 'admin') navigate('/dashboard');
      else navigate('/survey');
    } catch (err) {
      setError(err.response?.data?.message || 'An error occurred. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  // SumUp palette tokens
  const P = {
    pageBase: '#FAFAF8',
    cardDark: '#111318',
    inputDark: '#1E2128',
    borderDark: '#2C2F38',
    gold: '#F5C518',
    textMuted: '#888780',
    textLight: '#C8C6C0',
    ink: '#0D0D0D',
    red: '#B91C1C',
  };

  const inputStyle = (name) => ({
    width: '100%', padding: '14px 16px 14px 44px',
    borderRadius: 12, background: P.inputDark,
    border: `1px solid ${focusedInput === name ? 'transparent' : P.borderDark}`,
    color: '#fff', fontSize: 14, fontFamily: 'inherit',
    boxShadow: focusedInput === name ? `inset 0 2px 4px rgba(0,0,0,0.2), 0 0 0 3px rgba(245,197,24,0.15)` : 'none',
    outline: 'none', transition: 'all 0.2s',
  });

  return (
    <div style={{
      minHeight: '100vh', background: P.pageBase,
      display: 'flex', alignItems: 'center', justifyContent: 'center',
      padding: '40px 24px', fontFamily: "-apple-system, BlinkMacSystemFont, 'Inter', sans-serif"
    }}>
      <motion.div 
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        style={{
          width: '100%', maxWidth: 440,
          background: P.cardDark, borderRadius: 22,
          padding: 48,
          boxShadow: '0 8px 40px rgba(0,0,0,0.35), 0 2px 8px rgba(0,0,0,0.2), inset 0 1px 0 rgba(255,255,255,0.06)'
        }}
      >
        <div style={{ textAlign: 'center', marginBottom: 32 }}>
          <h1 style={{ fontSize: 28, fontWeight: 800, color: '#fff', letterSpacing: '-0.03em', marginBottom: 8 }}>
            {isLogin ? 'Welcome Back' : 'Join STEMValley'}
          </h1>
          <p style={{ fontSize: 14, color: P.textMuted }}>
            {isLogin ? 'Sign in to access your intelligence dashboard' : 'Create an account to start your journey'}
          </p>
        </div>

        {error && (
          <div style={{
            padding: '12px 16px', borderRadius: 10, background: 'rgba(185,28,28,0.1)',
            border: `1px solid rgba(185,28,28,0.2)`, color: '#ef4444', fontSize: 13,
            textAlign: 'center', marginBottom: 24
          }}>
            {error}
          </div>
        )}

        <form onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'column', gap: 20 }}>
          {!isLogin && (
            <div>
              <label style={{ display: 'block', fontSize: 11, fontWeight: 700, letterSpacing: '0.08em', textTransform: 'uppercase', color: P.textMuted, marginBottom: 8 }}>Full Name</label>
              <div style={{ position: 'relative' }}>
                <User size={18} style={{ position: 'absolute', top: 15, left: 16, color: focusedInput === 'fullName' ? P.gold : P.textMuted, transition: 'color 0.2s' }} />
                <input
                  type="text" name="fullName" value={formData.fullName} onChange={handleChange}
                  onFocus={() => setFocusedInput('fullName')} onBlur={() => setFocusedInput(null)}
                  style={inputStyle('fullName')} placeholder="John Doe" required={!isLogin}
                />
              </div>
            </div>
          )}

          <div>
            <label style={{ display: 'block', fontSize: 11, fontWeight: 700, letterSpacing: '0.08em', textTransform: 'uppercase', color: P.textMuted, marginBottom: 8 }}>Email Address</label>
            <div style={{ position: 'relative' }}>
              <Mail size={18} style={{ position: 'absolute', top: 15, left: 16, color: focusedInput === 'email' ? P.gold : P.textMuted, transition: 'color 0.2s' }} />
              <input
                type="email" name="email" value={formData.email} onChange={handleChange}
                onFocus={() => setFocusedInput('email')} onBlur={() => setFocusedInput(null)}
                style={inputStyle('email')} placeholder="name@university.edu" required
              />
            </div>
          </div>

          {!isLogin && (
            <div>
              <label style={{ display: 'block', fontSize: 11, fontWeight: 700, letterSpacing: '0.08em', textTransform: 'uppercase', color: P.textMuted, marginBottom: 8 }}>Department</label>
              <div style={{ position: 'relative' }}>
                <Building size={18} style={{ position: 'absolute', top: 15, left: 16, color: focusedInput === 'department' ? P.gold : P.textMuted, transition: 'color 0.2s' }} />
                <input
                  type="text" name="department" value={formData.department} onChange={handleChange}
                  onFocus={() => setFocusedInput('department')} onBlur={() => setFocusedInput(null)}
                  style={inputStyle('department')} placeholder="Computer Science"
                />
              </div>
            </div>
          )}

          <div>
            <label style={{ display: 'block', fontSize: 11, fontWeight: 700, letterSpacing: '0.08em', textTransform: 'uppercase', color: P.textMuted, marginBottom: 8 }}>Password</label>
            <div style={{ position: 'relative' }}>
              <Lock size={18} style={{ position: 'absolute', top: 15, left: 16, color: focusedInput === 'password' ? P.gold : P.textMuted, transition: 'color 0.2s' }} />
              <input
                type="password" name="password" value={formData.password} onChange={handleChange}
                onFocus={() => setFocusedInput('password')} onBlur={() => setFocusedInput(null)}
                style={inputStyle('password')} placeholder="••••••••" required
              />
            </div>
          </div>

          <button
            type="submit"
            disabled={loading}
            onMouseEnter={e => {
              if (!loading) {
                e.currentTarget.style.transform = 'translateY(-1px)';
                e.currentTarget.style.boxShadow = '0 8px 24px rgba(245,197,24,0.55), 0 2px 6px rgba(0,0,0,0.2)';
              }
            }}
            onMouseLeave={e => {
              if (!loading) {
                e.currentTarget.style.transform = 'translateY(0)';
                e.currentTarget.style.boxShadow = '0 4px 14px rgba(245,197,24,0.45), 0 1px 3px rgba(0,0,0,0.15)';
              }
            }}
            style={{
              marginTop: 12, display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 10,
              width: '100%', padding: '14px', borderRadius: 12,
              background: P.gold, color: P.ink, fontSize: 15, fontWeight: 700,
              border: 'none', cursor: loading ? 'not-allowed' : 'pointer',
              boxShadow: '0 4px 14px rgba(245,197,24,0.45), 0 1px 3px rgba(0,0,0,0.15)',
              transition: 'all 0.2s', opacity: loading ? 0.7 : 1,
            }}
          >
            {loading ? 'Processing...' : (isLogin ? 'Sign In to Dashboard' : 'Create Account')}
            {!loading && <ArrowRight size={18} />}
          </button>
        </form>

        <div style={{ textAlign: 'center', marginTop: 32, fontSize: 13, color: P.textMuted }}>
          {isLogin ? "Don't have an account? " : "Already have an account? "}
          <button
            type="button"
            onClick={() => { setIsLogin(!isLogin); setError(''); }}
            style={{
              background: 'none', border: 'none', color: P.textLight, fontWeight: 600,
              cursor: 'pointer', fontFamily: 'inherit', padding: 0, textDecoration: 'underline'
            }}
          >
            {isLogin ? 'Sign Up' : 'Sign In'}
          </button>
        </div>
      </motion.div>
    </div>
  );
};

export default AuthPage;
