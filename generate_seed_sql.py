import uuid
import random

def generate_sql():
    sql = []
    sql.append("-- ==================================================")
    sql.append("-- PHASE 1: CLEAN RESET")
    sql.append("-- ==================================================")
    sql.append("TRUNCATE TABLE survey_responses CASCADE;")
    sql.append("DELETE FROM users WHERE role != 'admin';")
    sql.append("ALTER SEQUENCE users_id_seq RESTART WITH 100;")
    sql.append("ALTER SEQUENCE survey_responses_id_seq RESTART WITH 1;")
    sql.append("\n-- ==================================================")
    sql.append("-- PHASE 1.5: GENERATE SURVEY QUESTIONS")
    sql.append("-- ==================================================\n")
    
    sql.append("INSERT INTO survey_questions (sequence_no, question, question_type, options, category, trigger_value) VALUES ")
    sql.append("(1, 'What''s your name?', 'open_ended', NULL, 'general', NULL),")
    sql.append("(2, 'What is your department?', 'single_choice', '[\\\"Computer Science\\\", \\\"Information Technology\\\", \\\"Electronics\\\", \\\"Mechanical\\\"]', 'general', NULL),")
    sql.append("(3, 'What are your main areas of interest?', 'multiple_choice', '[\\\"Web Development\\\", \\\"AI/ML\\\", \\\"Cybersecurity\\\", \\\"Data Science\\\", \\\"Cloud Computing\\\"]', 'general', NULL),")
    sql.append("(4, 'How would you rate your current skill level in programming?', 'rating', NULL, 'general', NULL),")
    sql.append("(5, 'What are your primary career goals?', 'multiple_choice', '[\\\"Software Engineer\\\", \\\"Data Scientist\\\", \\\"Product Manager\\\", \\\"Researcher\\\", \\\"Entrepreneur\\\"]', 'general', NULL),")
    sql.append("(6, 'Which technologies do you want to learn next?', 'multiple_choice', '[\\\"React\\\", \\\"Python\\\", \\\"Node.js\\\", \\\"Docker\\\", \\\"AWS\\\", \\\"TensorFlow\\\"]', 'general', NULL),")
    sql.append("(7, 'Do you prefer working individually or in a team?', 'single_choice', '[\\\"Individually\\\", \\\"In a team\\\", \\\"Depends on the project\\\"]', 'general', NULL),")
    sql.append("(8, 'What kind of projects excite you the most?', 'open_ended', NULL, 'general', NULL),")
    sql.append("(9, 'How much time can you dedicate to community projects weekly?', 'single_choice', '[\\\"1-2 hours\\\", \\\"3-5 hours\\\", \\\"5-10 hours\\\", \\\"10+ hours\\\"]', 'general', NULL),")
    sql.append("(10, 'Any additional comments or expectations?', 'open_ended', NULL, 'general', NULL)")
    sql.append("ON CONFLICT (sequence_no) DO NOTHING;\n")

    sql.append("\n-- ==================================================")
    sql.append("-- PHASE 3 & 4: GENERATE TEST STUDENTS AND RESPONSES")
    sql.append("-- ==================================================\n")

    # Generate a fixed hash for 'password123' so users can log in
    # $2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq
    fixed_hash = "$2a$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Vr2Xrl/l1.pS12Xq"

    groups = [
        {
            "name": "AI & Machine Learning",
            "departments": ["Computer Science", "Information Technology"],
            "interests": ["AI/ML", "Data Science"],
            "career_goals": ["Data Scientist", "Software Engineer", "Researcher"],
            "technologies": ["Python", "TensorFlow", "PyTorch"],
            "projects": ["Built a neural network", "Predictive modeling", "NLP chatbot"],
            "count": 8
        },
        {
            "name": "Web Development",
            "departments": ["Computer Science", "Information Technology"],
            "interests": ["Web Development", "Cloud Computing"],
            "career_goals": ["Software Engineer", "Product Manager"],
            "technologies": ["React", "Node.js", "AWS"],
            "projects": ["Full stack e-commerce app", "Portfolio website", "REST API dashboard"],
            "count": 7
        },
        {
            "name": "Robotics",
            "departments": ["Electronics", "Mechanical"],
            "interests": ["Robotics", "IoT"],
            "career_goals": ["Hardware Engineer", "Robotics Engineer"],
            "technologies": ["C++", "Arduino", "ROS"],
            "projects": ["Autonomous drone", "Line-following robot", "Smart home IoT"],
            "count": 6
        },
        {
            "name": "Entrepreneurship",
            "departments": ["Business", "Computer Science"],
            "interests": ["Product Management", "Startups", "FinTech"],
            "career_goals": ["Entrepreneur", "Product Manager"],
            "technologies": ["Figma", "Excel", "Webflow"],
            "projects": ["Startup pitch deck", "Market analysis tool", "No-code SaaS app"],
            "count": 5
        },
        {
            "name": "Cyber Security",
            "departments": ["Information Technology", "Computer Science"],
            "interests": ["Cybersecurity", "Network Security"],
            "career_goals": ["Security Analyst", "Penetration Tester"],
            "technologies": ["Linux", "Kali", "Wireshark", "Python"],
            "projects": ["Network vulnerability scanner", "CTF challenges", "Firewall configuration"],
            "count": 4
        }
    ]

    names = ["Alice", "Bob", "Charlie", "Diana", "Ethan", "Fiona", "George", "Hannah", "Ian", "Julia", 
             "Kevin", "Laura", "Mike", "Nina", "Oscar", "Paula", "Quinn", "Rachel", "Steve", "Tina",
             "Uma", "Victor", "Wendy", "Xavier", "Yara", "Zack", "Aaron", "Bella", "Chris", "Daisy"]

    user_id = 100
    name_idx = 0

    questions = [
        (1, "What's your name?"),
        (2, "What is your department?"),
        (3, "What are your main areas of interest?"),
        (4, "How would you rate your current skill level in programming?"),
        (5, "What are your primary career goals?"),
        (6, "Which technologies do you want to learn next?"),
        (7, "Do you prefer working individually or in a team?"),
        (8, "What kind of projects excite you the most?"),
        (9, "How much time can you dedicate to community projects weekly?"),
        (10, "Any additional comments or expectations?")
    ]

    for group in groups:
        for _ in range(group["count"]):
            first_name = names[name_idx]
            last_name = "Smith"
            full_name = f"{first_name} {last_name}"
            email = f"{first_name.lower()}{user_id}@stemvalley.edu"
            dept = random.choice(group["departments"])
            
            # 1. Insert User
            sql.append(f"INSERT INTO users (id, full_name, email, password_hash, department, role) VALUES ({user_id}, '{full_name}', '{email}', '{fixed_hash}', '{dept}', 'student');")
            
            session_id = str(uuid.uuid4())
            
            # 2. Insert Survey Responses
            answers = {
                1: full_name,
                2: dept,
                3: random.choice(group["interests"]),
                4: str(random.randint(3, 5)),
                5: random.choice(group["career_goals"]),
                6: random.choice(group["technologies"]),
                7: random.choice(["Individually", "In a team"]),
                8: random.choice(group["projects"]),
                9: random.choice(["3-5 hours", "5-10 hours"]),
                10: "Excited to join the community!"
            }

            for q_id, q_text in questions:
                ans = answers[q_id]
                sql.append(f"INSERT INTO survey_responses (session_id, user_id, question_id, question, answer) VALUES ('{session_id}', {user_id}, {q_id}, '{q_text.replace('\'', '\'\'')}', '{ans.replace('\'', '\'\'')}');")
            
            sql.append("") # newline
            user_id += 1
            name_idx += 1

    with open('seed_test_data.sql', 'w') as f:
        f.write("\n".join(sql))

    print("SQL seed file generated: seed_test_data.sql")

if __name__ == "__main__":
    generate_sql()
