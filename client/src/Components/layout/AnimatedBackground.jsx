import { memo } from 'react';

const AnimatedBackground = () => {
  return (
    <div className="animated-bg">
      <div className="orb orb-1"></div>
      <div className="orb orb-2"></div>
      <div className="orb orb-3"></div>
    </div>
  );
};

export default memo(AnimatedBackground);
