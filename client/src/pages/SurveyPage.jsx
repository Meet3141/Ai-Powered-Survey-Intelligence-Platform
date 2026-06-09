import { useState, useEffect, useContext } from 'react';
import axios from 'axios';
import { AuthContext } from '../context/AuthContext';
import { ArrowRight, ArrowLeft, CheckCircle2 } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';

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
  green: '#16A34A',
  borderLight: '#E8E5DC',
};

const SurveyPage = () => {
  const { user } = useContext(AuthContext);
  const [currentQuestion, setCurrentQuestion] = useState(null);
  const [answers, setAnswers] = useState({});
  const [isCompleted, setIsCompleted] = useState(false);
  const [isLoading, setIsLoading] = useState(true);
  const [sessionId] = useState(crypto.randomUUID());
  const [questionCount, setQuestionCount] = useState(1);
  const [error, setError] = useState(null);
  const [focusedInput, setFocusedInput] = useState(false);

  useEffect(() => {
    startSurvey();
  }, []);

  const startSurvey = async () => {
    try {
      setIsLoading(true);
      const res = await axios.get('/survey/start?userId=' + (user?.id || ''));
      setCurrentQuestion(res.data);
    } catch (err) {
      setError('Failed to start survey. Ensure backend is running.');
    } finally {
      setIsLoading(false);
    }
  };

  const handleNext = async () => {
    const answer = answers[currentQuestion.id];
    if (!answer) return;

    try {
      setIsLoading(true);
      const res = await axios.post('/survey/next', {
        sessionId,
        userId: user?.id,
        currentQuestionId: currentQuestion.id,
        answer: answer.toString(),
        questionCount
      });

      if (res.data.completed) {
        setIsCompleted(true);
      } else {
        setCurrentQuestion(res.data);
        setQuestionCount(prev => prev + 1);
      }
    } catch (err) {
      setError('Failed to submit answer.');
    } finally {
      setIsLoading(false);
    }
  };

  if (isLoading && !currentQuestion) {
    return (
      <div style={{ minHeight: '100vh', display: 'flex', alignItems: 'center', justifyContent: 'center', background: P.pageBase }}>
        <div style={{
          width: 40, height: 40, border: `3px solid ${P.borderLight}`,
          borderTopColor: P.gold, borderRadius: '50%',
          animation: 'spin 0.8s linear infinite',
        }} />
      </div>
    );
  }

  if (error) {
    return (
      <div style={{ minHeight: '100vh', display: 'flex', alignItems: 'center', justifyContent: 'center', background: P.pageBase }}>
        <div style={{ background: P.cardDark, padding: 40, borderRadius: 22, textAlign: 'center', maxWidth: 400 }}>
          <h2 style={{ color: P.red, marginBottom: 16 }}>Error</h2>
          <p style={{ color: P.textLight, fontSize: 14 }}>{error}</p>
          <button 
            onClick={() => window.location.reload()}
            style={{
              marginTop: 24, padding: '12px 24px', borderRadius: 12,
              background: P.ink, border: `1px solid ${P.borderDark}`, color: '#fff', cursor: 'pointer'
            }}
          >
            Retry
          </button>
        </div>
      </div>
    );
  }

  if (isCompleted) {
    return (
      <div style={{ minHeight: '100vh', display: 'flex', alignItems: 'center', justifyContent: 'center', background: P.pageBase }}>
        <motion.div 
          initial={{ scale: 0.9, opacity: 0 }} 
          animate={{ scale: 1, opacity: 1 }} 
          style={{
            background: P.cardDark, borderRadius: 22, padding: 48,
            boxShadow: '0 8px 40px rgba(0,0,0,0.35), 0 2px 8px rgba(0,0,0,0.2)',
            textAlign: 'center', maxWidth: 480, width: '100%'
          }}
        >
          <div style={{
            width: 64, height: 64, borderRadius: 16, background: 'rgba(22,163,74,0.15)',
            display: 'flex', alignItems: 'center', justifyContent: 'center', margin: '0 auto 24px'
          }}>
            <CheckCircle2 size={32} color={P.green} />
          </div>
          <h1 style={{ fontSize: 32, fontWeight: 800, color: '#fff', letterSpacing: '-0.03em', marginBottom: 12 }}>Awesome! 🎉</h1>
          <p style={{ color: P.textLight, fontSize: 15, lineHeight: 1.6, marginBottom: 32 }}>
            We've saved your responses. Our AI will analyze your profile and find your perfect community.
          </p>
          
          <div style={{
            display: 'flex', justifyContent: 'center', gap: 32,
            padding: '16px', borderRadius: 12, background: P.inputDark, marginBottom: 32
          }}>
            <div>
              <div style={{ fontSize: 11, fontWeight: 700, letterSpacing: '0.08em', textTransform: 'uppercase', color: P.textMuted }}>Questions</div>
              <div style={{ fontSize: 18, fontWeight: 700, color: P.gold }}>{questionCount}</div>
            </div>
            <div>
              <div style={{ fontSize: 11, fontWeight: 700, letterSpacing: '0.08em', textTransform: 'uppercase', color: P.textMuted }}>User</div>
              <div style={{ fontSize: 16, fontWeight: 600, color: '#fff' }}>{user?.fullName || 'Anonymous'}</div>
            </div>
          </div>
          
          <a href={user?.role === 'admin' ? "/dashboard" : "/"} style={{ textDecoration: 'none' }}>
            <button style={{
              display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 10,
              width: '100%', padding: '16px', borderRadius: 12,
              background: P.gold, color: P.ink, fontSize: 16, fontWeight: 700,
              border: 'none', cursor: 'pointer',
              boxShadow: '0 4px 14px rgba(245,197,24,0.45)', transition: 'all 0.2s'
            }}>
              {user?.role === 'admin' ? 'View Dashboard' : 'Back to Home'} <ArrowRight size={18} />
            </button>
          </a>
        </motion.div>
      </div>
    );
  }

  const progressPct = Math.round((questionCount / 10) * 100);

  return (
    <div style={{ minHeight: '100vh', background: P.pageBase, display: 'flex', flexDirection: 'column', fontFamily: "-apple-system, BlinkMacSystemFont, 'Inter', sans-serif" }}>
      
      {/* Top Progress Bar */}
      <div style={{ maxWidth: 720, width: '100%', margin: '0 auto', padding: '40px 24px 0' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 12 }}>
          <div style={{ fontSize: 12, fontWeight: 600, color: P.textMuted, letterSpacing: '0.04em' }}>
            QUESTION <span style={{ color: P.ink, fontWeight: 800, fontSize: 14 }}>{questionCount}</span> OF 10
          </div>
          <div style={{ fontSize: 12, fontWeight: 700, color: P.gold }}>{progressPct}%</div>
        </div>
        <div style={{ height: 6, borderRadius: 3, background: P.borderLight, overflow: 'hidden' }}>
          <div style={{
            height: '100%', width: `${progressPct}%`, background: P.gold,
            borderRadius: 3, transition: 'width 0.5s cubic-bezier(0.4, 0, 0.2, 1)',
            boxShadow: `0 0 10px rgba(245,197,24,0.6)`
          }} />
        </div>
      </div>

      {/* Main Content Area */}
      <div style={{ flex: 1, display: 'flex', alignItems: 'center', justifyContent: 'center', padding: '40px 24px', position: 'relative' }}>
        <AnimatePresence mode="wait">
          <motion.div 
            key={currentQuestion?.id}
            initial={{ opacity: 0, x: 20 }}
            animate={{ opacity: 1, x: 0 }}
            exit={{ opacity: 0, x: -20 }}
            transition={{ duration: 0.3 }}
            style={{
              background: P.cardDark, borderRadius: 22, padding: 48,
              boxShadow: '0 8px 40px rgba(0,0,0,0.35), 0 2px 8px rgba(0,0,0,0.2), inset 0 1px 0 rgba(255,255,255,0.06)',
              maxWidth: 720, width: '100%'
            }}
          >
            <h2 style={{ fontSize: 26, fontWeight: 800, color: '#fff', letterSpacing: '-0.02em', lineHeight: 1.3, marginBottom: 8 }}>
              {currentQuestion?.question}
            </h2>
            {currentQuestion?.helperText && (
              <p style={{ fontSize: 14, color: P.textMuted, marginBottom: 32 }}>{currentQuestion.helperText}</p>
            )}
            
            <div style={{ display: 'flex', flexDirection: 'column', gap: 12, marginTop: currentQuestion?.helperText ? 0 : 32 }}>
              {currentQuestion?.options ? (
                // Multiple Choice
                currentQuestion.options.map((opt, i) => {
                  const isSelected = answers[currentQuestion.id] === opt;
                  return (
                    <button 
                      key={i}
                      onClick={() => setAnswers({...answers, [currentQuestion.id]: opt})}
                      style={{
                        padding: '18px 24px', borderRadius: 14,
                        background: isSelected ? 'rgba(245,197,24,0.08)' : P.inputDark,
                        border: `1px solid ${isSelected ? P.gold : P.borderDark}`,
                        color: '#fff', fontSize: 15, fontWeight: 500, fontFamily: 'inherit',
                        cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'space-between',
                        textAlign: 'left', width: '100%',
                        boxShadow: isSelected ? `0 0 0 1px rgba(245,197,24,0.15), inset 0 2px 4px rgba(0,0,0,0.2)` : 'none',
                        transition: 'all 0.2s ease',
                      }}
                    >
                      <span>{opt}</span>
                      <div style={{
                        width: 22, height: 22, borderRadius: '50%',
                        border: `2px solid ${isSelected ? P.gold : P.borderDark}`,
                        background: isSelected ? P.gold : 'transparent',
                        display: 'flex', alignItems: 'center', justifyContent: 'center',
                        transition: 'all 0.2s', flexShrink: 0
                      }}>
                        {isSelected && <CheckCircle2 size={14} color={P.ink} />}
                      </div>
                    </button>
                  );
                })
              ) : (
                // Open Ended
                <textarea 
                  placeholder="Type your answer here..."
                  value={answers[currentQuestion?.id] || ''}
                  onChange={(e) => setAnswers({...answers, [currentQuestion.id]: e.target.value})}
                  onFocus={() => setFocusedInput(true)}
                  onBlur={() => setFocusedInput(false)}
                  autoFocus
                  style={{
                    width: '100%', minHeight: 140, padding: '20px 24px',
                    borderRadius: 14, background: P.inputDark,
                    border: `1px solid ${focusedInput ? 'transparent' : P.borderDark}`,
                    color: '#fff', fontSize: 15, fontFamily: 'inherit', lineHeight: 1.6,
                    outline: 'none', resize: 'vertical',
                    boxShadow: focusedInput ? `inset 0 2px 4px rgba(0,0,0,0.2), 0 0 0 3px rgba(245,197,24,0.15)` : 'none',
                    transition: 'all 0.2s',
                  }}
                />
              )}
            </div>
          </motion.div>
        </AnimatePresence>
      </div>

      {/* Bottom Navigation */}
      <div style={{
        padding: '24px 48px 48px', maxWidth: 720, width: '100%', margin: '0 auto',
        display: 'flex', justifyContent: 'space-between', alignItems: 'center'
      }}>
        <button disabled style={{
          display: 'flex', alignItems: 'center', gap: 8, padding: '12px 24px', borderRadius: 12,
          background: 'transparent', color: P.textLight, fontSize: 14, fontWeight: 600,
          border: 'none', cursor: 'not-allowed', opacity: 0.5
        }}>
          <ArrowLeft size={16} /> Previous
        </button>

        <button 
          onClick={handleNext}
          disabled={!answers[currentQuestion?.id] || isLoading}
          style={{
            display: 'flex', alignItems: 'center', gap: 8, padding: '14px 32px', borderRadius: 12,
            background: (!answers[currentQuestion?.id] || isLoading) ? P.borderDark : P.gold,
            color: (!answers[currentQuestion?.id] || isLoading) ? P.textMuted : P.ink,
            fontSize: 15, fontWeight: 700, fontFamily: 'inherit',
            border: 'none', cursor: (!answers[currentQuestion?.id] || isLoading) ? 'not-allowed' : 'pointer',
            boxShadow: (!answers[currentQuestion?.id] || isLoading) ? 'none' : '0 4px 14px rgba(245,197,24,0.45)',
            transition: 'all 0.2s',
          }}
        >
          {isLoading ? (
            <div style={{ width: 16, height: 16, border: '2px solid rgba(0,0,0,0.2)', borderTopColor: P.ink, borderRadius: '50%', animation: 'spin 0.8s linear infinite' }} />
          ) : (
            <>Next <ArrowRight size={18} /></>
          )}
        </button>
      </div>

      <style>{`
        @keyframes spin { to { transform: rotate(360deg); } }
      `}</style>
    </div>
  );
};

export default SurveyPage;
