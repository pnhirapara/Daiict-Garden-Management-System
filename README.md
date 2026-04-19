# 🌿 Garden Management System

*A DBMS project to efficiently manage gardening operations, staff, equipment, and sales — organized, scalable, and data-driven.*

---

## 📚 Project Overview

The **Garden Management System** is a relational database project designed to manage and optimize operations in a large-scale garden or nursery environment.

It provides a centralized platform for:

* 🌱 **Staff Management** – Track supervisors and gardening staff across departments
* 🛠️ **Equipment Tracking** – Maintain records of tools, machines, and maintenance
* 🌳 **Plant & Tree Monitoring** – Store species, growth, and plantation data
* 🛒 **Sales Management** – Handle customers, transactions, and product sales
* 🔁 **Integrated Workflow** – Connect staff, equipment, and operations seamlessly

> "The goal is to bring structure and efficiency to garden operations using relational database design."

---

## 🛠️ Features

* 🧱 Well-structured relational schema with constraints
* 🔗 Use of foreign keys & referential integrity
* 📊 ER diagram and relational model
* 📄 Modular SQL scripts (DDL + insertions + queries)
* 🔍 Advanced SQL queries (joins, subqueries, window functions)
* 🧪 Tested on PostgreSQL / MySQL

---

## 🧾 Folder Structure

```
Garden-Management-System/
├── Data
│ └── insert_data.sql
├── DDL
│ └── create_tables.sql
├── Design
│ ├── ER-model
│ │ ├── ERD.drawio
│ │ └── ERD.pdf
│ └── Relational-model-normalization-proof
│    ├── Relational_schema_and_normalization_proof
├── Queries
│ └── queries.sql
├── Report
│ └── Final_Report.pdf
└── README.md

```

---

## 🚀 Getting Started

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/pnhirapara/DAIICT-Green-Campus-Management.git
cd DAIICT-Green-Campus-Management
```

### 2️⃣ Create Tables & Insert Data

```sql
SOURCE DDL/create_tables.sql;
SOURCE Data/insert_data.sql;
```

### 3️⃣ Run Queries

```sql
SOURCE Queries/queries.sql;
```

---

## 🔍 Highlight Queries

Some of the most meaningful queries in this project include:

* ✅ **Department Analysis** – Count staff in each department
* 🔧 **Equipment Insights** – Find equipment needing repair or used daily
* 👨‍🌾 **Staff Tracking** – Retrieve staff under specific supervisors
* 📈 **Sales Analysis** – Top customers and total revenue by manager
* 🌳 **Tree Insights** – Identify trees with above-average height
* 📊 **Maintenance Cost Analysis** – Total cost by equipment type

---

## 🧠 Learning & Challenges

> "Designing a complex schema with multiple interconnected entities was challenging but highly rewarding."

During this project, we:

* ✔ Improved SQL fluency and schema design thinking
* ✔ Understood normalization (1NF → BCNF) through implementation
* ✔ Learned debugging complex queries
* ✔ Applied referential integrity constraints
* ✔ Gained teamwork and project structuring experience

---

## 👨‍🎓 Team

| Name      | ID    |
| --------- | ----- |
| Preet Hirapara | 202403013 |
| Vinus Moradiya  | 202403060 |

**Course:** DBMS (Database Management Systems) 

**Institute:** DA-IICT 

**Guide:** Prof. Minal Bhise 

---

## 📜 License

This project is for **academic purposes only** and intended for learning and demonstration.

---

> "Built with logic, consistency, and a lot of SQL debugging." 🌱
