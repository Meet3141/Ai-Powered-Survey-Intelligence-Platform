import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import { useContext } from 'react';
import { AuthProvider, AuthContext } from './context/AuthContext';
import AnimatedBackground from './Components/layout/AnimatedBackground';
import Navbar from './Components/layout/Navbar';
import LandingPage from './pages/LandingPage';
import AuthPage from './pages/AuthPage';
import SurveyPage from './pages/SurveyPage';
import DashboardPage from './pages/DashboardPage';

// Protected Route wrapper
const ProtectedRoute = ({ children }) => {
  const { user, loading } = useContext(AuthContext);
  
  if (loading) return <div className="page-loader"><div className="loader-spinner"></div></div>;
  if (!user) return <Navigate to="/auth" />;
  
  return children;
};

// Admin Route wrapper
const AdminRoute = ({ children }) => {
  const { user, loading } = useContext(AuthContext);
  
  if (loading) return <div className="page-loader"><div className="loader-spinner"></div></div>;
  if (!user) return <Navigate to="/auth" />;
  if (user.role !== 'admin') return <Navigate to="/survey" />;
  
  return children;
};

const AppRoutes = () => {
  const { loading } = useContext(AuthContext);

  if (loading) {
    return (
      <div className="page-loader">
        <div className="loader-spinner"></div>
        <div className="loader-text">Loading StemValley...</div>
      </div>
    );
  }

  return (
    <>
      <Navbar />
      <Routes>
        <Route path="/" element={<LandingPage />} />
        <Route path="/auth" element={<AuthPage />} />
        <Route 
          path="/survey" 
          element={
            <ProtectedRoute>
              <SurveyPage />
            </ProtectedRoute>
          } 
        />
        <Route 
          path="/dashboard" 
          element={
            <AdminRoute>
              <DashboardPage />
            </AdminRoute>
          } 
        />
      </Routes>
    </>
  );
};

function App() {
  return (
    <AuthProvider>
      <BrowserRouter>
        <AppRoutes />
      </BrowserRouter>
    </AuthProvider>
  );
}

export default App;