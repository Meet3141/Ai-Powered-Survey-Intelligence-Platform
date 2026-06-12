-- ==================================================
-- PHASE 1: CLEAN RESET
-- ==================================================
TRUNCATE TABLE survey_responses CASCADE;
DELETE FROM users WHERE role != 'admin';
ALTER SEQUENCE users_id_seq RESTART WITH 100;
ALTER SEQUENCE survey_responses_id_seq RESTART WITH 1;

-- ==================================================
-- PHASE 1.5: GENERATE SURVEY QUESTIONS
-- ==================================================

INSERT INTO survey_questions (sequence_no, question, question_type, options, category, trigger_value) VALUES 
(1, 'What''s your name?', 'open_ended', NULL, 'general', NULL),
(2, 'What is your department?', 'single_choice', '[\"Computer Science\", \"Information Technology\", \"Electronics\", \"Mechanical\"]', 'general', NULL),
(3, 'What are your main areas of interest?', 'multiple_choice', '[\"Web Development\", \"AI/ML\", \"Cybersecurity\", \"Data Science\", \"Cloud Computing\"]', 'general', NULL),
(4, 'How would you rate your current skill level in programming?', 'rating', NULL, 'general', NULL),
(5, 'What are your primary career goals?', 'multiple_choice', '[\"Software Engineer\", \"Data Scientist\", \"Product Manager\", \"Researcher\", \"Entrepreneur\"]', 'general', NULL),
(6, 'Which technologies do you want to learn next?', 'multiple_choice', '[\"React\", \"Python\", \"Node.js\", \"Docker\", \"AWS\", \"TensorFlow\"]', 'general', NULL),
(7, 'Do you prefer working individually or in a team?', 'single_choice', '[\"Individually\", \"In a team\", \"Depends on the project\"]', 'general', NULL),
(8, 'What kind of projects excite you the most?', 'open_ended', NULL, 'general', NULL),
(9, 'How much time can you dedicate to community projects weekly?', 'single_choice', '[\"1-2 hours\", \"3-5 hours\", \"5-10 hours\", \"10+ hours\"]', 'general', NULL),
(10, 'Any additional comments or expectations?', 'open_ended', NULL, 'general', NULL)
ON CONFLICT (sequence_no) DO NOTHING;


-- ==================================================
-- PHASE 3 & 4: GENERATE TEST STUDENTS AND RESPONSES
-- ==================================================

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (100, 'Alice Smith', 'alice100@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Information Technology', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8482f0f8-1dd4-4bd7-9253-a99caa3bb559', 100, 1, 'What''s your name?', 'Alice Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8482f0f8-1dd4-4bd7-9253-a99caa3bb559', 100, 2, 'What is your department?', 'Information Technology');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8482f0f8-1dd4-4bd7-9253-a99caa3bb559', 100, 3, 'What are your main areas of interest?', 'Data Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8482f0f8-1dd4-4bd7-9253-a99caa3bb559', 100, 4, 'How would you rate your current skill level in programming?', '5');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8482f0f8-1dd4-4bd7-9253-a99caa3bb559', 100, 5, 'What are your primary career goals?', 'Software Engineer');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8482f0f8-1dd4-4bd7-9253-a99caa3bb559', 100, 6, 'Which technologies do you want to learn next?', 'TensorFlow');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8482f0f8-1dd4-4bd7-9253-a99caa3bb559', 100, 7, 'Do you prefer working individually or in a team?', 'Individually');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8482f0f8-1dd4-4bd7-9253-a99caa3bb559', 100, 8, 'What kind of projects excite you the most?', 'Built a neural network');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8482f0f8-1dd4-4bd7-9253-a99caa3bb559', 100, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8482f0f8-1dd4-4bd7-9253-a99caa3bb559', 100, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (101, 'Bob Smith', 'bob101@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Computer Science', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e7b6d8a1-1adb-43e8-bbe9-2b5c42c1a9d6', 101, 1, 'What''s your name?', 'Bob Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e7b6d8a1-1adb-43e8-bbe9-2b5c42c1a9d6', 101, 2, 'What is your department?', 'Computer Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e7b6d8a1-1adb-43e8-bbe9-2b5c42c1a9d6', 101, 3, 'What are your main areas of interest?', 'Data Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e7b6d8a1-1adb-43e8-bbe9-2b5c42c1a9d6', 101, 4, 'How would you rate your current skill level in programming?', '4');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e7b6d8a1-1adb-43e8-bbe9-2b5c42c1a9d6', 101, 5, 'What are your primary career goals?', 'Data Scientist');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e7b6d8a1-1adb-43e8-bbe9-2b5c42c1a9d6', 101, 6, 'Which technologies do you want to learn next?', 'PyTorch');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e7b6d8a1-1adb-43e8-bbe9-2b5c42c1a9d6', 101, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e7b6d8a1-1adb-43e8-bbe9-2b5c42c1a9d6', 101, 8, 'What kind of projects excite you the most?', 'Predictive modeling');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e7b6d8a1-1adb-43e8-bbe9-2b5c42c1a9d6', 101, 9, 'How much time can you dedicate to community projects weekly?', '3-5 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e7b6d8a1-1adb-43e8-bbe9-2b5c42c1a9d6', 101, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (102, 'Charlie Smith', 'charlie102@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Information Technology', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2ccc7e77-1ea1-428f-8295-91661d953e11', 102, 1, 'What''s your name?', 'Charlie Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2ccc7e77-1ea1-428f-8295-91661d953e11', 102, 2, 'What is your department?', 'Information Technology');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2ccc7e77-1ea1-428f-8295-91661d953e11', 102, 3, 'What are your main areas of interest?', 'AI/ML');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2ccc7e77-1ea1-428f-8295-91661d953e11', 102, 4, 'How would you rate your current skill level in programming?', '4');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2ccc7e77-1ea1-428f-8295-91661d953e11', 102, 5, 'What are your primary career goals?', 'Data Scientist');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2ccc7e77-1ea1-428f-8295-91661d953e11', 102, 6, 'Which technologies do you want to learn next?', 'PyTorch');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2ccc7e77-1ea1-428f-8295-91661d953e11', 102, 7, 'Do you prefer working individually or in a team?', 'Individually');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2ccc7e77-1ea1-428f-8295-91661d953e11', 102, 8, 'What kind of projects excite you the most?', 'NLP chatbot');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2ccc7e77-1ea1-428f-8295-91661d953e11', 102, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2ccc7e77-1ea1-428f-8295-91661d953e11', 102, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (103, 'Diana Smith', 'diana103@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Information Technology', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2ef59f06-8b5e-480f-81b7-13d0758ccd8b', 103, 1, 'What''s your name?', 'Diana Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2ef59f06-8b5e-480f-81b7-13d0758ccd8b', 103, 2, 'What is your department?', 'Information Technology');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2ef59f06-8b5e-480f-81b7-13d0758ccd8b', 103, 3, 'What are your main areas of interest?', 'Data Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2ef59f06-8b5e-480f-81b7-13d0758ccd8b', 103, 4, 'How would you rate your current skill level in programming?', '4');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2ef59f06-8b5e-480f-81b7-13d0758ccd8b', 103, 5, 'What are your primary career goals?', 'Software Engineer');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2ef59f06-8b5e-480f-81b7-13d0758ccd8b', 103, 6, 'Which technologies do you want to learn next?', 'PyTorch');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2ef59f06-8b5e-480f-81b7-13d0758ccd8b', 103, 7, 'Do you prefer working individually or in a team?', 'Individually');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2ef59f06-8b5e-480f-81b7-13d0758ccd8b', 103, 8, 'What kind of projects excite you the most?', 'Predictive modeling');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2ef59f06-8b5e-480f-81b7-13d0758ccd8b', 103, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2ef59f06-8b5e-480f-81b7-13d0758ccd8b', 103, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (104, 'Ethan Smith', 'ethan104@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Information Technology', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b26263c7-e1e0-4732-940a-03f2e362b4b0', 104, 1, 'What''s your name?', 'Ethan Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b26263c7-e1e0-4732-940a-03f2e362b4b0', 104, 2, 'What is your department?', 'Information Technology');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b26263c7-e1e0-4732-940a-03f2e362b4b0', 104, 3, 'What are your main areas of interest?', 'AI/ML');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b26263c7-e1e0-4732-940a-03f2e362b4b0', 104, 4, 'How would you rate your current skill level in programming?', '4');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b26263c7-e1e0-4732-940a-03f2e362b4b0', 104, 5, 'What are your primary career goals?', 'Software Engineer');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b26263c7-e1e0-4732-940a-03f2e362b4b0', 104, 6, 'Which technologies do you want to learn next?', 'TensorFlow');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b26263c7-e1e0-4732-940a-03f2e362b4b0', 104, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b26263c7-e1e0-4732-940a-03f2e362b4b0', 104, 8, 'What kind of projects excite you the most?', 'Built a neural network');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b26263c7-e1e0-4732-940a-03f2e362b4b0', 104, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b26263c7-e1e0-4732-940a-03f2e362b4b0', 104, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (105, 'Fiona Smith', 'fiona105@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Information Technology', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cf2c82b9-1219-4447-bc69-60e0eb0cc5da', 105, 1, 'What''s your name?', 'Fiona Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cf2c82b9-1219-4447-bc69-60e0eb0cc5da', 105, 2, 'What is your department?', 'Information Technology');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cf2c82b9-1219-4447-bc69-60e0eb0cc5da', 105, 3, 'What are your main areas of interest?', 'AI/ML');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cf2c82b9-1219-4447-bc69-60e0eb0cc5da', 105, 4, 'How would you rate your current skill level in programming?', '4');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cf2c82b9-1219-4447-bc69-60e0eb0cc5da', 105, 5, 'What are your primary career goals?', 'Software Engineer');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cf2c82b9-1219-4447-bc69-60e0eb0cc5da', 105, 6, 'Which technologies do you want to learn next?', 'Python');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cf2c82b9-1219-4447-bc69-60e0eb0cc5da', 105, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cf2c82b9-1219-4447-bc69-60e0eb0cc5da', 105, 8, 'What kind of projects excite you the most?', 'Predictive modeling');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cf2c82b9-1219-4447-bc69-60e0eb0cc5da', 105, 9, 'How much time can you dedicate to community projects weekly?', '3-5 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cf2c82b9-1219-4447-bc69-60e0eb0cc5da', 105, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (106, 'George Smith', 'george106@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Information Technology', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('760ee4e5-93a5-40f8-aca4-1e236d4777cf', 106, 1, 'What''s your name?', 'George Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('760ee4e5-93a5-40f8-aca4-1e236d4777cf', 106, 2, 'What is your department?', 'Information Technology');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('760ee4e5-93a5-40f8-aca4-1e236d4777cf', 106, 3, 'What are your main areas of interest?', 'Data Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('760ee4e5-93a5-40f8-aca4-1e236d4777cf', 106, 4, 'How would you rate your current skill level in programming?', '5');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('760ee4e5-93a5-40f8-aca4-1e236d4777cf', 106, 5, 'What are your primary career goals?', 'Researcher');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('760ee4e5-93a5-40f8-aca4-1e236d4777cf', 106, 6, 'Which technologies do you want to learn next?', 'PyTorch');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('760ee4e5-93a5-40f8-aca4-1e236d4777cf', 106, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('760ee4e5-93a5-40f8-aca4-1e236d4777cf', 106, 8, 'What kind of projects excite you the most?', 'NLP chatbot');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('760ee4e5-93a5-40f8-aca4-1e236d4777cf', 106, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('760ee4e5-93a5-40f8-aca4-1e236d4777cf', 106, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (107, 'Hannah Smith', 'hannah107@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Information Technology', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('1847ed8c-00d4-4bbd-acc1-da9988bec86e', 107, 1, 'What''s your name?', 'Hannah Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('1847ed8c-00d4-4bbd-acc1-da9988bec86e', 107, 2, 'What is your department?', 'Information Technology');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('1847ed8c-00d4-4bbd-acc1-da9988bec86e', 107, 3, 'What are your main areas of interest?', 'Data Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('1847ed8c-00d4-4bbd-acc1-da9988bec86e', 107, 4, 'How would you rate your current skill level in programming?', '3');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('1847ed8c-00d4-4bbd-acc1-da9988bec86e', 107, 5, 'What are your primary career goals?', 'Researcher');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('1847ed8c-00d4-4bbd-acc1-da9988bec86e', 107, 6, 'Which technologies do you want to learn next?', 'Python');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('1847ed8c-00d4-4bbd-acc1-da9988bec86e', 107, 7, 'Do you prefer working individually or in a team?', 'Individually');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('1847ed8c-00d4-4bbd-acc1-da9988bec86e', 107, 8, 'What kind of projects excite you the most?', 'NLP chatbot');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('1847ed8c-00d4-4bbd-acc1-da9988bec86e', 107, 9, 'How much time can you dedicate to community projects weekly?', '3-5 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('1847ed8c-00d4-4bbd-acc1-da9988bec86e', 107, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (108, 'Ian Smith', 'ian108@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Information Technology', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('6d7c6729-2403-4b72-a332-32fa6b1aaa76', 108, 1, 'What''s your name?', 'Ian Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('6d7c6729-2403-4b72-a332-32fa6b1aaa76', 108, 2, 'What is your department?', 'Information Technology');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('6d7c6729-2403-4b72-a332-32fa6b1aaa76', 108, 3, 'What are your main areas of interest?', 'Web Development');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('6d7c6729-2403-4b72-a332-32fa6b1aaa76', 108, 4, 'How would you rate your current skill level in programming?', '4');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('6d7c6729-2403-4b72-a332-32fa6b1aaa76', 108, 5, 'What are your primary career goals?', 'Product Manager');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('6d7c6729-2403-4b72-a332-32fa6b1aaa76', 108, 6, 'Which technologies do you want to learn next?', 'React');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('6d7c6729-2403-4b72-a332-32fa6b1aaa76', 108, 7, 'Do you prefer working individually or in a team?', 'Individually');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('6d7c6729-2403-4b72-a332-32fa6b1aaa76', 108, 8, 'What kind of projects excite you the most?', 'Full stack e-commerce app');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('6d7c6729-2403-4b72-a332-32fa6b1aaa76', 108, 9, 'How much time can you dedicate to community projects weekly?', '3-5 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('6d7c6729-2403-4b72-a332-32fa6b1aaa76', 108, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (109, 'Julia Smith', 'julia109@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Computer Science', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8e236e19-f30d-4ce6-9be5-94dd4faa45c0', 109, 1, 'What''s your name?', 'Julia Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8e236e19-f30d-4ce6-9be5-94dd4faa45c0', 109, 2, 'What is your department?', 'Computer Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8e236e19-f30d-4ce6-9be5-94dd4faa45c0', 109, 3, 'What are your main areas of interest?', 'Web Development');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8e236e19-f30d-4ce6-9be5-94dd4faa45c0', 109, 4, 'How would you rate your current skill level in programming?', '5');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8e236e19-f30d-4ce6-9be5-94dd4faa45c0', 109, 5, 'What are your primary career goals?', 'Software Engineer');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8e236e19-f30d-4ce6-9be5-94dd4faa45c0', 109, 6, 'Which technologies do you want to learn next?', 'Node.js');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8e236e19-f30d-4ce6-9be5-94dd4faa45c0', 109, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8e236e19-f30d-4ce6-9be5-94dd4faa45c0', 109, 8, 'What kind of projects excite you the most?', 'Full stack e-commerce app');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8e236e19-f30d-4ce6-9be5-94dd4faa45c0', 109, 9, 'How much time can you dedicate to community projects weekly?', '3-5 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8e236e19-f30d-4ce6-9be5-94dd4faa45c0', 109, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (110, 'Kevin Smith', 'kevin110@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Computer Science', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3c022a57-e4b6-4000-bd9e-582493f47395', 110, 1, 'What''s your name?', 'Kevin Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3c022a57-e4b6-4000-bd9e-582493f47395', 110, 2, 'What is your department?', 'Computer Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3c022a57-e4b6-4000-bd9e-582493f47395', 110, 3, 'What are your main areas of interest?', 'Cloud Computing');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3c022a57-e4b6-4000-bd9e-582493f47395', 110, 4, 'How would you rate your current skill level in programming?', '5');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3c022a57-e4b6-4000-bd9e-582493f47395', 110, 5, 'What are your primary career goals?', 'Software Engineer');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3c022a57-e4b6-4000-bd9e-582493f47395', 110, 6, 'Which technologies do you want to learn next?', 'Node.js');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3c022a57-e4b6-4000-bd9e-582493f47395', 110, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3c022a57-e4b6-4000-bd9e-582493f47395', 110, 8, 'What kind of projects excite you the most?', 'Full stack e-commerce app');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3c022a57-e4b6-4000-bd9e-582493f47395', 110, 9, 'How much time can you dedicate to community projects weekly?', '3-5 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3c022a57-e4b6-4000-bd9e-582493f47395', 110, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (111, 'Laura Smith', 'laura111@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Information Technology', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('6d647e39-99a0-4714-bff6-1828cdcfc751', 111, 1, 'What''s your name?', 'Laura Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('6d647e39-99a0-4714-bff6-1828cdcfc751', 111, 2, 'What is your department?', 'Information Technology');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('6d647e39-99a0-4714-bff6-1828cdcfc751', 111, 3, 'What are your main areas of interest?', 'Cloud Computing');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('6d647e39-99a0-4714-bff6-1828cdcfc751', 111, 4, 'How would you rate your current skill level in programming?', '3');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('6d647e39-99a0-4714-bff6-1828cdcfc751', 111, 5, 'What are your primary career goals?', 'Software Engineer');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('6d647e39-99a0-4714-bff6-1828cdcfc751', 111, 6, 'Which technologies do you want to learn next?', 'Node.js');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('6d647e39-99a0-4714-bff6-1828cdcfc751', 111, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('6d647e39-99a0-4714-bff6-1828cdcfc751', 111, 8, 'What kind of projects excite you the most?', 'REST API dashboard');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('6d647e39-99a0-4714-bff6-1828cdcfc751', 111, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('6d647e39-99a0-4714-bff6-1828cdcfc751', 111, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (112, 'Mike Smith', 'mike112@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Computer Science', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('495090f6-c26e-462f-a956-fbc13137d994', 112, 1, 'What''s your name?', 'Mike Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('495090f6-c26e-462f-a956-fbc13137d994', 112, 2, 'What is your department?', 'Computer Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('495090f6-c26e-462f-a956-fbc13137d994', 112, 3, 'What are your main areas of interest?', 'Web Development');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('495090f6-c26e-462f-a956-fbc13137d994', 112, 4, 'How would you rate your current skill level in programming?', '3');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('495090f6-c26e-462f-a956-fbc13137d994', 112, 5, 'What are your primary career goals?', 'Software Engineer');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('495090f6-c26e-462f-a956-fbc13137d994', 112, 6, 'Which technologies do you want to learn next?', 'React');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('495090f6-c26e-462f-a956-fbc13137d994', 112, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('495090f6-c26e-462f-a956-fbc13137d994', 112, 8, 'What kind of projects excite you the most?', 'Full stack e-commerce app');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('495090f6-c26e-462f-a956-fbc13137d994', 112, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('495090f6-c26e-462f-a956-fbc13137d994', 112, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (113, 'Nina Smith', 'nina113@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Computer Science', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('f4c7a2ab-05a3-43d7-a9bd-3ed041361383', 113, 1, 'What''s your name?', 'Nina Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('f4c7a2ab-05a3-43d7-a9bd-3ed041361383', 113, 2, 'What is your department?', 'Computer Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('f4c7a2ab-05a3-43d7-a9bd-3ed041361383', 113, 3, 'What are your main areas of interest?', 'Web Development');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('f4c7a2ab-05a3-43d7-a9bd-3ed041361383', 113, 4, 'How would you rate your current skill level in programming?', '5');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('f4c7a2ab-05a3-43d7-a9bd-3ed041361383', 113, 5, 'What are your primary career goals?', 'Software Engineer');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('f4c7a2ab-05a3-43d7-a9bd-3ed041361383', 113, 6, 'Which technologies do you want to learn next?', 'AWS');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('f4c7a2ab-05a3-43d7-a9bd-3ed041361383', 113, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('f4c7a2ab-05a3-43d7-a9bd-3ed041361383', 113, 8, 'What kind of projects excite you the most?', 'Full stack e-commerce app');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('f4c7a2ab-05a3-43d7-a9bd-3ed041361383', 113, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('f4c7a2ab-05a3-43d7-a9bd-3ed041361383', 113, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (114, 'Oscar Smith', 'oscar114@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Computer Science', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('4538e032-fd9f-4c98-860c-7d15fbda9724', 114, 1, 'What''s your name?', 'Oscar Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('4538e032-fd9f-4c98-860c-7d15fbda9724', 114, 2, 'What is your department?', 'Computer Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('4538e032-fd9f-4c98-860c-7d15fbda9724', 114, 3, 'What are your main areas of interest?', 'Web Development');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('4538e032-fd9f-4c98-860c-7d15fbda9724', 114, 4, 'How would you rate your current skill level in programming?', '5');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('4538e032-fd9f-4c98-860c-7d15fbda9724', 114, 5, 'What are your primary career goals?', 'Software Engineer');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('4538e032-fd9f-4c98-860c-7d15fbda9724', 114, 6, 'Which technologies do you want to learn next?', 'Node.js');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('4538e032-fd9f-4c98-860c-7d15fbda9724', 114, 7, 'Do you prefer working individually or in a team?', 'Individually');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('4538e032-fd9f-4c98-860c-7d15fbda9724', 114, 8, 'What kind of projects excite you the most?', 'REST API dashboard');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('4538e032-fd9f-4c98-860c-7d15fbda9724', 114, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('4538e032-fd9f-4c98-860c-7d15fbda9724', 114, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (115, 'Paula Smith', 'paula115@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Electronics', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2e1650b4-02c7-49c6-8a4d-3946d090bc99', 115, 1, 'What''s your name?', 'Paula Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2e1650b4-02c7-49c6-8a4d-3946d090bc99', 115, 2, 'What is your department?', 'Electronics');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2e1650b4-02c7-49c6-8a4d-3946d090bc99', 115, 3, 'What are your main areas of interest?', 'IoT');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2e1650b4-02c7-49c6-8a4d-3946d090bc99', 115, 4, 'How would you rate your current skill level in programming?', '3');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2e1650b4-02c7-49c6-8a4d-3946d090bc99', 115, 5, 'What are your primary career goals?', 'Hardware Engineer');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2e1650b4-02c7-49c6-8a4d-3946d090bc99', 115, 6, 'Which technologies do you want to learn next?', 'Arduino');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2e1650b4-02c7-49c6-8a4d-3946d090bc99', 115, 7, 'Do you prefer working individually or in a team?', 'Individually');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2e1650b4-02c7-49c6-8a4d-3946d090bc99', 115, 8, 'What kind of projects excite you the most?', 'Autonomous drone');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2e1650b4-02c7-49c6-8a4d-3946d090bc99', 115, 9, 'How much time can you dedicate to community projects weekly?', '3-5 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2e1650b4-02c7-49c6-8a4d-3946d090bc99', 115, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (116, 'Quinn Smith', 'quinn116@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Mechanical', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e97edd1e-00da-4daf-a2a6-86a35a012a9f', 116, 1, 'What''s your name?', 'Quinn Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e97edd1e-00da-4daf-a2a6-86a35a012a9f', 116, 2, 'What is your department?', 'Mechanical');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e97edd1e-00da-4daf-a2a6-86a35a012a9f', 116, 3, 'What are your main areas of interest?', 'IoT');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e97edd1e-00da-4daf-a2a6-86a35a012a9f', 116, 4, 'How would you rate your current skill level in programming?', '5');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e97edd1e-00da-4daf-a2a6-86a35a012a9f', 116, 5, 'What are your primary career goals?', 'Hardware Engineer');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e97edd1e-00da-4daf-a2a6-86a35a012a9f', 116, 6, 'Which technologies do you want to learn next?', 'C++');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e97edd1e-00da-4daf-a2a6-86a35a012a9f', 116, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e97edd1e-00da-4daf-a2a6-86a35a012a9f', 116, 8, 'What kind of projects excite you the most?', 'Line-following robot');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e97edd1e-00da-4daf-a2a6-86a35a012a9f', 116, 9, 'How much time can you dedicate to community projects weekly?', '3-5 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e97edd1e-00da-4daf-a2a6-86a35a012a9f', 116, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (117, 'Rachel Smith', 'rachel117@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Electronics', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('0c529f75-0f6b-4b1b-9183-708414dd73cf', 117, 1, 'What''s your name?', 'Rachel Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('0c529f75-0f6b-4b1b-9183-708414dd73cf', 117, 2, 'What is your department?', 'Electronics');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('0c529f75-0f6b-4b1b-9183-708414dd73cf', 117, 3, 'What are your main areas of interest?', 'IoT');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('0c529f75-0f6b-4b1b-9183-708414dd73cf', 117, 4, 'How would you rate your current skill level in programming?', '5');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('0c529f75-0f6b-4b1b-9183-708414dd73cf', 117, 5, 'What are your primary career goals?', 'Hardware Engineer');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('0c529f75-0f6b-4b1b-9183-708414dd73cf', 117, 6, 'Which technologies do you want to learn next?', 'Arduino');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('0c529f75-0f6b-4b1b-9183-708414dd73cf', 117, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('0c529f75-0f6b-4b1b-9183-708414dd73cf', 117, 8, 'What kind of projects excite you the most?', 'Autonomous drone');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('0c529f75-0f6b-4b1b-9183-708414dd73cf', 117, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('0c529f75-0f6b-4b1b-9183-708414dd73cf', 117, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (118, 'Steve Smith', 'steve118@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Mechanical', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7ca5a2f4-208a-4262-a1bf-fd23cc76d3ba', 118, 1, 'What''s your name?', 'Steve Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7ca5a2f4-208a-4262-a1bf-fd23cc76d3ba', 118, 2, 'What is your department?', 'Mechanical');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7ca5a2f4-208a-4262-a1bf-fd23cc76d3ba', 118, 3, 'What are your main areas of interest?', 'IoT');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7ca5a2f4-208a-4262-a1bf-fd23cc76d3ba', 118, 4, 'How would you rate your current skill level in programming?', '3');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7ca5a2f4-208a-4262-a1bf-fd23cc76d3ba', 118, 5, 'What are your primary career goals?', 'Robotics Engineer');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7ca5a2f4-208a-4262-a1bf-fd23cc76d3ba', 118, 6, 'Which technologies do you want to learn next?', 'Arduino');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7ca5a2f4-208a-4262-a1bf-fd23cc76d3ba', 118, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7ca5a2f4-208a-4262-a1bf-fd23cc76d3ba', 118, 8, 'What kind of projects excite you the most?', 'Smart home IoT');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7ca5a2f4-208a-4262-a1bf-fd23cc76d3ba', 118, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7ca5a2f4-208a-4262-a1bf-fd23cc76d3ba', 118, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (119, 'Tina Smith', 'tina119@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Mechanical', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('d1dab099-a360-47c8-832a-1b8a661b5ff3', 119, 1, 'What''s your name?', 'Tina Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('d1dab099-a360-47c8-832a-1b8a661b5ff3', 119, 2, 'What is your department?', 'Mechanical');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('d1dab099-a360-47c8-832a-1b8a661b5ff3', 119, 3, 'What are your main areas of interest?', 'Robotics');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('d1dab099-a360-47c8-832a-1b8a661b5ff3', 119, 4, 'How would you rate your current skill level in programming?', '3');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('d1dab099-a360-47c8-832a-1b8a661b5ff3', 119, 5, 'What are your primary career goals?', 'Robotics Engineer');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('d1dab099-a360-47c8-832a-1b8a661b5ff3', 119, 6, 'Which technologies do you want to learn next?', 'C++');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('d1dab099-a360-47c8-832a-1b8a661b5ff3', 119, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('d1dab099-a360-47c8-832a-1b8a661b5ff3', 119, 8, 'What kind of projects excite you the most?', 'Line-following robot');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('d1dab099-a360-47c8-832a-1b8a661b5ff3', 119, 9, 'How much time can you dedicate to community projects weekly?', '3-5 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('d1dab099-a360-47c8-832a-1b8a661b5ff3', 119, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (120, 'Uma Smith', 'uma120@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Mechanical', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('34132b70-f4c7-4d27-87d7-edca052471b2', 120, 1, 'What''s your name?', 'Uma Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('34132b70-f4c7-4d27-87d7-edca052471b2', 120, 2, 'What is your department?', 'Mechanical');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('34132b70-f4c7-4d27-87d7-edca052471b2', 120, 3, 'What are your main areas of interest?', 'IoT');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('34132b70-f4c7-4d27-87d7-edca052471b2', 120, 4, 'How would you rate your current skill level in programming?', '3');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('34132b70-f4c7-4d27-87d7-edca052471b2', 120, 5, 'What are your primary career goals?', 'Robotics Engineer');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('34132b70-f4c7-4d27-87d7-edca052471b2', 120, 6, 'Which technologies do you want to learn next?', 'Arduino');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('34132b70-f4c7-4d27-87d7-edca052471b2', 120, 7, 'Do you prefer working individually or in a team?', 'Individually');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('34132b70-f4c7-4d27-87d7-edca052471b2', 120, 8, 'What kind of projects excite you the most?', 'Autonomous drone');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('34132b70-f4c7-4d27-87d7-edca052471b2', 120, 9, 'How much time can you dedicate to community projects weekly?', '3-5 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('34132b70-f4c7-4d27-87d7-edca052471b2', 120, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (121, 'Victor Smith', 'victor121@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Computer Science', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b5e3c0b5-6877-4e73-b3af-9bb7c42426c0', 121, 1, 'What''s your name?', 'Victor Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b5e3c0b5-6877-4e73-b3af-9bb7c42426c0', 121, 2, 'What is your department?', 'Computer Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b5e3c0b5-6877-4e73-b3af-9bb7c42426c0', 121, 3, 'What are your main areas of interest?', 'Startups');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b5e3c0b5-6877-4e73-b3af-9bb7c42426c0', 121, 4, 'How would you rate your current skill level in programming?', '5');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b5e3c0b5-6877-4e73-b3af-9bb7c42426c0', 121, 5, 'What are your primary career goals?', 'Entrepreneur');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b5e3c0b5-6877-4e73-b3af-9bb7c42426c0', 121, 6, 'Which technologies do you want to learn next?', 'Figma');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b5e3c0b5-6877-4e73-b3af-9bb7c42426c0', 121, 7, 'Do you prefer working individually or in a team?', 'Individually');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b5e3c0b5-6877-4e73-b3af-9bb7c42426c0', 121, 8, 'What kind of projects excite you the most?', 'Startup pitch deck');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b5e3c0b5-6877-4e73-b3af-9bb7c42426c0', 121, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b5e3c0b5-6877-4e73-b3af-9bb7c42426c0', 121, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (122, 'Wendy Smith', 'wendy122@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Computer Science', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('bfe380cc-159f-4ee2-9495-a4e8b1c28f2a', 122, 1, 'What''s your name?', 'Wendy Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('bfe380cc-159f-4ee2-9495-a4e8b1c28f2a', 122, 2, 'What is your department?', 'Computer Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('bfe380cc-159f-4ee2-9495-a4e8b1c28f2a', 122, 3, 'What are your main areas of interest?', 'FinTech');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('bfe380cc-159f-4ee2-9495-a4e8b1c28f2a', 122, 4, 'How would you rate your current skill level in programming?', '5');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('bfe380cc-159f-4ee2-9495-a4e8b1c28f2a', 122, 5, 'What are your primary career goals?', 'Product Manager');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('bfe380cc-159f-4ee2-9495-a4e8b1c28f2a', 122, 6, 'Which technologies do you want to learn next?', 'Figma');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('bfe380cc-159f-4ee2-9495-a4e8b1c28f2a', 122, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('bfe380cc-159f-4ee2-9495-a4e8b1c28f2a', 122, 8, 'What kind of projects excite you the most?', 'No-code SaaS app');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('bfe380cc-159f-4ee2-9495-a4e8b1c28f2a', 122, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('bfe380cc-159f-4ee2-9495-a4e8b1c28f2a', 122, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (123, 'Xavier Smith', 'xavier123@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Computer Science', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3c0fc527-cbcc-4d68-a6ea-299d30cba0cd', 123, 1, 'What''s your name?', 'Xavier Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3c0fc527-cbcc-4d68-a6ea-299d30cba0cd', 123, 2, 'What is your department?', 'Computer Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3c0fc527-cbcc-4d68-a6ea-299d30cba0cd', 123, 3, 'What are your main areas of interest?', 'FinTech');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3c0fc527-cbcc-4d68-a6ea-299d30cba0cd', 123, 4, 'How would you rate your current skill level in programming?', '5');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3c0fc527-cbcc-4d68-a6ea-299d30cba0cd', 123, 5, 'What are your primary career goals?', 'Entrepreneur');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3c0fc527-cbcc-4d68-a6ea-299d30cba0cd', 123, 6, 'Which technologies do you want to learn next?', 'Excel');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3c0fc527-cbcc-4d68-a6ea-299d30cba0cd', 123, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3c0fc527-cbcc-4d68-a6ea-299d30cba0cd', 123, 8, 'What kind of projects excite you the most?', 'Startup pitch deck');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3c0fc527-cbcc-4d68-a6ea-299d30cba0cd', 123, 9, 'How much time can you dedicate to community projects weekly?', '3-5 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3c0fc527-cbcc-4d68-a6ea-299d30cba0cd', 123, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (124, 'Yara Smith', 'yara124@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Business', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2356869a-8212-4fe6-b95a-0cc5bf3221d3', 124, 1, 'What''s your name?', 'Yara Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2356869a-8212-4fe6-b95a-0cc5bf3221d3', 124, 2, 'What is your department?', 'Business');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2356869a-8212-4fe6-b95a-0cc5bf3221d3', 124, 3, 'What are your main areas of interest?', 'Startups');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2356869a-8212-4fe6-b95a-0cc5bf3221d3', 124, 4, 'How would you rate your current skill level in programming?', '3');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2356869a-8212-4fe6-b95a-0cc5bf3221d3', 124, 5, 'What are your primary career goals?', 'Product Manager');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2356869a-8212-4fe6-b95a-0cc5bf3221d3', 124, 6, 'Which technologies do you want to learn next?', 'Excel');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2356869a-8212-4fe6-b95a-0cc5bf3221d3', 124, 7, 'Do you prefer working individually or in a team?', 'Individually');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2356869a-8212-4fe6-b95a-0cc5bf3221d3', 124, 8, 'What kind of projects excite you the most?', 'Startup pitch deck');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2356869a-8212-4fe6-b95a-0cc5bf3221d3', 124, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('2356869a-8212-4fe6-b95a-0cc5bf3221d3', 124, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (125, 'Zack Smith', 'zack125@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Computer Science', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('45d7667a-fc9a-44c7-8f32-c7b3036cbf95', 125, 1, 'What''s your name?', 'Zack Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('45d7667a-fc9a-44c7-8f32-c7b3036cbf95', 125, 2, 'What is your department?', 'Computer Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('45d7667a-fc9a-44c7-8f32-c7b3036cbf95', 125, 3, 'What are your main areas of interest?', 'Startups');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('45d7667a-fc9a-44c7-8f32-c7b3036cbf95', 125, 4, 'How would you rate your current skill level in programming?', '4');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('45d7667a-fc9a-44c7-8f32-c7b3036cbf95', 125, 5, 'What are your primary career goals?', 'Entrepreneur');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('45d7667a-fc9a-44c7-8f32-c7b3036cbf95', 125, 6, 'Which technologies do you want to learn next?', 'Figma');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('45d7667a-fc9a-44c7-8f32-c7b3036cbf95', 125, 7, 'Do you prefer working individually or in a team?', 'Individually');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('45d7667a-fc9a-44c7-8f32-c7b3036cbf95', 125, 8, 'What kind of projects excite you the most?', 'Startup pitch deck');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('45d7667a-fc9a-44c7-8f32-c7b3036cbf95', 125, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('45d7667a-fc9a-44c7-8f32-c7b3036cbf95', 125, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (126, 'Aaron Smith', 'aaron126@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Information Technology', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('65426887-2e67-4aa1-a032-368a84fca748', 126, 1, 'What''s your name?', 'Aaron Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('65426887-2e67-4aa1-a032-368a84fca748', 126, 2, 'What is your department?', 'Information Technology');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('65426887-2e67-4aa1-a032-368a84fca748', 126, 3, 'What are your main areas of interest?', 'Cybersecurity');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('65426887-2e67-4aa1-a032-368a84fca748', 126, 4, 'How would you rate your current skill level in programming?', '4');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('65426887-2e67-4aa1-a032-368a84fca748', 126, 5, 'What are your primary career goals?', 'Security Analyst');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('65426887-2e67-4aa1-a032-368a84fca748', 126, 6, 'Which technologies do you want to learn next?', 'Wireshark');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('65426887-2e67-4aa1-a032-368a84fca748', 126, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('65426887-2e67-4aa1-a032-368a84fca748', 126, 8, 'What kind of projects excite you the most?', 'CTF challenges');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('65426887-2e67-4aa1-a032-368a84fca748', 126, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('65426887-2e67-4aa1-a032-368a84fca748', 126, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (127, 'Bella Smith', 'bella127@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Information Technology', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('866181b5-a9cf-4281-8fcb-3439551d9049', 127, 1, 'What''s your name?', 'Bella Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('866181b5-a9cf-4281-8fcb-3439551d9049', 127, 2, 'What is your department?', 'Information Technology');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('866181b5-a9cf-4281-8fcb-3439551d9049', 127, 3, 'What are your main areas of interest?', 'Cybersecurity');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('866181b5-a9cf-4281-8fcb-3439551d9049', 127, 4, 'How would you rate your current skill level in programming?', '5');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('866181b5-a9cf-4281-8fcb-3439551d9049', 127, 5, 'What are your primary career goals?', 'Penetration Tester');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('866181b5-a9cf-4281-8fcb-3439551d9049', 127, 6, 'Which technologies do you want to learn next?', 'Linux');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('866181b5-a9cf-4281-8fcb-3439551d9049', 127, 7, 'Do you prefer working individually or in a team?', 'Individually');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('866181b5-a9cf-4281-8fcb-3439551d9049', 127, 8, 'What kind of projects excite you the most?', 'CTF challenges');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('866181b5-a9cf-4281-8fcb-3439551d9049', 127, 9, 'How much time can you dedicate to community projects weekly?', '3-5 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('866181b5-a9cf-4281-8fcb-3439551d9049', 127, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (128, 'Chris Smith', 'chris128@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Information Technology', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('26813120-7bec-4840-acb7-bc3642485b03', 128, 1, 'What''s your name?', 'Chris Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('26813120-7bec-4840-acb7-bc3642485b03', 128, 2, 'What is your department?', 'Information Technology');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('26813120-7bec-4840-acb7-bc3642485b03', 128, 3, 'What are your main areas of interest?', 'Cybersecurity');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('26813120-7bec-4840-acb7-bc3642485b03', 128, 4, 'How would you rate your current skill level in programming?', '3');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('26813120-7bec-4840-acb7-bc3642485b03', 128, 5, 'What are your primary career goals?', 'Security Analyst');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('26813120-7bec-4840-acb7-bc3642485b03', 128, 6, 'Which technologies do you want to learn next?', 'Kali');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('26813120-7bec-4840-acb7-bc3642485b03', 128, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('26813120-7bec-4840-acb7-bc3642485b03', 128, 8, 'What kind of projects excite you the most?', 'CTF challenges');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('26813120-7bec-4840-acb7-bc3642485b03', 128, 9, 'How much time can you dedicate to community projects weekly?', '3-5 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('26813120-7bec-4840-acb7-bc3642485b03', 128, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (129, 'Daisy Smith', 'daisy129@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Information Technology', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8174d134-ff5b-43ee-995e-c9f51445be0c', 129, 1, 'What''s your name?', 'Daisy Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8174d134-ff5b-43ee-995e-c9f51445be0c', 129, 2, 'What is your department?', 'Information Technology');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8174d134-ff5b-43ee-995e-c9f51445be0c', 129, 3, 'What are your main areas of interest?', 'Network Security');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8174d134-ff5b-43ee-995e-c9f51445be0c', 129, 4, 'How would you rate your current skill level in programming?', '4');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8174d134-ff5b-43ee-995e-c9f51445be0c', 129, 5, 'What are your primary career goals?', 'Security Analyst');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8174d134-ff5b-43ee-995e-c9f51445be0c', 129, 6, 'Which technologies do you want to learn next?', 'Wireshark');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8174d134-ff5b-43ee-995e-c9f51445be0c', 129, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8174d134-ff5b-43ee-995e-c9f51445be0c', 129, 8, 'What kind of projects excite you the most?', 'CTF challenges');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8174d134-ff5b-43ee-995e-c9f51445be0c', 129, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8174d134-ff5b-43ee-995e-c9f51445be0c', 129, 10, 'Any additional comments or expectations?', 'Excited to join the community!');
