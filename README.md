# Student-Data-Analysis-Project-SQL

## 📌 Overview

This project demonstrates **end-to-end data analysis using SQL**, including:

* Database design
* Data cleaning
* Data transformation
* Analytical queries

The dataset represents a **student management system** with details about students, courses, marks, and attendance.

## 🗂️ Database Schema

### 🔹 Tables Used:

* **Students** → Student details (name, age, gender, course)
* **Courses** → Course information (name, duration)
* **Marks** → Subject-wise marks
* **Attendance** → Attendance percentage
  
## 🏗️ Database Design

✔ Proper normalization<br>
✔ Use of **Primary Keys & Foreign Keys**<br>
✔ Relational structure between tables

## 🧹 Data Cleaning Steps

The dataset contained multiple issues which were cleaned using SQL:

### 🔧 Cleaning Performed:

* Removed duplicate courses
* Standardized student names (TRIM, LOWER)
* Handled missing/invalid ages using average
* Replaced invalid attendance values (<0, >100, 0)
* Filled NULL attendance using average
* Handled missing gender values

## 📊 Key SQL Concepts Used

* **JOINS** (INNER JOIN)
* **GROUP BY & HAVING**
* **Aggregate Functions (AVG, COUNT, MAX)**
* **Subqueries**
* **Window Functions (RANK, SUM OVER)**
* **Data Cleaning Techniques**

## 🔍 Key Analysis Queries

### 📌 Examples:

* Total number of students
* Average marks (overall & per student)
* Top performing students
* Course-wise student distribution
* Subject-wise performance
* Students above average performance
* Ranking students using window functions
* Running total of marks

## 🚀 Advanced Features

* ✅ **Window Functions**

  * RANK()
  * Running Total using SUM() OVER()

* ✅ **Subqueries**

  * Comparing with overall averages

* ✅ **Data Cleaning**

  * Real-world messy data handling

## 📈 Sample Insights

* Identified top-performing students based on average marks
* Found subjects with highest and lowest performance
* Analyzed attendance impact on performance
* Compared course popularity

## 💡 Project Highlights

✔ Real-world dataset with messy data<br>
✔ End-to-end SQL workflow<br>
✔ Strong use of analytical queries<br>
✔ Suitable for **Data Analyst / SQL Developer roles**

## 🛠️ Tools Used

* SQL (MySQL)
* Relational Database Concepts
  
## 🎯 How to Run

1. Create database:
   
CREATE DATABASE student_data;
USE student_data;

3. Create tables
4. Insert dataset
5. Run cleaning queries
6. Execute analysis queries

## 📌 Conclusion

This project showcases the ability to:

* Clean and preprocess raw data
* Design relational databases
* Perform insightful data analysis using SQL



