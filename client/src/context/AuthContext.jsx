import { createContext, useState, useEffect } from 'react';
import axios from 'axios';

export const AuthContext = createContext();

export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);
  const [token, setToken] = useState(localStorage.getItem('stemvalley_token'));
  const [loading, setLoading] = useState(true);

  // Configure axios
  axios.defaults.baseURL = import.meta.env.VITE_API_URL || 'http://localhost:5000/api';
  
  useEffect(() => {
    if (token) {
      axios.defaults.headers.common['Authorization'] = `Bearer ${token}`;
      localStorage.setItem('stemvalley_token', token);
      fetchUser();
    } else {
      delete axios.defaults.headers.common['Authorization'];
      localStorage.removeItem('stemvalley_token');
      setUser(null);
      setLoading(false);
    }
  }, [token]);

  const fetchUser = async () => {
    try {
      const res = await axios.get('/auth/me');
      setUser(res.data);
    } catch (error) {
      console.error('Error fetching user:', error);
      setToken(null);
    } finally {
      setLoading(false);
    }
  };

  const login = async (email, password) => {
    const res = await axios.post('/auth/signin', { email, password });
    setToken(res.data.token);
    setUser(res.data.user);
    return res.data;
  };

  const signup = async (fullName, email, password, department) => {
    const res = await axios.post('/auth/signup', { fullName, email, password, department });
    setToken(res.data.token);
    setUser(res.data.user);
    return res.data;
  };

  const logout = () => {
    setToken(null);
  };

  return (
    <AuthContext.Provider value={{ user, token, loading, login, signup, logout }}>
      {children}
    </AuthContext.Provider>
  );
};
