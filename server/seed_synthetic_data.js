import pool from './config/db.js';
import crypto from 'crypto';

// Synthetic Student Profiles to generate realistic clusters
const syntheticProfiles = [
  {
    department: 'Computer Science',
    interests: 'Artificial Intelligence, Machine Learning, Data Science',
    goals: 'Data Scientist, AI Engineer',
    skills: 'Python, TensorFlow, SQL',
    teamwork: 'I prefer working in agile teams with clear roles.',
    excitement: 'Building predictive models and analyzing large datasets.',
    dedication: '15-20 hours per week',
  },
  {
    department: 'Computer Science',
    interests: 'Web Development, Frontend, UI/UX',
    goals: 'Full Stack Developer, UX Engineer',
    skills: 'JavaScript, React, CSS, Node.js',
    teamwork: 'I love collaborative brainstorming and pair programming.',
    excitement: 'Creating beautiful and responsive user interfaces.',
    dedication: '10-15 hours per week',
  },
  {
    department: 'Mechanical Engineering',
    interests: 'Robotics, Automation, CAD Design',
    goals: 'Robotics Engineer, Product Designer',
    skills: 'SolidWorks, AutoCAD, C++',
    teamwork: 'I prefer hands-on group projects building physical prototypes.',
    excitement: 'Designing mechanisms and watching them come to life.',
    dedication: '10-12 hours per week',
  },
  {
    department: 'Biology',
    interests: 'Genetics, Bioinformatics, Research',
    goals: 'Research Scientist, Bioinformatician',
    skills: 'R, Python, Lab Research',
    teamwork: 'I work best in small research teams analyzing data.',
    excitement: 'Discovering patterns in genetic sequences.',
    dedication: '20+ hours per week',
  },
  {
    department: 'Business Administration',
    interests: 'Entrepreneurship, Marketing, Project Management',
    goals: 'Product Manager, Startup Founder',
    skills: 'Excel, Leadership, Public Speaking',
    teamwork: 'I enjoy leading teams and organizing project timelines.',
    excitement: 'Developing business strategies and launching products.',
    dedication: '5-10 hours per week',
  }
];

// Names for our fake users
const fakeNames = ["Alex Smith", "Jordan Lee", "Taylor Swift", "Chris Evans", "Morgan Freeman", "Casey Jones", "Jamie Foxx", "Riley Reid", "Avery Brooks", "Quinn Fabray"];

async function seedData() {
  console.log("🌱 Starting Synthetic Data Generation...");

  try {
    // We will generate 30 synthetic users (looping through profiles)
    let totalInserted = 0;

    for (let i = 0; i < 30; i++) {
      const sessionId = crypto.randomUUID();
      const profile = syntheticProfiles[i % syntheticProfiles.length];
      const name = fakeNames[i % fakeNames.length] + ` (${i})`;

      const responses = [
        { question_id: 1, question: "What is your full name?", answer: name },
        { question_id: 2, question: "What is your department?", answer: profile.department },
        { question_id: 3, question: "What are your main areas of interest?", answer: profile.interests },
        { question_id: 4, question: "What are your primary career goals?", answer: profile.goals },
        { question_id: 5, question: "Which technologies do you want to learn next?", answer: profile.skills },
        { question_id: 6, question: "Do you prefer working individually or in a team?", answer: profile.teamwork },
        { question_id: 7, question: "What kind of projects excite you the most?", answer: profile.excitement },
        { question_id: 8, question: "How much time can you dedicate to community projects weekly?", answer: profile.dedication }
      ];

      for (const res of responses) {
        await pool.query(
          `INSERT INTO survey_responses (session_id, question_id, question, answer) VALUES ($1, $2, $3, $4)`,
          [sessionId, res.question_id, res.question, res.answer]
        );
      }
      totalInserted++;
      console.log(`Generated synthetic student: ${name} [${profile.department}]`);
    }

    console.log(`\n✅ Successfully injected ${totalInserted} synthetic students into the database!`);
    console.log(`You can now run the AI Pipeline on the dashboard to cluster them!`);

  } catch (err) {
    console.error("❌ Error seeding synthetic data:", err);
  } finally {
    process.exit(0);
  }
}

seedData();
