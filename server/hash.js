import bcrypt from 'bcryptjs';
bcrypt.hash('AdminPassword123!', 10).then(hash => console.log(hash));
