# 🎓 LTCOE Campus — Smart Campus Management System

A premium full-stack campus management platform for **Lokmanya Tilak College of Engineering** (LTCOE). Built with Flask (Python) backend and a modern, responsive single-page frontend.

![Python](https://img.shields.io/badge/Python-3.9+-blue?logo=python)
![Flask](https://img.shields.io/badge/Flask-3.0-green?logo=flask)
![SQLite](https://img.shields.io/badge/SQLite-3-blue?logo=sqlite)
![License](https://img.shields.io/badge/License-MIT-yellow)

## ✨ Features

### 🛡️ Role-Based Access Control
- **Administrator** — Full system access, manage students, admissions, attendance, analytics
- **Faculty** — Mark attendance, manage admissions, view reports, post announcements
- **Student** — Personal dashboard, view attendance, timetable, announcements, submit feedback

### 📋 Admissions Management
- Submit & track student applications
- Approve/Reject applications (Admin & Faculty)
- Auto-generated roll numbers
- Full application history

### ✅ Attendance System
- Mark attendance per subject, year, branch
- Real-time session statistics
- Individual student attendance history
- 7-day attendance trend visualization
- Defaulter detection (below 75%)

### 📊 Analytics & Reports
- Branch-wise attendance breakdown
- Defaulters list
- Full summary tables
- CSV export functionality

### 📢 Announcements
- Post campus-wide notices (Admin & Faculty)
- Categories: General, Exam, Event, Important
- Priority levels: Low, Normal, High, Urgent

### 📅 Timetable
- Weekly class schedule per branch and year
- Faculty and room assignments
- Filterable by branch and year

### 👨‍🏫 Faculty Directory
- Complete faculty listing
- Department and contact info

### 💬 Feedback System
- Students can rate courses (1-5 stars)
- Comment on teaching quality
- Visible to all roles

---

## 🚀 Demo Credentials

| Role | Email | Password |
|------|-------|----------|
| 🛡️ Admin | `admin@ltcoe.edu.in` | `admin123` |
| 👨‍🏫 Faculty | `faculty@ltcoe.edu.in` | `faculty123` |
| 👨‍🏫 Faculty | `r.deshmukh@ltcoe.edu.in` | `faculty123` |
| 👨‍🏫 Faculty | `v.iyer@ltcoe.edu.in` | `faculty123` |
| 🎒 Student | `student@ltcoe.edu.in` | `student123` |
| 🎒 Student | `purva@ltcoe.edu.in` | `student123` |
| 🎒 Student | `aditya@ltcoe.edu.in` | `student123` |

> **Note:** Any faculty member can log in with password `faculty123`, and any student can log in with password `student123`.

---

## 🛠️ Tech Stack

- **Backend:** Python Flask
- **Database:** SQLite3
- **Frontend:** HTML5, CSS3 (Vanilla), JavaScript (ES6+)
- **Fonts:** Google Fonts (Sora, Plus Jakarta Sans, JetBrains Mono)
- **Deployment:** Render / Any Python-compatible platform

---

## 📦 Setup & Installation

### Prerequisites
- Python 3.9+
- pip

### Local Development

```bash
# Clone the repository
git clone https://github.com/huh614/ltcoe-campus.git
cd ltcoe-campus

# Install dependencies
pip install -r requirements.txt

# Run the server
python app.py

# Open browser at http://localhost:5000
```

### Environment Variables
- `PORT` — Server port (default: 5000)

---

## 📁 Project Structure

```
ltcoe-campus/
├── app.py              # Flask backend (API + Static serving)
├── ltcoe.html          # Single-page frontend (HTML + CSS + JS)
├── schema.sql          # SQLite schema + seed data
├── requirements.txt    # Python dependencies
├── Procfile            # Deployment process file
├── README.md           # This file
└── database.db         # Auto-generated SQLite database
```

---

## 🌐 Deployment

The app is configured for deployment on platforms like Render:

1. Set the **Build Command**: `pip install -r requirements.txt`
2. Set the **Start Command**: `gunicorn app:app`
3. The app auto-creates the database on first run

---

## 👥 Team

Built by **Vedant Pawar** and team at LTCOE, Pune.

## 📄 License

MIT License — feel free to use and modify.
