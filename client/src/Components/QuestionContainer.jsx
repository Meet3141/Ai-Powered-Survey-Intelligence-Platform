const QuestionContainer = ({ children, question, helperText }) => {
  return (
    <div className="w-full max-w-2xl mx-auto px-4 sm:px-6 py-8">
      {/* Question Title */}
      <h2 className="text-2xl sm:text-3xl font-bold text-white mb-2 leading-tight">
        {question}
      </h2>

      {/* Helper Text */}
      {helperText && (
        <p className="text-sm text-gray-400 mb-6">
          {helperText}
        </p>
      )}

      {/* Options Container */}
      <div className="space-y-3">
        {children}
      </div>
    </div>
  );
};

export default QuestionContainer;
