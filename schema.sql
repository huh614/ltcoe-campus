-- ============================================================
-- LTCOE Campus — SQLite Schema (Enhanced)
-- ============================================================

PRAGMA foreign_keys = ON;

-- ── Users (login) ───────────────────────────────────────────
CREATE TABLE IF NOT EXISTS users (
  id        INTEGER PRIMARY KEY AUTOINCREMENT,
  email     TEXT    UNIQUE NOT NULL,
  password  TEXT    NOT NULL,
  role      TEXT    NOT NULL,   -- 'Administrator' | 'Faculty' | 'Student'
  name      TEXT    NOT NULL,
  initials  TEXT    NOT NULL,
  department TEXT   DEFAULT '',
  phone     TEXT   DEFAULT ''
);

-- ── Students / Applications ─────────────────────────────────
CREATE TABLE IF NOT EXISTS students (
  id        INTEGER PRIMARY KEY AUTOINCREMENT,
  roll      TEXT,
  first     TEXT    NOT NULL,
  last      TEXT    NOT NULL,
  email     TEXT    NOT NULL,
  phone     TEXT,
  branch    TEXT    NOT NULL,   -- CE | IT | ENTC | Mech | Civil
  year      TEXT    NOT NULL,   -- FE | SE | TE | BE
  gender    TEXT,
  dob       TEXT,
  address   TEXT,
  school    TEXT,
  score     TEXT,
  status    TEXT    NOT NULL DEFAULT 'Pending',  -- Pending | Approved | Rejected
  applied   TEXT    NOT NULL
);

-- ── Attendance Log ───────────────────────────────────────────
CREATE TABLE IF NOT EXISTS attendance_log (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  date       TEXT    NOT NULL,
  student_id INTEGER NOT NULL REFERENCES students(id) ON DELETE CASCADE,
  subject    TEXT    NOT NULL DEFAULT 'General Session',
  status     TEXT    NOT NULL,  -- 'P' | 'A'
  UNIQUE(date, student_id, subject)
);

-- ── Announcements ────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS announcements (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  title      TEXT    NOT NULL,
  body       TEXT    NOT NULL,
  category   TEXT    NOT NULL DEFAULT 'General',  -- General | Exam | Event | Important
  posted_by  TEXT    NOT NULL,
  created_at TEXT    NOT NULL,
  priority   TEXT    NOT NULL DEFAULT 'normal'  -- low | normal | high | urgent
);

-- ── Timetable ────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS timetable (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  day        TEXT    NOT NULL,  -- Monday | Tuesday | ...
  time_slot  TEXT    NOT NULL,  -- e.g. '09:00 - 10:00'
  subject    TEXT    NOT NULL,
  faculty    TEXT    NOT NULL,
  room       TEXT    NOT NULL,
  branch     TEXT    NOT NULL,
  year       TEXT    NOT NULL
);

-- ── Feedback ─────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS feedback (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  student_id INTEGER REFERENCES students(id) ON DELETE CASCADE,
  student_name TEXT NOT NULL,
  subject    TEXT    NOT NULL,
  rating     INTEGER NOT NULL,  -- 1-5
  comment    TEXT,
  created_at TEXT    NOT NULL
);

-- ============================================================
-- SEED DATA
-- ============================================================

-- ── Admin Users ──────────────────────────────────────────────
INSERT OR IGNORE INTO users (email, password, role, name, initials, department, phone) VALUES
  ('admin@ltcoe.edu.in',   'admin123',   'Administrator', 'Prof. M. Umale',  'MU', 'Administration', '9820001001');

-- ── Faculty Users (Multiple Professors) ─────────────────────
INSERT OR IGNORE INTO users (email, password, role, name, initials, department, phone) VALUES
  ('faculty@ltcoe.edu.in',       'faculty123', 'Faculty', 'Prof. A. Sharma',    'AS', 'Computer Engineering', '9820002001'),
  ('r.deshmukh@ltcoe.edu.in',    'faculty123', 'Faculty', 'Prof. R. Deshmukh',  'RD', 'Information Technology', '9820002002'),
  ('s.kulkarni@ltcoe.edu.in',    'faculty123', 'Faculty', 'Prof. S. Kulkarni',  'SK', 'Electronics & Telecomm', '9820002003'),
  ('p.joshi@ltcoe.edu.in',       'faculty123', 'Faculty', 'Prof. P. Joshi',     'PJ', 'Mechanical Engineering', '9820002004'),
  ('m.patil@ltcoe.edu.in',       'faculty123', 'Faculty', 'Prof. M. Patil',     'MP', 'Civil Engineering', '9820002005'),
  ('v.iyer@ltcoe.edu.in',        'faculty123', 'Faculty', 'Prof. V. Iyer',      'VI', 'Computer Engineering', '9820002006'),
  ('d.bhosale@ltcoe.edu.in',     'faculty123', 'Faculty', 'Prof. D. Bhosale',   'DB', 'Information Technology', '9820002007');

-- ── Student Users (Multiple Students) ───────────────────────
INSERT OR IGNORE INTO users (email, password, role, name, initials, department, phone) VALUES
  ('student@ltcoe.edu.in',       'student123', 'Student', 'Vedant Pawar',       'VP', 'Computer Engineering', '9876543210'),
  ('purva@ltcoe.edu.in',         'student123', 'Student', 'Purva Pankar',       'PP', 'Computer Engineering', '9876543211'),
  ('shruti@ltcoe.edu.in',        'student123', 'Student', 'Shruti Waykole',     'SW', 'Computer Engineering', '9876543212'),
  ('swayam@ltcoe.edu.in',        'student123', 'Student', 'Swayam Telang',      'ST', 'Computer Engineering', '9876543213'),
  ('aditya@ltcoe.edu.in',        'student123', 'Student', 'Aditya Sharma',      'AS', 'Information Technology', '9876543214'),
  ('sneha@ltcoe.edu.in',         'student123', 'Student', 'Sneha More',         'SM', 'Information Technology', '9876543215'),
  ('amit@ltcoe.edu.in',          'student123', 'Student', 'Amit Patil',         'AP', 'Mechanical Engineering', '9876543219');

-- ── Students / Applications ─────────────────────────────────
INSERT OR IGNORE INTO students (roll, first, last, email, phone, branch, year, gender, dob, address, school, score, status, applied) VALUES
  ('CE001',   'Vedant',  'Pawar',    'vedant@ltcoe.edu.in',  '9876543210', 'CE',   'SE', 'Male',   '2004-03-15', 'Pune, Maharashtra',       'Fergusson College Jr.',  '88.4%', 'Approved', '2025-07-01'),
  ('CE002',   'Purva',   'Pankar',   'purva@ltcoe.edu.in',   '9876543211', 'CE',   'SE', 'Female', '2004-05-20', 'Nagpur, Maharashtra',     'Hislop College Jr.',     '91.2%', 'Approved', '2025-07-01'),
  ('CE003',   'Shruti',  'Waykole',  'shruti@ltcoe.edu.in',  '9876543212', 'CE',   'SE', 'Female', '2004-08-11', 'Nashik, Maharashtra',     'Nashik Public Jr.',      '85.0%', 'Approved', '2025-07-02'),
  ('CE004',   'Swayam',  'Telang',   'swayam@ltcoe.edu.in',  '9876543213', 'CE',   'SE', 'Male',   '2004-01-30', 'Mumbai, Maharashtra',     'Elphinstone Jr.',        '87.8%', 'Approved', '2025-07-03'),
  ('IT001',   'Aditya',  'Sharma',   'aditya@ltcoe.edu.in',  '9876543214', 'IT',   'SE', 'Male',   '2004-06-22', 'Pune, Maharashtra',       'Nowrosjee Wadia Jr.',    '82.6%', 'Approved', '2025-07-05'),
  ('IT002',   'Sneha',   'More',     'sneha@ltcoe.edu.in',   '9876543215', 'IT',   'TE', 'Female', '2003-09-14', 'Aurangabad, Maharashtra', 'BAMU Jr.',               '79.4%', 'Approved', '2025-07-06'),
  ('CE005',   'Rahul',   'Desai',    'rahul@ltcoe.edu.in',   '9876543216', 'CE',   'TE', 'Male',   '2003-11-05', 'Solapur, Maharashtra',    'DAV Public Jr.',         '76.2%', 'Pending',  '2025-07-10'),
  ('CE006',   'Priya',   'Kulkarni', 'priya@ltcoe.edu.in',   '9876543217', 'CE',   'BE', 'Female', '2002-02-18', 'Kolhapur, Maharashtra',   'Shivaji Univ Jr.',       '93.1%', 'Pending',  '2025-07-12'),
  ('ENTC001', 'Rohan',   'Joshi',    'rohan@ltcoe.edu.in',   '9876543218', 'ENTC', 'SE', 'Male',   '2004-04-07', 'Pune, Maharashtra',       'MIT Jr.',                '74.0%', 'Rejected', '2025-07-08'),
  ('Mech001', 'Amit',    'Patil',    'amit@ltcoe.edu.in',    '9876543219', 'Mech', 'SE', 'Male',   '2004-07-19', 'Satara, Maharashtra',     'Satara Jr.',             '80.5%', 'Approved', '2025-07-14'),
  ('CE007',   'Kavya',   'Nair',     'kavya@ltcoe.edu.in',   '9876543220', 'CE',   'FE', 'Female', '2005-12-03', 'Thane, Maharashtra',      'Thane Jr.',              '95.2%', 'Pending',  '2025-07-15'),
  ('IT003',   'Manish',  'Gupta',    'manish@ltcoe.edu.in',  '9876543221', 'IT',   'SE', 'Male',   '2004-09-12', 'Pune, Maharashtra',       'Loyola Jr.',             '83.7%', 'Approved', '2025-07-16'),
  ('CE008',   'Ananya',  'Singh',    'ananya@ltcoe.edu.in',  '9876543222', 'CE',   'TE', 'Female', '2003-06-25', 'Mumbai, Maharashtra',     'St. Xavier Jr.',         '90.5%', 'Approved', '2025-07-17'),
  ('ENTC002', 'Tushar',  'Wagh',     'tushar@ltcoe.edu.in',  '9876543223', 'ENTC', 'SE', 'Male',   '2004-02-14', 'Pune, Maharashtra',       'Symbiosis Jr.',          '77.8%', 'Approved', '2025-07-18');

-- Seed attendance for approved students across 7 days
INSERT OR IGNORE INTO attendance_log (date, student_id, subject, status) VALUES
  ('2025-07-14', 1, 'General Session', 'P'), ('2025-07-14', 2, 'General Session', 'P'),
  ('2025-07-14', 3, 'General Session', 'A'), ('2025-07-14', 4, 'General Session', 'P'),
  ('2025-07-14', 5, 'General Session', 'A'), ('2025-07-14', 6, 'General Session', 'P'),
  ('2025-07-14', 10,'General Session', 'P'),

  ('2025-07-15', 1, 'General Session', 'P'), ('2025-07-15', 2, 'General Session', 'A'),
  ('2025-07-15', 3, 'General Session', 'P'), ('2025-07-15', 4, 'General Session', 'P'),
  ('2025-07-15', 5, 'General Session', 'A'), ('2025-07-15', 6, 'General Session', 'P'),
  ('2025-07-15', 10,'General Session', 'P'),

  ('2025-07-16', 1, 'General Session', 'P'), ('2025-07-16', 2, 'General Session', 'P'),
  ('2025-07-16', 3, 'General Session', 'P'), ('2025-07-16', 4, 'General Session', 'A'),
  ('2025-07-16', 5, 'General Session', 'P'), ('2025-07-16', 6, 'General Session', 'A'),
  ('2025-07-16', 10,'General Session', 'P'),

  ('2025-07-17', 1, 'General Session', 'P'), ('2025-07-17', 2, 'General Session', 'P'),
  ('2025-07-17', 3, 'General Session', 'A'), ('2025-07-17', 4, 'General Session', 'P'),
  ('2025-07-17', 5, 'General Session', 'A'), ('2025-07-17', 6, 'General Session', 'P'),
  ('2025-07-17', 10,'General Session', 'A'),

  ('2025-07-18', 1, 'General Session', 'P'), ('2025-07-18', 2, 'General Session', 'P'),
  ('2025-07-18', 3, 'General Session', 'P'), ('2025-07-18', 4, 'General Session', 'P'),
  ('2025-07-18', 5, 'General Session', 'A'), ('2025-07-18', 6, 'General Session', 'A'),
  ('2025-07-18', 10,'General Session', 'P'),

  ('2025-07-21', 1, 'General Session', 'A'), ('2025-07-21', 2, 'General Session', 'P'),
  ('2025-07-21', 3, 'General Session', 'P'), ('2025-07-21', 4, 'General Session', 'P'),
  ('2025-07-21', 5, 'General Session', 'A'), ('2025-07-21', 6, 'General Session', 'P'),
  ('2025-07-21', 10,'General Session', 'P'),

  ('2025-07-22', 1, 'General Session', 'P'), ('2025-07-22', 2, 'General Session', 'P'),
  ('2025-07-22', 3, 'General Session', 'P'), ('2025-07-22', 4, 'General Session', 'A'),
  ('2025-07-22', 5, 'General Session', 'A'), ('2025-07-22', 6, 'General Session', 'P'),
  ('2025-07-22', 10,'General Session', 'P');

-- Additional attendance for new students
INSERT OR IGNORE INTO attendance_log (date, student_id, subject, status) VALUES
  ('2025-07-14', 12, 'General Session', 'P'), ('2025-07-14', 13, 'General Session', 'P'), ('2025-07-14', 14, 'General Session', 'A'),
  ('2025-07-15', 12, 'General Session', 'A'), ('2025-07-15', 13, 'General Session', 'P'), ('2025-07-15', 14, 'General Session', 'P'),
  ('2025-07-16', 12, 'General Session', 'P'), ('2025-07-16', 13, 'General Session', 'A'), ('2025-07-16', 14, 'General Session', 'P'),
  ('2025-07-17', 12, 'General Session', 'P'), ('2025-07-17', 13, 'General Session', 'P'), ('2025-07-17', 14, 'General Session', 'P'),
  ('2025-07-18', 12, 'General Session', 'P'), ('2025-07-18', 13, 'General Session', 'P'), ('2025-07-18', 14, 'General Session', 'A'),
  ('2025-07-21', 12, 'General Session', 'A'), ('2025-07-21', 13, 'General Session', 'P'), ('2025-07-21', 14, 'General Session', 'P'),
  ('2025-07-22', 12, 'General Session', 'P'), ('2025-07-22', 13, 'General Session', 'A'), ('2025-07-22', 14, 'General Session', 'P');

-- ── Seed Announcements ───────────────────────────────────────
INSERT OR IGNORE INTO announcements (title, body, category, posted_by, created_at, priority) VALUES
  ('Mid-Semester Examination Schedule Released', 'The mid-semester exams for all SE and TE students will commence from August 15, 2025. Detailed timetable is available on the notice board.', 'Exam', 'Prof. M. Umale', '2025-07-20', 'high'),
  ('Annual Tech Fest — CodeStorm 2025', 'LTCOE is proudly hosting CodeStorm 2025 on September 5-6. Registrations open for Hackathon, Paper Presentation, and Robotics competitions.', 'Event', 'Prof. A. Sharma', '2025-07-19', 'normal'),
  ('Library Hours Extended During Exams', 'The central library will remain open from 8 AM to 10 PM during the examination period. All students are encouraged to utilize the study spaces.', 'General', 'Prof. R. Deshmukh', '2025-07-18', 'normal'),
  ('Attendance Below 75% — Final Warning', 'Students with attendance below 75% as of July 22 must submit their attendance regularization forms within 3 working days to avoid being detained.', 'Important', 'Prof. M. Umale', '2025-07-22', 'urgent'),
  ('Industry Visit — Infosys Pune', 'An industry visit to Infosys Pune campus is scheduled for August 3, 2025. SE and TE Computer Engineering students are eligible. Register by July 30.', 'Event', 'Prof. V. Iyer', '2025-07-17', 'normal'),
  ('New Lab Equipment Installed', 'The ENTC Department has received new signal processing lab equipment. Lab sessions will resume with updated experiments from next week.', 'General', 'Prof. S. Kulkarni', '2025-07-16', 'low');

-- ── Seed Timetable (SE - Computer Engineering) ──────────────
INSERT OR IGNORE INTO timetable (day, time_slot, subject, faculty, room, branch, year) VALUES
  ('Monday',    '09:00 - 10:00', 'Theory of Computation',  'Prof. A. Sharma',   'Room 301', 'CE', 'SE'),
  ('Monday',    '10:00 - 11:00', 'Database Systems',       'Prof. V. Iyer',     'Room 302', 'CE', 'SE'),
  ('Monday',    '11:15 - 12:15', 'Web Technology',         'Prof. D. Bhosale',  'Lab 201',  'CE', 'SE'),
  ('Monday',    '01:00 - 02:00', 'Computer Networks',      'Prof. R. Deshmukh', 'Room 303', 'CE', 'SE'),
  ('Tuesday',   '09:00 - 10:00', 'Software Engineering',   'Prof. M. Patil',    'Room 301', 'CE', 'SE'),
  ('Tuesday',   '10:00 - 11:00', 'Operating Systems',      'Prof. A. Sharma',   'Room 302', 'CE', 'SE'),
  ('Tuesday',   '11:15 - 12:15', 'Theory of Computation',  'Prof. A. Sharma',   'Room 301', 'CE', 'SE'),
  ('Tuesday',   '01:00 - 03:00', 'Database Lab',           'Prof. V. Iyer',     'Lab 101',  'CE', 'SE'),
  ('Wednesday', '09:00 - 10:00', 'Computer Networks',      'Prof. R. Deshmukh', 'Room 303', 'CE', 'SE'),
  ('Wednesday', '10:00 - 11:00', 'Web Technology',         'Prof. D. Bhosale',  'Lab 201',  'CE', 'SE'),
  ('Wednesday', '11:15 - 12:15', 'Database Systems',       'Prof. V. Iyer',     'Room 302', 'CE', 'SE'),
  ('Wednesday', '01:00 - 03:00', 'Web Technology Lab',     'Prof. D. Bhosale',  'Lab 201',  'CE', 'SE'),
  ('Thursday',  '09:00 - 10:00', 'Operating Systems',      'Prof. A. Sharma',   'Room 302', 'CE', 'SE'),
  ('Thursday',  '10:00 - 11:00', 'Software Engineering',   'Prof. M. Patil',    'Room 301', 'CE', 'SE'),
  ('Thursday',  '11:15 - 01:15', 'CN Lab',                 'Prof. R. Deshmukh', 'Lab 102',  'CE', 'SE'),
  ('Friday',    '09:00 - 10:00', 'Theory of Computation',  'Prof. A. Sharma',   'Room 301', 'CE', 'SE'),
  ('Friday',    '10:00 - 11:00', 'Computer Networks',      'Prof. R. Deshmukh', 'Room 303', 'CE', 'SE'),
  ('Friday',    '11:15 - 12:15', 'Software Engineering',   'Prof. M. Patil',    'Room 301', 'CE', 'SE'),
  ('Friday',    '01:00 - 03:00', 'OS Lab',                 'Prof. A. Sharma',   'Lab 103',  'CE', 'SE');

-- ── Seed Timetable (SE - IT) ────────────────────────────────
INSERT OR IGNORE INTO timetable (day, time_slot, subject, faculty, room, branch, year) VALUES
  ('Monday',    '09:00 - 10:00', 'Data Structures',        'Prof. R. Deshmukh', 'Room 401', 'IT', 'SE'),
  ('Monday',    '10:00 - 11:00', 'Discrete Mathematics',   'Prof. D. Bhosale',  'Room 402', 'IT', 'SE'),
  ('Monday',    '11:15 - 12:15', 'Object Oriented Prog.',  'Prof. V. Iyer',     'Lab 301',  'IT', 'SE'),
  ('Tuesday',   '09:00 - 10:00', 'Digital Electronics',    'Prof. S. Kulkarni', 'Room 401', 'IT', 'SE'),
  ('Tuesday',   '10:00 - 11:00', 'Data Structures',        'Prof. R. Deshmukh', 'Room 402', 'IT', 'SE'),
  ('Wednesday', '09:00 - 10:00', 'Object Oriented Prog.',  'Prof. V. Iyer',     'Lab 301',  'IT', 'SE'),
  ('Wednesday', '10:00 - 11:00', 'Discrete Mathematics',   'Prof. D. Bhosale',  'Room 402', 'IT', 'SE'),
  ('Thursday',  '09:00 - 10:00', 'Data Structures',        'Prof. R. Deshmukh', 'Room 401', 'IT', 'SE'),
  ('Thursday',  '10:00 - 11:00', 'Digital Electronics',    'Prof. S. Kulkarni', 'Room 402', 'IT', 'SE'),
  ('Friday',    '09:00 - 10:00', 'Discrete Mathematics',   'Prof. D. Bhosale',  'Room 402', 'IT', 'SE'),
  ('Friday',    '10:00 - 11:00', 'Object Oriented Prog.',  'Prof. V. Iyer',     'Lab 301',  'IT', 'SE');

-- ── Seed Feedback ────────────────────────────────────────────
INSERT OR IGNORE INTO feedback (student_id, student_name, subject, rating, comment, created_at) VALUES
  (1, 'Vedant Pawar',   'Theory of Computation', 5, 'Prof. Sharma explains concepts brilliantly with real-world examples.', '2025-07-20'),
  (2, 'Purva Pankar',   'Database Systems',      4, 'Very practical approach, loved the SQL exercises.', '2025-07-20'),
  (3, 'Shruti Waykole', 'Web Technology',         5, 'The projects are amazing, learned a lot about modern web dev.', '2025-07-21'),
  (4, 'Swayam Telang',  'Computer Networks',      3, 'Good content but pace is a bit fast sometimes.', '2025-07-21'),
  (5, 'Aditya Sharma',  'Data Structures',        4, 'Great visualization of algorithms, very helpful.', '2025-07-19'),
  (1, 'Vedant Pawar',   'Operating Systems',      4, 'Process scheduling concepts were well explained.', '2025-07-22'),
  (2, 'Purva Pankar',   'Software Engineering',   5, 'Real case studies made the subject very interesting.', '2025-07-22');
