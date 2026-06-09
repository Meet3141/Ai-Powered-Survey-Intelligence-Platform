const RatingScale = ({ min = 1, max = 5, selected, onChange, labels }) => {
  const range = Array.from({ length: max - min + 1 }, (_, i) => min + i);

  return (
    <div className="space-y-6">
      {/* Rating Buttons */}
      <div className="flex justify-between gap-2">
        {range.map((rating) => (
          <button
            key={rating}
            onClick={() => onChange(rating)}
            className={`
              flex-1 py-4 px-2 rounded-lg font-bold text-lg
              transition-all duration-200 transform
              border-2 border-gray-600
              ${
                selected === rating
                  ? 'bg-blue-600 text-white border-blue-600 shadow-lg shadow-blue-600/50 scale-110'
                  : 'bg-gray-800 text-gray-300 hover:bg-gray-700 hover:border-blue-400'
              }
              focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 focus:ring-offset-gray-900
              active:scale-95 cursor-pointer
              hover:shadow-md
            `}
          >
            {rating}
          </button>
        ))}
      </div>

      {/* Labels */}
      {labels && (
        <div className="flex justify-between text-xs text-gray-500 px-1">
          <span>{labels.min}</span>
          <span>{labels.max}</span>
        </div>
      )}
    </div>
  );
};

export default RatingScale;
