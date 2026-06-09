const ProgressBar = ({ current, total }) => {
  const percentage = (current / total) * 100;

  return (
    <div className="w-full max-w-2xl mx-auto px-4 sm:px-6 pt-6 pb-2">
      {/* Step Indicator */}
      <div className="flex items-center justify-between mb-4">
        <h3 className="text-sm font-medium text-gray-300">
          Question <span className="text-blue-400 font-semibold">{current}</span> of <span className="text-blue-400 font-semibold">{total}</span>
        </h3>
        <div className="text-xs text-gray-500 font-medium">
          {Math.round(percentage)}% Complete
        </div>
      </div>

      {/* Progress Bar */}
      <div className="h-2 bg-gray-700 rounded-full overflow-hidden shadow-inner">
        <div
          className="h-full bg-gradient-to-r from-blue-500 to-blue-600 rounded-full shadow-lg transition-all duration-500 ease-out"
          style={{ width: `${percentage}%` }}
        />
      </div>
    </div>
  );
};

export default ProgressBar;
