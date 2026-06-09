import { useState, useEffect } from 'react';
import axios from 'axios';
import ProgressBar from './ProgressBar';
import QuestionContainer from './QuestionContainer';
import SingleChoice from './SingleChoice';
import MultipleChoice from './MultipleChoice';
import RatingScale from './RatingScale';
import OpenEnded from './OpenEnded';

const API_BASE_URL = 'http://localhost:5000/api/survey';

const Survey = () => {
  // State Management
  const [currentQuestion, setCurrentQuestion] = useState(null);
  const [answers, setAnswers] = useState({});
  const [isCompleted, setIsCompleted] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [sessionId] = useState(crypto.randomUUID());
  const [questionCount, setQuestionCount] = useState(1);
  const [error, setError] = useState(null);

  // =====================
  // 1. INITIALIZATION - Fetch First Question
  // =====================
  useEffect(() => {
    const startSurvey = async () => {
      try {
        setIsLoading(true);
        console.log('📍 Fetching first question from backend...');
        
        const response = await axios.get(`${API_BASE_URL}/start`);
        
        console.log('✅ First Question Received:', response.data);
        setCurrentQuestion(response.data);
        setError(null);
      } catch (error) {
        console.error('❌ Error starting survey:', error);
        setError('Failed to start survey. Please check if backend is running on port 5000');
      } finally {
        setIsLoading(false);
      }
    };

    startSurvey();
  }, []);

  // =====================
  // 2. ANSWER SUBMISSION - Save & Get Next Question
  // =====================
  const handleSubmitAnswer = async (answer) => {
    if (!answer || answer.toString().trim() === '') {
      alert('Please provide an answer before proceeding.');
      return;
    }

    if (!currentQuestion) {
      alert('Question data is missing. Please refresh the page.');
      return;
    }

    try {
      setIsLoading(true);
      
      console.log('📤 Submitting Answer...');
      console.log('  - SessionId:', sessionId);
      console.log('  - QuestionId:', currentQuestion.id);
      console.log('  - Answer:', answer);
      console.log('  - QuestionCount:', questionCount);

      // API Call: POST /api/survey/next
      const response = await axios.post(`${API_BASE_URL}/next`, {
        sessionId,
        currentQuestionId: currentQuestion.id,
        answer: answer.toString(),
        questionCount,
      });

      console.log('✅ Response Received:', response.data);

      // Check if survey is completed
      if (response.data.completed) {
        console.log('🎉 Survey Completed!');
        setIsCompleted(true);
        return;
      }

      // Store answer
      setAnswers({
        ...answers,
        [currentQuestion.id]: answer,
      });

      // Get next question
      setCurrentQuestion(response.data);
      setQuestionCount(prev => prev + 1);
      setError(null);

    } catch (error) {
      console.error('❌ Error submitting answer:', error);
      setError('Failed to submit answer. Please check if backend is running.');
    } finally {
      setIsLoading(false);
    }
  };

  // =====================
  // 3. NAVIGATION
  // =====================
  const handleNext = () => {
    const currentAnswer = answers[currentQuestion.id];
    handleSubmitAnswer(currentAnswer);
  };

  const handlePrevious = () => {
    // Go back to previous question
    if (questionCount > 1) {
      // Note: This would require storing question history
      // For now, we'll show a notification
      alert('Previous button would require question history tracking');
    }
  };


  // =====================
  // 4. LOADING STATE
  // =====================
  if (isLoading && !currentQuestion) {
    return (
      <div className="w-full h-screen flex items-center justify-center bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900">
        <div className="text-center space-y-4">
          <div className="w-12 h-12 border-4 border-blue-500 border-t-transparent rounded-full animate-spin mx-auto"></div>
          <p className="text-gray-300 font-medium">Loading survey...</p>
        </div>
      </div>
    );
  }

  // =====================
  // 5. ERROR STATE
  // =====================
  if (error) {
    return (
      <div className="w-full h-screen flex items-center justify-center bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900 px-4">
        <div className="max-w-md w-full text-center space-y-4 bg-red-900 bg-opacity-30 border border-red-700 p-6 rounded-lg">
          <h2 className="text-2xl font-bold text-red-400">❌ Error</h2>
          <p className="text-red-200">{error}</p>
          <p className="text-sm text-red-300">Make sure:</p>
          <ul className="text-sm text-red-300 space-y-1 text-left">
            <li>✓ Backend is running: <code className="bg-red-950 px-2 py-1">npm start</code></li>
            <li>✓ Database is configured</li>
            <li>✓ .env file exists in server/</li>
          </ul>
          <button
            onClick={() => window.location.reload()}
            className="mt-4 px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 transition"
          >
            Retry
          </button>
        </div>
      </div>
    );
  }

  // =====================
  // 6. COMPLETION STATE
  // =====================
  if (isCompleted) {
    return (
      <div className="w-full h-screen flex items-center justify-center bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900 px-4">
        <div className="max-w-2xl w-full text-center space-y-6">
          <div className="flex justify-center">
            <div className="w-24 h-24 bg-gradient-to-br from-green-400 to-blue-500 rounded-full flex items-center justify-center animate-pulse">
              <svg className="w-12 h-12 text-white" fill="currentColor" viewBox="0 0 20 20">
                <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd" />
              </svg>
            </div>
          </div>
          <div className="space-y-2">
            <h2 className="text-4xl font-bold text-white">🎉 Thank You!</h2>
            <p className="text-xl text-gray-300 font-medium">Survey Completed Successfully</p>
          </div>
          <p className="text-gray-400 text-base leading-relaxed">
            All your responses have been saved to the database. Your insights help us better understand our community!
          </p>
          <div className="pt-4 space-y-2 text-sm text-gray-400">
            <p>📊 Session ID: <code className="bg-gray-800 px-2 py-1">{sessionId}</code></p>
            <p>❓ Questions Asked: <span className="font-semibold text-blue-400">{questionCount}</span></p>
          </div>
          <button
            onClick={() => window.location.reload()}
            className="mt-8 px-8 py-3 bg-gradient-to-r from-blue-500 to-blue-600 text-white font-bold rounded-lg hover:shadow-lg hover:shadow-blue-600/50 transition-all duration-200 transform hover:scale-105 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 focus:ring-offset-gray-900"
          >
            Start New Survey
          </button>
        </div>
      </div>
    );
  }

  // =====================
  // 7. MAIN SURVEY UI
  // =====================
  if (!currentQuestion) {
    return null;
  }

  return (
    <div className="w-full min-h-screen bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900 flex flex-col">
      {/* Progress Bar */}
      <ProgressBar current={questionCount} total={10} />

      {/* Main Content */}
      <div className="flex-1 flex items-center justify-center py-8">
        <div className="w-full">
          <QuestionContainer
            question={currentQuestion.question}
            helperText={currentQuestion.helperText || ''}
          >
            {/* SINGLE CHOICE QUESTION */}
            {currentQuestion.options && currentQuestion.options.length > 0 && !currentQuestion.type?.includes('multiple') && (
              <SingleChoice
                options={currentQuestion.options}
                selected={answers[currentQuestion.id] || ''}
                onChange={(value) => setAnswers({ ...answers, [currentQuestion.id]: value })}
              />
            )}

            {/* OPEN-ENDED QUESTION */}
            {!currentQuestion.options && (
              <OpenEnded
                value={answers[currentQuestion.id] || ''}
                onChange={(value) => setAnswers({ ...answers, [currentQuestion.id]: value })}
                placeholder="Enter your answer here..."
                maxLength={500}
              />
            )}
          </QuestionContainer>
        </div>
      </div>

      {/* Navigation Buttons */}
      <div className="w-full max-w-2xl mx-auto px-4 sm:px-6 pb-8">
        <div className="flex gap-4">
          {/* Previous Button */}
          <button
            onClick={handlePrevious}
            disabled={questionCount === 1}
            className={`
              flex-1 py-3 px-6 rounded-lg font-bold text-base
              transition-all duration-200 transform
              border-2 border-gray-600
              ${
                questionCount === 1
                  ? 'bg-gray-800 text-gray-500 cursor-not-allowed opacity-50'
                  : 'bg-gray-800 text-gray-100 hover:bg-gray-700 hover:border-gray-500 active:scale-95'
              }
              focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 focus:ring-offset-gray-900
            `}
          >
            ← Previous
          </button>

          {/* Next/Submit Button */}
          <button
            onClick={handleNext}
            disabled={isLoading || !answers[currentQuestion.id]}
            className={`
              flex-1 py-3 px-6 rounded-lg font-bold text-base text-white
              transition-all duration-200 transform
              border-2 border-blue-600
              ${
                isLoading || !answers[currentQuestion.id]
                  ? 'bg-blue-700 opacity-50 cursor-not-allowed'
                  : 'bg-gradient-to-r from-blue-600 to-blue-700 hover:shadow-lg hover:shadow-blue-600/50 active:scale-95'
              }
              focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 focus:ring-offset-gray-900
            `}
          >
            {isLoading ? 'Loading...' : 'Next →'}
          </button>
        </div>

        {/* Debug Info */}
        <div className="mt-4 text-xs text-gray-600 text-center">
          Q{questionCount} • Session: {sessionId.slice(0, 8)}...
        </div>
      </div>
    </div>
  );
};

export default Survey;
