const SingleChoice = ({ options, selected, onChange }) => {
  return (
    <div className="space-y-3">
      {options.map((option) => (
        <button
          key={option}
          onClick={() => onChange(option)}
          className={`
            w-full p-4 text-left rounded-lg font-medium text-base
            transition-all duration-200 transform
            border-2 border-gray-600 hover:border-blue-400
            ${
              selected === option
                ? 'bg-blue-600 text-white border-blue-600 shadow-lg shadow-blue-600/50 scale-105'
                : 'bg-gray-800 text-gray-100 hover:bg-gray-700'
            }
            focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 focus:ring-offset-gray-900
            active:scale-95 cursor-pointer
          `}
        >
          <div className="flex items-center justify-between">
            <span>{option}</span>
            {selected === option && (
              <svg className="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
              </svg>
            )}
          </div>
        </button>
      ))}
    </div>
  );
};

export default SingleChoice;
