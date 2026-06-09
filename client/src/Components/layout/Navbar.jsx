import { useState, useContext } from 'react';
import { Link, useLocation } from 'react-router-dom';
import { AuthContext } from '../../context/AuthContext';
import { Layers, ArrowRight, LogOut } from 'lucide-react';

const Navbar = () => {
  const { user, logout } = useContext(AuthContext);
  const location = useLocation();

  // Atoms
  const DarkBtn = ({ children, onClick }) => {
    const [hovered, setHovered] = useState(false);
    return (
      <button
        onClick={onClick}
        onMouseEnter={() => setHovered(true)}
        onMouseLeave={() => setHovered(false)}
        style={{
          display: 'inline-flex', alignItems: 'center', gap: 8,
          padding: '8px 16px', borderRadius: 10,
          background: '#0D0D0D', color: '#fff',
          fontWeight: 600, fontSize: 13, border: 'none', cursor: 'pointer',
          boxShadow: hovered ? '0 8px 24px rgba(0,0,0,0.45), inset 0 1px 0 rgba(255,255,255,0.08)' : '0 4px 14px rgba(0,0,0,0.35), inset 0 1px 0 rgba(255,255,255,0.08)',
          transform: hovered ? 'translateY(-1px)' : 'translateY(0)',
          transition: 'all 0.2s cubic-bezier(0.4,0,0.2,1)',
        }}
      >
        {children}
      </button>
    );
  };

  return (
    <nav style={{
      position: 'sticky', top: 0, zIndex: 100,
      background: 'rgba(250, 250, 248, 0.85)', /* pageBase */
      backdropFilter: 'blur(16px)',
      borderBottom: '1px solid #E8E5DC',
      padding: '0 48px', height: 72,
      display: 'flex', alignItems: 'center', justifyContent: 'space-between',
      boxShadow: '0 2px 12px rgba(0,0,0,0.02)',
      fontFamily: "-apple-system, BlinkMacSystemFont, 'Inter', sans-serif"
    }}>
      {/* Brand */}
      <Link to="/" style={{ display: 'flex', alignItems: 'center', gap: 12, textDecoration: 'none' }}>
        <div style={{
          width: 32, height: 32, borderRadius: 8, background: '#111318',
          display: 'flex', alignItems: 'center', justifyContent: 'center',
          boxShadow: '0 2px 8px rgba(0,0,0,0.2)',
        }}>
          <Layers size={16} color="#F5C518" />
        </div>
        <span style={{ fontSize: 18, fontWeight: 800, color: '#0D0D0D', letterSpacing: '-0.02em' }}>
          STEMValley
        </span>
      </Link>

      {/* Links */}
      <div style={{ display: 'flex', alignItems: 'center', gap: 32 }}>
        {user && (
          <div style={{ display: 'flex', alignItems: 'center', gap: 24 }}>
            {user.role !== 'admin' && (
              <Link to="/survey" style={{
                fontSize: 14, fontWeight: 600, color: location.pathname === '/survey' ? '#0D0D0D' : '#888780',
                textDecoration: 'none', transition: 'color 0.2s'
              }}>
                Survey
              </Link>
            )}
            {user.role === 'admin' && (
              <Link to="/dashboard" style={{
                fontSize: 14, fontWeight: 600, color: location.pathname === '/dashboard' ? '#0D0D0D' : '#888780',
                textDecoration: 'none', transition: 'color 0.2s'
              }}>
                Dashboard
              </Link>
            )}
          </div>
        )}

        <div style={{ display: 'flex', alignItems: 'center', gap: 20 }}>
          <span style={{ fontSize: 13, fontWeight: 500, color: '#888780', cursor: 'pointer' }}>Help</span>
          {user ? (
            <DarkBtn onClick={logout}>
              Sign Out
              <div style={{
                width: 20, height: 20, borderRadius: '50%', background: '#F5C518',
                display: 'flex', alignItems: 'center', justifyContent: 'center', marginLeft: 4
              }}>
                <ArrowRight size={12} color="#0D0D0D" />
              </div>
            </DarkBtn>
          ) : (
            <Link to="/auth" style={{ textDecoration: 'none' }}>
              <DarkBtn>
                Sign In
                <div style={{
                  width: 20, height: 20, borderRadius: '50%', background: '#F5C518',
                  display: 'flex', alignItems: 'center', justifyContent: 'center', marginLeft: 4
                }}>
                  <ArrowRight size={12} color="#0D0D0D" />
                </div>
              </DarkBtn>
            </Link>
          )}
        </div>
      </div>
    </nav>
  );
};

export default Navbar;
