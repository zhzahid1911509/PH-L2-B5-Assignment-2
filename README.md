### ২. What is the purpose of a database schema in PostgreSQL?)

**উত্তর:**

PostgreSQL-এ **স্কিমা (Schema)** হলো একটি লজিকাল কন্টেইনার যা টেবিল, ভিউ, ইনডেক্স, ফাংশন, সিকুয়েন্স ইত্যাদি অবজেক্ট সংগঠিতভাবে সংরক্ষণ করে। এটি ডেটাবেসের ভেতরে অবজেক্টগুলোকে গ্রুপ করে রাখে এবং একই নামের সংঘর্ষ (name conflict) এড়াতে সাহায্য করে।

**উদ্দেশ্যসমূহঃ**

* ডেটাবেসে অবজেক্ট সংগঠিতভাবে রাখতে
* একই ডেটাবেসে বিভিন্ন ইউজারের জন্য আলাদা নেমস্পেস তৈরি করতে
* নিরাপত্তা ও পারমিশন কন্ট্রোল সহজ করতে

**উদাহরণ:**

```sql
CREATE SCHEMA accounts;

CREATE TABLE accounts.users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50)
);
```

উপরের কোডে `accounts` নামে একটি স্কিমা তৈরি করা হয়েছে এবং তার মধ্যে `users` নামক টেবিল তৈরি করা হয়েছে।

---

### ৩. Explain the Primary Key and Foreign Key concepts in PostgreSQL.

**উত্তর:**

**Primary Key (প্রাইমারি কী):**
এটি একটি বা একাধিক কলাম যা প্রতিটি রেকর্ডকে ইউনিকভাবে শনাক্ত করে। এটি কখনো NULL হতে পারে না এবং প্রতিটি ভ্যালু ইউনিক হতে হবে।

**Foreign Key (ফরেইন কী):**
এটি এমন একটি কী যা অন্য টেবিলের প্রাইমারি কী-এর রেফারেন্স রাখে। এটি টেবিলগুলোর মধ্যে সম্পর্ক তৈরি করে।

**উদাহরণ:**

```sql
-- Parent টেবিল
CREATE TABLE departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- Child টেবিল
CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
```

এখানে `employees` টেবিলের `dept_id` একটি ফরেইন কী যা `departments` টেবিলের `dept_id` প্রাইমারি কী-কে রেফারেন্স করছে।

---

### ৪. What is the difference between the `VARCHAR` and `CHAR` data types?

**উত্তর:**

| বৈশিষ্ট্য         | `CHAR(n)`                       | `VARCHAR(n)`                       |
| ----------------- | ------------------------------- | ---------------------------------- |
| দৈর্ঘ্য           | নির্দিষ্ট দৈর্ঘ্যের ফিক্সড সাইজ | সর্বোচ্চ দৈর্ঘ্যের ফ্লেক্সিবল সাইজ |
| স্টোরেজ           | ফাঁকা জায়গা পূরণ করে            | যতটুকু লাগে ততটুকু নেয়             |
| পারফরম্যান্স      | দ্রুত (ছোট ফিক্সড সাইজে)        | কিছুটা ধীর                         |
| ব্যবহারের ক্ষেত্র | কোড, ফিক্সড-লেন্থ ফিল্ড         | নাম, ঠিকানা ইত্যাদি ভেরিয়েবল ডেটা  |

**উদাহরণ:**

```sql
CREATE TABLE test1 (
    name CHAR(10)
);

CREATE TABLE test2 (
    name VARCHAR(10)
);
```

`CHAR(10)` হলে "Zahid" ইনসার্ট করলে সেটি `Zahid     ` (5টি স্পেসসহ) হয়ে যাবে, কিন্তু `VARCHAR(10)` হলে শুধুই "Zahid" থাকবে।

---

### ৫. Explain the purpose of the `WHERE` clause in a `SELECT` statement.

**উত্তর:**

`WHERE` ক্লজ ব্যবহার করা হয় `SELECT`, `UPDATE`, বা `DELETE` স্টেটমেন্টে রেকর্ড ফিল্টার করার জন্য। এটি এমন শর্ত নির্ধারণ করে যা পূরণ করে এমন রেকর্ডগুলোকেই প্রসেস করা হয়।

**উদাহরণ:**

```sql
SELECT * FROM employees
WHERE dept_id = 2;
```

উপরের কোয়েরিটি `employees` টেবিল থেকে শুধু সেইসব রেকর্ড রিটার্ন করবে যাদের `dept_id` = 2।

---

### ৬. What are the `LIMIT` and `OFFSET` clauses used for?

**উত্তর:**

* **LIMIT**: কতগুলো রেকর্ড রিটার্ন করতে হবে তা নির্ধারণ করে।
* **OFFSET**: কতগুলো রেকর্ড স্কিপ করতে হবে তা নির্ধারণ করে।

এগুলো সাধারণত পেজিনেশন বা সীমিত সংখ্যক রেজাল্ট দেখানোর জন্য ব্যবহার করা হয়।

**উদাহরণ:**

```sql
SELECT * FROM employees
ORDER BY emp_id
LIMIT 5 OFFSET 10;
```

এখানে, প্রথম ১০টি রেকর্ড স্কিপ করে পরের ৫টি রেকর্ড দেখাবে।

---

