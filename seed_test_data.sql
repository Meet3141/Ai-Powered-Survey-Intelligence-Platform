-- ==================================================
-- PHASE 1: CLEAN RESET
-- ==================================================
TRUNCATE TABLE survey_responses CASCADE;
DELETE FROM users WHERE role != 'admin';
ALTER SEQUENCE users_id_seq RESTART WITH 100;
ALTER SEQUENCE survey_responses_id_seq RESTART WITH 1;

-- ==================================================
-- PHASE 3 & 4: GENERATE TEST STUDENTS AND RESPONSES
-- ==================================================

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (100, 'Alice Smith', 'alice100@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Computer Science', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e88d5e60-8d83-4f26-9e61-7720b0371d92', 100, 1, 'What''s your name?', 'Alice Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e88d5e60-8d83-4f26-9e61-7720b0371d92', 100, 2, 'What is your department?', 'Computer Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e88d5e60-8d83-4f26-9e61-7720b0371d92', 100, 3, 'What are your main areas of interest?', 'Data Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e88d5e60-8d83-4f26-9e61-7720b0371d92', 100, 4, 'How would you rate your current skill level in programming?', '4');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e88d5e60-8d83-4f26-9e61-7720b0371d92', 100, 5, 'What are your primary career goals?', 'Software Engineer');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e88d5e60-8d83-4f26-9e61-7720b0371d92', 100, 6, 'Which technologies do you want to learn next?', 'TensorFlow');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e88d5e60-8d83-4f26-9e61-7720b0371d92', 100, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e88d5e60-8d83-4f26-9e61-7720b0371d92', 100, 8, 'What kind of projects excite you the most?', 'Built a neural network');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e88d5e60-8d83-4f26-9e61-7720b0371d92', 100, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e88d5e60-8d83-4f26-9e61-7720b0371d92', 100, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (101, 'Bob Smith', 'bob101@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Computer Science', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cb0b2c19-204f-49ed-a04b-e1ed8418d58b', 101, 1, 'What''s your name?', 'Bob Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cb0b2c19-204f-49ed-a04b-e1ed8418d58b', 101, 2, 'What is your department?', 'Computer Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cb0b2c19-204f-49ed-a04b-e1ed8418d58b', 101, 3, 'What are your main areas of interest?', 'AI/ML');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cb0b2c19-204f-49ed-a04b-e1ed8418d58b', 101, 4, 'How would you rate your current skill level in programming?', '4');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cb0b2c19-204f-49ed-a04b-e1ed8418d58b', 101, 5, 'What are your primary career goals?', 'Researcher');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cb0b2c19-204f-49ed-a04b-e1ed8418d58b', 101, 6, 'Which technologies do you want to learn next?', 'PyTorch');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cb0b2c19-204f-49ed-a04b-e1ed8418d58b', 101, 7, 'Do you prefer working individually or in a team?', 'Individually');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cb0b2c19-204f-49ed-a04b-e1ed8418d58b', 101, 8, 'What kind of projects excite you the most?', 'NLP chatbot');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cb0b2c19-204f-49ed-a04b-e1ed8418d58b', 101, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cb0b2c19-204f-49ed-a04b-e1ed8418d58b', 101, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (102, 'Charlie Smith', 'charlie102@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Information Technology', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('30fa7a47-0fe1-4b4c-9211-af6d789d7b98', 102, 1, 'What''s your name?', 'Charlie Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('30fa7a47-0fe1-4b4c-9211-af6d789d7b98', 102, 2, 'What is your department?', 'Information Technology');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('30fa7a47-0fe1-4b4c-9211-af6d789d7b98', 102, 3, 'What are your main areas of interest?', 'AI/ML');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('30fa7a47-0fe1-4b4c-9211-af6d789d7b98', 102, 4, 'How would you rate your current skill level in programming?', '3');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('30fa7a47-0fe1-4b4c-9211-af6d789d7b98', 102, 5, 'What are your primary career goals?', 'Researcher');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('30fa7a47-0fe1-4b4c-9211-af6d789d7b98', 102, 6, 'Which technologies do you want to learn next?', 'PyTorch');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('30fa7a47-0fe1-4b4c-9211-af6d789d7b98', 102, 7, 'Do you prefer working individually or in a team?', 'Individually');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('30fa7a47-0fe1-4b4c-9211-af6d789d7b98', 102, 8, 'What kind of projects excite you the most?', 'NLP chatbot');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('30fa7a47-0fe1-4b4c-9211-af6d789d7b98', 102, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('30fa7a47-0fe1-4b4c-9211-af6d789d7b98', 102, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (103, 'Diana Smith', 'diana103@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Computer Science', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7ef8624e-f826-422b-8c9f-c2bb479bb7d8', 103, 1, 'What''s your name?', 'Diana Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7ef8624e-f826-422b-8c9f-c2bb479bb7d8', 103, 2, 'What is your department?', 'Computer Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7ef8624e-f826-422b-8c9f-c2bb479bb7d8', 103, 3, 'What are your main areas of interest?', 'Data Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7ef8624e-f826-422b-8c9f-c2bb479bb7d8', 103, 4, 'How would you rate your current skill level in programming?', '5');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7ef8624e-f826-422b-8c9f-c2bb479bb7d8', 103, 5, 'What are your primary career goals?', 'Researcher');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7ef8624e-f826-422b-8c9f-c2bb479bb7d8', 103, 6, 'Which technologies do you want to learn next?', 'Python');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7ef8624e-f826-422b-8c9f-c2bb479bb7d8', 103, 7, 'Do you prefer working individually or in a team?', 'Individually');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7ef8624e-f826-422b-8c9f-c2bb479bb7d8', 103, 8, 'What kind of projects excite you the most?', 'Predictive modeling');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7ef8624e-f826-422b-8c9f-c2bb479bb7d8', 103, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7ef8624e-f826-422b-8c9f-c2bb479bb7d8', 103, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (104, 'Ethan Smith', 'ethan104@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Computer Science', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('d4e24764-1f92-44d6-9169-f319f185eaa4', 104, 1, 'What''s your name?', 'Ethan Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('d4e24764-1f92-44d6-9169-f319f185eaa4', 104, 2, 'What is your department?', 'Computer Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('d4e24764-1f92-44d6-9169-f319f185eaa4', 104, 3, 'What are your main areas of interest?', 'AI/ML');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('d4e24764-1f92-44d6-9169-f319f185eaa4', 104, 4, 'How would you rate your current skill level in programming?', '3');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('d4e24764-1f92-44d6-9169-f319f185eaa4', 104, 5, 'What are your primary career goals?', 'Researcher');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('d4e24764-1f92-44d6-9169-f319f185eaa4', 104, 6, 'Which technologies do you want to learn next?', 'TensorFlow');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('d4e24764-1f92-44d6-9169-f319f185eaa4', 104, 7, 'Do you prefer working individually or in a team?', 'Individually');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('d4e24764-1f92-44d6-9169-f319f185eaa4', 104, 8, 'What kind of projects excite you the most?', 'NLP chatbot');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('d4e24764-1f92-44d6-9169-f319f185eaa4', 104, 9, 'How much time can you dedicate to community projects weekly?', '3-5 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('d4e24764-1f92-44d6-9169-f319f185eaa4', 104, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (105, 'Fiona Smith', 'fiona105@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Computer Science', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('c980a577-2ed5-478f-8360-af282b15af21', 105, 1, 'What''s your name?', 'Fiona Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('c980a577-2ed5-478f-8360-af282b15af21', 105, 2, 'What is your department?', 'Computer Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('c980a577-2ed5-478f-8360-af282b15af21', 105, 3, 'What are your main areas of interest?', 'AI/ML');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('c980a577-2ed5-478f-8360-af282b15af21', 105, 4, 'How would you rate your current skill level in programming?', '3');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('c980a577-2ed5-478f-8360-af282b15af21', 105, 5, 'What are your primary career goals?', 'Data Scientist');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('c980a577-2ed5-478f-8360-af282b15af21', 105, 6, 'Which technologies do you want to learn next?', 'TensorFlow');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('c980a577-2ed5-478f-8360-af282b15af21', 105, 7, 'Do you prefer working individually or in a team?', 'Individually');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('c980a577-2ed5-478f-8360-af282b15af21', 105, 8, 'What kind of projects excite you the most?', 'Predictive modeling');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('c980a577-2ed5-478f-8360-af282b15af21', 105, 9, 'How much time can you dedicate to community projects weekly?', '3-5 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('c980a577-2ed5-478f-8360-af282b15af21', 105, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (106, 'George Smith', 'george106@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Information Technology', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3a647f91-71fd-44d2-8b6d-429d964e19cc', 106, 1, 'What''s your name?', 'George Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3a647f91-71fd-44d2-8b6d-429d964e19cc', 106, 2, 'What is your department?', 'Information Technology');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3a647f91-71fd-44d2-8b6d-429d964e19cc', 106, 3, 'What are your main areas of interest?', 'AI/ML');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3a647f91-71fd-44d2-8b6d-429d964e19cc', 106, 4, 'How would you rate your current skill level in programming?', '4');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3a647f91-71fd-44d2-8b6d-429d964e19cc', 106, 5, 'What are your primary career goals?', 'Data Scientist');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3a647f91-71fd-44d2-8b6d-429d964e19cc', 106, 6, 'Which technologies do you want to learn next?', 'TensorFlow');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3a647f91-71fd-44d2-8b6d-429d964e19cc', 106, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3a647f91-71fd-44d2-8b6d-429d964e19cc', 106, 8, 'What kind of projects excite you the most?', 'NLP chatbot');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3a647f91-71fd-44d2-8b6d-429d964e19cc', 106, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('3a647f91-71fd-44d2-8b6d-429d964e19cc', 106, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (107, 'Hannah Smith', 'hannah107@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Computer Science', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('f08eab6c-e673-490d-9ef3-d83fd7177344', 107, 1, 'What''s your name?', 'Hannah Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('f08eab6c-e673-490d-9ef3-d83fd7177344', 107, 2, 'What is your department?', 'Computer Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('f08eab6c-e673-490d-9ef3-d83fd7177344', 107, 3, 'What are your main areas of interest?', 'AI/ML');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('f08eab6c-e673-490d-9ef3-d83fd7177344', 107, 4, 'How would you rate your current skill level in programming?', '5');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('f08eab6c-e673-490d-9ef3-d83fd7177344', 107, 5, 'What are your primary career goals?', 'Researcher');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('f08eab6c-e673-490d-9ef3-d83fd7177344', 107, 6, 'Which technologies do you want to learn next?', 'Python');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('f08eab6c-e673-490d-9ef3-d83fd7177344', 107, 7, 'Do you prefer working individually or in a team?', 'Individually');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('f08eab6c-e673-490d-9ef3-d83fd7177344', 107, 8, 'What kind of projects excite you the most?', 'NLP chatbot');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('f08eab6c-e673-490d-9ef3-d83fd7177344', 107, 9, 'How much time can you dedicate to community projects weekly?', '3-5 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('f08eab6c-e673-490d-9ef3-d83fd7177344', 107, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (108, 'Ian Smith', 'ian108@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Information Technology', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('dcc11f24-d0cd-4b82-ba09-bcdaac0a6cf6', 108, 1, 'What''s your name?', 'Ian Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('dcc11f24-d0cd-4b82-ba09-bcdaac0a6cf6', 108, 2, 'What is your department?', 'Information Technology');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('dcc11f24-d0cd-4b82-ba09-bcdaac0a6cf6', 108, 3, 'What are your main areas of interest?', 'Web Development');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('dcc11f24-d0cd-4b82-ba09-bcdaac0a6cf6', 108, 4, 'How would you rate your current skill level in programming?', '5');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('dcc11f24-d0cd-4b82-ba09-bcdaac0a6cf6', 108, 5, 'What are your primary career goals?', 'Product Manager');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('dcc11f24-d0cd-4b82-ba09-bcdaac0a6cf6', 108, 6, 'Which technologies do you want to learn next?', 'AWS');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('dcc11f24-d0cd-4b82-ba09-bcdaac0a6cf6', 108, 7, 'Do you prefer working individually or in a team?', 'Individually');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('dcc11f24-d0cd-4b82-ba09-bcdaac0a6cf6', 108, 8, 'What kind of projects excite you the most?', 'Portfolio website');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('dcc11f24-d0cd-4b82-ba09-bcdaac0a6cf6', 108, 9, 'How much time can you dedicate to community projects weekly?', '3-5 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('dcc11f24-d0cd-4b82-ba09-bcdaac0a6cf6', 108, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (109, 'Julia Smith', 'julia109@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Computer Science', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('dad35b34-677e-4c59-b0f0-7aa835b9f0b6', 109, 1, 'What''s your name?', 'Julia Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('dad35b34-677e-4c59-b0f0-7aa835b9f0b6', 109, 2, 'What is your department?', 'Computer Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('dad35b34-677e-4c59-b0f0-7aa835b9f0b6', 109, 3, 'What are your main areas of interest?', 'Cloud Computing');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('dad35b34-677e-4c59-b0f0-7aa835b9f0b6', 109, 4, 'How would you rate your current skill level in programming?', '3');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('dad35b34-677e-4c59-b0f0-7aa835b9f0b6', 109, 5, 'What are your primary career goals?', 'Software Engineer');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('dad35b34-677e-4c59-b0f0-7aa835b9f0b6', 109, 6, 'Which technologies do you want to learn next?', 'AWS');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('dad35b34-677e-4c59-b0f0-7aa835b9f0b6', 109, 7, 'Do you prefer working individually or in a team?', 'Individually');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('dad35b34-677e-4c59-b0f0-7aa835b9f0b6', 109, 8, 'What kind of projects excite you the most?', 'Portfolio website');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('dad35b34-677e-4c59-b0f0-7aa835b9f0b6', 109, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('dad35b34-677e-4c59-b0f0-7aa835b9f0b6', 109, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (110, 'Kevin Smith', 'kevin110@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Computer Science', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('081a882c-f61f-4fb1-a61d-f9fc2f22a235', 110, 1, 'What''s your name?', 'Kevin Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('081a882c-f61f-4fb1-a61d-f9fc2f22a235', 110, 2, 'What is your department?', 'Computer Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('081a882c-f61f-4fb1-a61d-f9fc2f22a235', 110, 3, 'What are your main areas of interest?', 'Cloud Computing');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('081a882c-f61f-4fb1-a61d-f9fc2f22a235', 110, 4, 'How would you rate your current skill level in programming?', '3');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('081a882c-f61f-4fb1-a61d-f9fc2f22a235', 110, 5, 'What are your primary career goals?', 'Product Manager');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('081a882c-f61f-4fb1-a61d-f9fc2f22a235', 110, 6, 'Which technologies do you want to learn next?', 'Node.js');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('081a882c-f61f-4fb1-a61d-f9fc2f22a235', 110, 7, 'Do you prefer working individually or in a team?', 'Individually');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('081a882c-f61f-4fb1-a61d-f9fc2f22a235', 110, 8, 'What kind of projects excite you the most?', 'REST API dashboard');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('081a882c-f61f-4fb1-a61d-f9fc2f22a235', 110, 9, 'How much time can you dedicate to community projects weekly?', '3-5 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('081a882c-f61f-4fb1-a61d-f9fc2f22a235', 110, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (111, 'Laura Smith', 'laura111@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Information Technology', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('0d1f4d86-8ea8-4f79-82bb-fa32c1abc0f6', 111, 1, 'What''s your name?', 'Laura Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('0d1f4d86-8ea8-4f79-82bb-fa32c1abc0f6', 111, 2, 'What is your department?', 'Information Technology');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('0d1f4d86-8ea8-4f79-82bb-fa32c1abc0f6', 111, 3, 'What are your main areas of interest?', 'Cloud Computing');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('0d1f4d86-8ea8-4f79-82bb-fa32c1abc0f6', 111, 4, 'How would you rate your current skill level in programming?', '4');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('0d1f4d86-8ea8-4f79-82bb-fa32c1abc0f6', 111, 5, 'What are your primary career goals?', 'Software Engineer');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('0d1f4d86-8ea8-4f79-82bb-fa32c1abc0f6', 111, 6, 'Which technologies do you want to learn next?', 'AWS');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('0d1f4d86-8ea8-4f79-82bb-fa32c1abc0f6', 111, 7, 'Do you prefer working individually or in a team?', 'Individually');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('0d1f4d86-8ea8-4f79-82bb-fa32c1abc0f6', 111, 8, 'What kind of projects excite you the most?', 'Portfolio website');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('0d1f4d86-8ea8-4f79-82bb-fa32c1abc0f6', 111, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('0d1f4d86-8ea8-4f79-82bb-fa32c1abc0f6', 111, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (112, 'Mike Smith', 'mike112@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Computer Science', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e4c13e30-1044-4799-989d-7c28eee254cc', 112, 1, 'What''s your name?', 'Mike Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e4c13e30-1044-4799-989d-7c28eee254cc', 112, 2, 'What is your department?', 'Computer Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e4c13e30-1044-4799-989d-7c28eee254cc', 112, 3, 'What are your main areas of interest?', 'Cloud Computing');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e4c13e30-1044-4799-989d-7c28eee254cc', 112, 4, 'How would you rate your current skill level in programming?', '5');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e4c13e30-1044-4799-989d-7c28eee254cc', 112, 5, 'What are your primary career goals?', 'Software Engineer');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e4c13e30-1044-4799-989d-7c28eee254cc', 112, 6, 'Which technologies do you want to learn next?', 'AWS');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e4c13e30-1044-4799-989d-7c28eee254cc', 112, 7, 'Do you prefer working individually or in a team?', 'Individually');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e4c13e30-1044-4799-989d-7c28eee254cc', 112, 8, 'What kind of projects excite you the most?', 'Portfolio website');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e4c13e30-1044-4799-989d-7c28eee254cc', 112, 9, 'How much time can you dedicate to community projects weekly?', '3-5 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('e4c13e30-1044-4799-989d-7c28eee254cc', 112, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (113, 'Nina Smith', 'nina113@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Information Technology', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('089fe75b-80a3-4058-a025-8ba8284ff5d2', 113, 1, 'What''s your name?', 'Nina Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('089fe75b-80a3-4058-a025-8ba8284ff5d2', 113, 2, 'What is your department?', 'Information Technology');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('089fe75b-80a3-4058-a025-8ba8284ff5d2', 113, 3, 'What are your main areas of interest?', 'Web Development');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('089fe75b-80a3-4058-a025-8ba8284ff5d2', 113, 4, 'How would you rate your current skill level in programming?', '4');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('089fe75b-80a3-4058-a025-8ba8284ff5d2', 113, 5, 'What are your primary career goals?', 'Software Engineer');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('089fe75b-80a3-4058-a025-8ba8284ff5d2', 113, 6, 'Which technologies do you want to learn next?', 'Node.js');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('089fe75b-80a3-4058-a025-8ba8284ff5d2', 113, 7, 'Do you prefer working individually or in a team?', 'Individually');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('089fe75b-80a3-4058-a025-8ba8284ff5d2', 113, 8, 'What kind of projects excite you the most?', 'REST API dashboard');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('089fe75b-80a3-4058-a025-8ba8284ff5d2', 113, 9, 'How much time can you dedicate to community projects weekly?', '3-5 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('089fe75b-80a3-4058-a025-8ba8284ff5d2', 113, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (114, 'Oscar Smith', 'oscar114@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Computer Science', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('a2712533-7cdb-4a88-91f3-5e6e8b491877', 114, 1, 'What''s your name?', 'Oscar Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('a2712533-7cdb-4a88-91f3-5e6e8b491877', 114, 2, 'What is your department?', 'Computer Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('a2712533-7cdb-4a88-91f3-5e6e8b491877', 114, 3, 'What are your main areas of interest?', 'Cloud Computing');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('a2712533-7cdb-4a88-91f3-5e6e8b491877', 114, 4, 'How would you rate your current skill level in programming?', '5');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('a2712533-7cdb-4a88-91f3-5e6e8b491877', 114, 5, 'What are your primary career goals?', 'Software Engineer');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('a2712533-7cdb-4a88-91f3-5e6e8b491877', 114, 6, 'Which technologies do you want to learn next?', 'React');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('a2712533-7cdb-4a88-91f3-5e6e8b491877', 114, 7, 'Do you prefer working individually or in a team?', 'Individually');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('a2712533-7cdb-4a88-91f3-5e6e8b491877', 114, 8, 'What kind of projects excite you the most?', 'Full stack e-commerce app');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('a2712533-7cdb-4a88-91f3-5e6e8b491877', 114, 9, 'How much time can you dedicate to community projects weekly?', '3-5 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('a2712533-7cdb-4a88-91f3-5e6e8b491877', 114, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (115, 'Paula Smith', 'paula115@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Electronics', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('278c1c48-0218-444c-a91e-5500aa7c0776', 115, 1, 'What''s your name?', 'Paula Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('278c1c48-0218-444c-a91e-5500aa7c0776', 115, 2, 'What is your department?', 'Electronics');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('278c1c48-0218-444c-a91e-5500aa7c0776', 115, 3, 'What are your main areas of interest?', 'IoT');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('278c1c48-0218-444c-a91e-5500aa7c0776', 115, 4, 'How would you rate your current skill level in programming?', '5');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('278c1c48-0218-444c-a91e-5500aa7c0776', 115, 5, 'What are your primary career goals?', 'Hardware Engineer');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('278c1c48-0218-444c-a91e-5500aa7c0776', 115, 6, 'Which technologies do you want to learn next?', 'C++');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('278c1c48-0218-444c-a91e-5500aa7c0776', 115, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('278c1c48-0218-444c-a91e-5500aa7c0776', 115, 8, 'What kind of projects excite you the most?', 'Line-following robot');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('278c1c48-0218-444c-a91e-5500aa7c0776', 115, 9, 'How much time can you dedicate to community projects weekly?', '3-5 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('278c1c48-0218-444c-a91e-5500aa7c0776', 115, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (116, 'Quinn Smith', 'quinn116@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Electronics', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('552d15a4-a4f3-4668-bc35-b7860d9c2387', 116, 1, 'What''s your name?', 'Quinn Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('552d15a4-a4f3-4668-bc35-b7860d9c2387', 116, 2, 'What is your department?', 'Electronics');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('552d15a4-a4f3-4668-bc35-b7860d9c2387', 116, 3, 'What are your main areas of interest?', 'IoT');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('552d15a4-a4f3-4668-bc35-b7860d9c2387', 116, 4, 'How would you rate your current skill level in programming?', '3');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('552d15a4-a4f3-4668-bc35-b7860d9c2387', 116, 5, 'What are your primary career goals?', 'Robotics Engineer');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('552d15a4-a4f3-4668-bc35-b7860d9c2387', 116, 6, 'Which technologies do you want to learn next?', 'Arduino');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('552d15a4-a4f3-4668-bc35-b7860d9c2387', 116, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('552d15a4-a4f3-4668-bc35-b7860d9c2387', 116, 8, 'What kind of projects excite you the most?', 'Line-following robot');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('552d15a4-a4f3-4668-bc35-b7860d9c2387', 116, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('552d15a4-a4f3-4668-bc35-b7860d9c2387', 116, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (117, 'Rachel Smith', 'rachel117@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Electronics', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('bfad96d3-b3d6-431c-8dd6-aea2d7ce7739', 117, 1, 'What''s your name?', 'Rachel Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('bfad96d3-b3d6-431c-8dd6-aea2d7ce7739', 117, 2, 'What is your department?', 'Electronics');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('bfad96d3-b3d6-431c-8dd6-aea2d7ce7739', 117, 3, 'What are your main areas of interest?', 'IoT');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('bfad96d3-b3d6-431c-8dd6-aea2d7ce7739', 117, 4, 'How would you rate your current skill level in programming?', '3');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('bfad96d3-b3d6-431c-8dd6-aea2d7ce7739', 117, 5, 'What are your primary career goals?', 'Robotics Engineer');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('bfad96d3-b3d6-431c-8dd6-aea2d7ce7739', 117, 6, 'Which technologies do you want to learn next?', 'C++');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('bfad96d3-b3d6-431c-8dd6-aea2d7ce7739', 117, 7, 'Do you prefer working individually or in a team?', 'Individually');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('bfad96d3-b3d6-431c-8dd6-aea2d7ce7739', 117, 8, 'What kind of projects excite you the most?', 'Smart home IoT');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('bfad96d3-b3d6-431c-8dd6-aea2d7ce7739', 117, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('bfad96d3-b3d6-431c-8dd6-aea2d7ce7739', 117, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (118, 'Steve Smith', 'steve118@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Electronics', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('ab8f62a7-78fd-49fa-b915-6bb76646b0d6', 118, 1, 'What''s your name?', 'Steve Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('ab8f62a7-78fd-49fa-b915-6bb76646b0d6', 118, 2, 'What is your department?', 'Electronics');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('ab8f62a7-78fd-49fa-b915-6bb76646b0d6', 118, 3, 'What are your main areas of interest?', 'Robotics');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('ab8f62a7-78fd-49fa-b915-6bb76646b0d6', 118, 4, 'How would you rate your current skill level in programming?', '4');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('ab8f62a7-78fd-49fa-b915-6bb76646b0d6', 118, 5, 'What are your primary career goals?', 'Robotics Engineer');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('ab8f62a7-78fd-49fa-b915-6bb76646b0d6', 118, 6, 'Which technologies do you want to learn next?', 'Arduino');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('ab8f62a7-78fd-49fa-b915-6bb76646b0d6', 118, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('ab8f62a7-78fd-49fa-b915-6bb76646b0d6', 118, 8, 'What kind of projects excite you the most?', 'Smart home IoT');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('ab8f62a7-78fd-49fa-b915-6bb76646b0d6', 118, 9, 'How much time can you dedicate to community projects weekly?', '3-5 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('ab8f62a7-78fd-49fa-b915-6bb76646b0d6', 118, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (119, 'Tina Smith', 'tina119@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Mechanical', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7c562f06-a7bf-4de4-83d8-680947aa3539', 119, 1, 'What''s your name?', 'Tina Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7c562f06-a7bf-4de4-83d8-680947aa3539', 119, 2, 'What is your department?', 'Mechanical');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7c562f06-a7bf-4de4-83d8-680947aa3539', 119, 3, 'What are your main areas of interest?', 'IoT');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7c562f06-a7bf-4de4-83d8-680947aa3539', 119, 4, 'How would you rate your current skill level in programming?', '3');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7c562f06-a7bf-4de4-83d8-680947aa3539', 119, 5, 'What are your primary career goals?', 'Hardware Engineer');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7c562f06-a7bf-4de4-83d8-680947aa3539', 119, 6, 'Which technologies do you want to learn next?', 'C++');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7c562f06-a7bf-4de4-83d8-680947aa3539', 119, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7c562f06-a7bf-4de4-83d8-680947aa3539', 119, 8, 'What kind of projects excite you the most?', 'Line-following robot');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7c562f06-a7bf-4de4-83d8-680947aa3539', 119, 9, 'How much time can you dedicate to community projects weekly?', '3-5 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('7c562f06-a7bf-4de4-83d8-680947aa3539', 119, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (120, 'Uma Smith', 'uma120@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Mechanical', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('268660f0-fb69-4f31-8bb0-1ae7bcd3197b', 120, 1, 'What''s your name?', 'Uma Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('268660f0-fb69-4f31-8bb0-1ae7bcd3197b', 120, 2, 'What is your department?', 'Mechanical');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('268660f0-fb69-4f31-8bb0-1ae7bcd3197b', 120, 3, 'What are your main areas of interest?', 'Robotics');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('268660f0-fb69-4f31-8bb0-1ae7bcd3197b', 120, 4, 'How would you rate your current skill level in programming?', '3');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('268660f0-fb69-4f31-8bb0-1ae7bcd3197b', 120, 5, 'What are your primary career goals?', 'Robotics Engineer');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('268660f0-fb69-4f31-8bb0-1ae7bcd3197b', 120, 6, 'Which technologies do you want to learn next?', 'C++');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('268660f0-fb69-4f31-8bb0-1ae7bcd3197b', 120, 7, 'Do you prefer working individually or in a team?', 'Individually');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('268660f0-fb69-4f31-8bb0-1ae7bcd3197b', 120, 8, 'What kind of projects excite you the most?', 'Autonomous drone');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('268660f0-fb69-4f31-8bb0-1ae7bcd3197b', 120, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('268660f0-fb69-4f31-8bb0-1ae7bcd3197b', 120, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (121, 'Victor Smith', 'victor121@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Computer Science', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cb9ffcce-bac3-4faf-953b-57dfdad92093', 121, 1, 'What''s your name?', 'Victor Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cb9ffcce-bac3-4faf-953b-57dfdad92093', 121, 2, 'What is your department?', 'Computer Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cb9ffcce-bac3-4faf-953b-57dfdad92093', 121, 3, 'What are your main areas of interest?', 'FinTech');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cb9ffcce-bac3-4faf-953b-57dfdad92093', 121, 4, 'How would you rate your current skill level in programming?', '4');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cb9ffcce-bac3-4faf-953b-57dfdad92093', 121, 5, 'What are your primary career goals?', 'Entrepreneur');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cb9ffcce-bac3-4faf-953b-57dfdad92093', 121, 6, 'Which technologies do you want to learn next?', 'Excel');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cb9ffcce-bac3-4faf-953b-57dfdad92093', 121, 7, 'Do you prefer working individually or in a team?', 'Individually');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cb9ffcce-bac3-4faf-953b-57dfdad92093', 121, 8, 'What kind of projects excite you the most?', 'Startup pitch deck');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cb9ffcce-bac3-4faf-953b-57dfdad92093', 121, 9, 'How much time can you dedicate to community projects weekly?', '3-5 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('cb9ffcce-bac3-4faf-953b-57dfdad92093', 121, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (122, 'Wendy Smith', 'wendy122@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Computer Science', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('39acd20c-3f7d-4d60-a73a-35be3c6a11fd', 122, 1, 'What''s your name?', 'Wendy Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('39acd20c-3f7d-4d60-a73a-35be3c6a11fd', 122, 2, 'What is your department?', 'Computer Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('39acd20c-3f7d-4d60-a73a-35be3c6a11fd', 122, 3, 'What are your main areas of interest?', 'Product Management');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('39acd20c-3f7d-4d60-a73a-35be3c6a11fd', 122, 4, 'How would you rate your current skill level in programming?', '5');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('39acd20c-3f7d-4d60-a73a-35be3c6a11fd', 122, 5, 'What are your primary career goals?', 'Product Manager');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('39acd20c-3f7d-4d60-a73a-35be3c6a11fd', 122, 6, 'Which technologies do you want to learn next?', 'Excel');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('39acd20c-3f7d-4d60-a73a-35be3c6a11fd', 122, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('39acd20c-3f7d-4d60-a73a-35be3c6a11fd', 122, 8, 'What kind of projects excite you the most?', 'No-code SaaS app');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('39acd20c-3f7d-4d60-a73a-35be3c6a11fd', 122, 9, 'How much time can you dedicate to community projects weekly?', '3-5 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('39acd20c-3f7d-4d60-a73a-35be3c6a11fd', 122, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (123, 'Xavier Smith', 'xavier123@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Business', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('23a6befb-7da1-43ff-9f2d-40cae1e4e678', 123, 1, 'What''s your name?', 'Xavier Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('23a6befb-7da1-43ff-9f2d-40cae1e4e678', 123, 2, 'What is your department?', 'Business');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('23a6befb-7da1-43ff-9f2d-40cae1e4e678', 123, 3, 'What are your main areas of interest?', 'FinTech');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('23a6befb-7da1-43ff-9f2d-40cae1e4e678', 123, 4, 'How would you rate your current skill level in programming?', '5');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('23a6befb-7da1-43ff-9f2d-40cae1e4e678', 123, 5, 'What are your primary career goals?', 'Product Manager');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('23a6befb-7da1-43ff-9f2d-40cae1e4e678', 123, 6, 'Which technologies do you want to learn next?', 'Excel');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('23a6befb-7da1-43ff-9f2d-40cae1e4e678', 123, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('23a6befb-7da1-43ff-9f2d-40cae1e4e678', 123, 8, 'What kind of projects excite you the most?', 'Market analysis tool');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('23a6befb-7da1-43ff-9f2d-40cae1e4e678', 123, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('23a6befb-7da1-43ff-9f2d-40cae1e4e678', 123, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (124, 'Yara Smith', 'yara124@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Computer Science', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('56374699-579c-46fb-84b4-c1ee7b5259f3', 124, 1, 'What''s your name?', 'Yara Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('56374699-579c-46fb-84b4-c1ee7b5259f3', 124, 2, 'What is your department?', 'Computer Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('56374699-579c-46fb-84b4-c1ee7b5259f3', 124, 3, 'What are your main areas of interest?', 'FinTech');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('56374699-579c-46fb-84b4-c1ee7b5259f3', 124, 4, 'How would you rate your current skill level in programming?', '4');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('56374699-579c-46fb-84b4-c1ee7b5259f3', 124, 5, 'What are your primary career goals?', 'Product Manager');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('56374699-579c-46fb-84b4-c1ee7b5259f3', 124, 6, 'Which technologies do you want to learn next?', 'Figma');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('56374699-579c-46fb-84b4-c1ee7b5259f3', 124, 7, 'Do you prefer working individually or in a team?', 'Individually');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('56374699-579c-46fb-84b4-c1ee7b5259f3', 124, 8, 'What kind of projects excite you the most?', 'No-code SaaS app');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('56374699-579c-46fb-84b4-c1ee7b5259f3', 124, 9, 'How much time can you dedicate to community projects weekly?', '3-5 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('56374699-579c-46fb-84b4-c1ee7b5259f3', 124, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (125, 'Zack Smith', 'zack125@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Computer Science', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8c8ebd11-0438-409e-bd6f-1de3d59219a5', 125, 1, 'What''s your name?', 'Zack Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8c8ebd11-0438-409e-bd6f-1de3d59219a5', 125, 2, 'What is your department?', 'Computer Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8c8ebd11-0438-409e-bd6f-1de3d59219a5', 125, 3, 'What are your main areas of interest?', 'FinTech');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8c8ebd11-0438-409e-bd6f-1de3d59219a5', 125, 4, 'How would you rate your current skill level in programming?', '3');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8c8ebd11-0438-409e-bd6f-1de3d59219a5', 125, 5, 'What are your primary career goals?', 'Product Manager');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8c8ebd11-0438-409e-bd6f-1de3d59219a5', 125, 6, 'Which technologies do you want to learn next?', 'Webflow');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8c8ebd11-0438-409e-bd6f-1de3d59219a5', 125, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8c8ebd11-0438-409e-bd6f-1de3d59219a5', 125, 8, 'What kind of projects excite you the most?', 'No-code SaaS app');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8c8ebd11-0438-409e-bd6f-1de3d59219a5', 125, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8c8ebd11-0438-409e-bd6f-1de3d59219a5', 125, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (126, 'Aaron Smith', 'aaron126@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Computer Science', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8d8b3c36-3c60-46f2-a8e5-1f639318181b', 126, 1, 'What''s your name?', 'Aaron Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8d8b3c36-3c60-46f2-a8e5-1f639318181b', 126, 2, 'What is your department?', 'Computer Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8d8b3c36-3c60-46f2-a8e5-1f639318181b', 126, 3, 'What are your main areas of interest?', 'Network Security');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8d8b3c36-3c60-46f2-a8e5-1f639318181b', 126, 4, 'How would you rate your current skill level in programming?', '3');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8d8b3c36-3c60-46f2-a8e5-1f639318181b', 126, 5, 'What are your primary career goals?', 'Penetration Tester');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8d8b3c36-3c60-46f2-a8e5-1f639318181b', 126, 6, 'Which technologies do you want to learn next?', 'Kali');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8d8b3c36-3c60-46f2-a8e5-1f639318181b', 126, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8d8b3c36-3c60-46f2-a8e5-1f639318181b', 126, 8, 'What kind of projects excite you the most?', 'Network vulnerability scanner');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8d8b3c36-3c60-46f2-a8e5-1f639318181b', 126, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('8d8b3c36-3c60-46f2-a8e5-1f639318181b', 126, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (127, 'Bella Smith', 'bella127@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Information Technology', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('baca477d-ab54-4abc-a7a5-3147487d7727', 127, 1, 'What''s your name?', 'Bella Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('baca477d-ab54-4abc-a7a5-3147487d7727', 127, 2, 'What is your department?', 'Information Technology');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('baca477d-ab54-4abc-a7a5-3147487d7727', 127, 3, 'What are your main areas of interest?', 'Network Security');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('baca477d-ab54-4abc-a7a5-3147487d7727', 127, 4, 'How would you rate your current skill level in programming?', '4');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('baca477d-ab54-4abc-a7a5-3147487d7727', 127, 5, 'What are your primary career goals?', 'Penetration Tester');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('baca477d-ab54-4abc-a7a5-3147487d7727', 127, 6, 'Which technologies do you want to learn next?', 'Linux');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('baca477d-ab54-4abc-a7a5-3147487d7727', 127, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('baca477d-ab54-4abc-a7a5-3147487d7727', 127, 8, 'What kind of projects excite you the most?', 'Firewall configuration');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('baca477d-ab54-4abc-a7a5-3147487d7727', 127, 9, 'How much time can you dedicate to community projects weekly?', '3-5 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('baca477d-ab54-4abc-a7a5-3147487d7727', 127, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (128, 'Chris Smith', 'chris128@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Computer Science', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('34122c6a-1815-4960-84e2-d63fd7700f2d', 128, 1, 'What''s your name?', 'Chris Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('34122c6a-1815-4960-84e2-d63fd7700f2d', 128, 2, 'What is your department?', 'Computer Science');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('34122c6a-1815-4960-84e2-d63fd7700f2d', 128, 3, 'What are your main areas of interest?', 'Network Security');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('34122c6a-1815-4960-84e2-d63fd7700f2d', 128, 4, 'How would you rate your current skill level in programming?', '4');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('34122c6a-1815-4960-84e2-d63fd7700f2d', 128, 5, 'What are your primary career goals?', 'Penetration Tester');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('34122c6a-1815-4960-84e2-d63fd7700f2d', 128, 6, 'Which technologies do you want to learn next?', 'Wireshark');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('34122c6a-1815-4960-84e2-d63fd7700f2d', 128, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('34122c6a-1815-4960-84e2-d63fd7700f2d', 128, 8, 'What kind of projects excite you the most?', 'CTF challenges');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('34122c6a-1815-4960-84e2-d63fd7700f2d', 128, 9, 'How much time can you dedicate to community projects weekly?', '5-10 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('34122c6a-1815-4960-84e2-d63fd7700f2d', 128, 10, 'Any additional comments or expectations?', 'Excited to join the community!');

INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES (129, 'Daisy Smith', 'daisy129@stemvalley.edu', '$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq', 'Information Technology', 'student');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b1dabe99-6fd3-4104-af2a-d0263ab9ffbc', 129, 1, 'What''s your name?', 'Daisy Smith');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b1dabe99-6fd3-4104-af2a-d0263ab9ffbc', 129, 2, 'What is your department?', 'Information Technology');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b1dabe99-6fd3-4104-af2a-d0263ab9ffbc', 129, 3, 'What are your main areas of interest?', 'Cybersecurity');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b1dabe99-6fd3-4104-af2a-d0263ab9ffbc', 129, 4, 'How would you rate your current skill level in programming?', '3');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b1dabe99-6fd3-4104-af2a-d0263ab9ffbc', 129, 5, 'What are your primary career goals?', 'Security Analyst');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b1dabe99-6fd3-4104-af2a-d0263ab9ffbc', 129, 6, 'Which technologies do you want to learn next?', 'Linux');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b1dabe99-6fd3-4104-af2a-d0263ab9ffbc', 129, 7, 'Do you prefer working individually or in a team?', 'In a team');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b1dabe99-6fd3-4104-af2a-d0263ab9ffbc', 129, 8, 'What kind of projects excite you the most?', 'Network vulnerability scanner');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b1dabe99-6fd3-4104-af2a-d0263ab9ffbc', 129, 9, 'How much time can you dedicate to community projects weekly?', '3-5 hours');
INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('b1dabe99-6fd3-4104-af2a-d0263ab9ffbc', 129, 10, 'Any additional comments or expectations?', 'Excited to join the community!');
