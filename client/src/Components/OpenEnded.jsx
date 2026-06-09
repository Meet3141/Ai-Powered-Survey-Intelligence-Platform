const OpenEnded = ({ value, onChange, placeholder, maxLength = 500 }) => {
  const charCount = value.length;
  const remainingChars = maxLength - charCount;

  return (
    <div className="space-y-3">
      <textarea
        value={value}
        onChange={(e) => onChange(e.target.value.slice(0, maxLength))}
        placeholder={placeholder || "Type your answer here..."}
        className={`
          w-full p-4 rounded-lg bg-gray-800 text-white placeholder-gray-500
          border-2 border-gray-600 hover:border-blue-400
          transition-all duration-200
          focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 focus:ring-offset-gray-900
          focus:border-blue-600 focus:bg-gray-750
          resize-none
          min-h-[140px]
          font-medium text-base
        `}
        rows="5"
      />

      {/* Character Count */}
      <div className="flex justify-end items-center gap-2">
        <span className={`text-xs font-medium ${remainingChars < 50 ? 'text-orange-400' : 'text-gray-500'}`}>
          {charCount} / {maxLength}
        </span>
        {remainingChars < 50 && (
          <span className="text-xs text-orange-400 font-semibold">
            {remainingChars} left
          </span>
        )}
      </div>
    </div>
  );
};

export default OpenEnded;
