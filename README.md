# Relational Database & Inventory Management System

A full-stack inventory solution designed to transition manual tracking into a robust, digital catalog. This project focuses on high-integrity database design, modular Python architecture, and a reactive user interface for non-technical stakeholders.

##  Technical Stack & Tooling

* **Database:** `MySQL` / `MariaDB` for relational data storage and complex querying.
* **Frontend:** `Streamlit` for building a reactive, Python-based Graphical User Interface (GUI).
* **ORM/Connector:** `SQLAlchemy` & `PyMySQL` to facilitate secure communication between Python and the SQL backend.
* **Environment Management:** `Conda` (Miniconda) for creating isolated, version-controlled dependency environments.
* **Data Handling:** `Pandas` for in-memory data transformation and processing.
* **Development Suite:** `Visual Studio Code (VS Code)` utilizing the integrated terminal and Python extension for linting and debugging.



---

## Database Architecture (3NF)

The backbone of this application is a relational database engineered for **Data Integrity** and **Scalability**.

### 1. Normalization Strategy
The schema was developed following **Third Normal Form (3NF)** principles to eliminate data redundancy and anomalies:
* **1NF (Atomicity):** Ensured each field contains only one value; standardized data types across all columns.
* **2NF (Partial Dependency):** Isolated core entities (Books, Borrowers) to remove redundancy in the transaction logs.
* **3NF (Transitive Dependency):** Ensured non-key attributes depend solely on the primary key, creating a clean, logical relationship map.

### 2. Constraints & Logic Enforcement
To protect the system against invalid data entry, the following SQL constraints were implemented:
* **Primary & Foreign Keys:** Established strict referential integrity between tables.
* **NOT NULL & UNIQUE:** Guaranteed that critical data points (titles, IDs) are present and distinct.
* **CHECK Constraints:** Embedded business logic at the database level to prevent invalid states (e.g., negative stock counts).



---

## Core Competencies & Abilities Learned

### Relational Data Engineering
* **DDL/DML Proficiency:** Skilled in writing Data Definition Language (DDL) to build schemas and Data Manipulation Language (DML) for complex CRUD operations.
* **Integrity Management:** Learned to use database constraints as a "first line of defense" for data quality.

### Professional Development Workflow
* **Local Stack Mastery:** Successfully transitioned from cloud-based sandboxes (Colab) to a local development environment.
* **CLI Literacy:** Navigating project directories and managing system processes via the Terminal/Command Line.
* **Environment Control:** Using Conda to manage "dependency bubbles," ensuring the project is reproducible on any machine.

### Full-Stack Python Integration
* **Modular Architecture:** Designed scripts using the `main()` function and `if __name__ == "__main__":` idiom for professional, reusable code.
* **Backend Bridging:** Implementing **SQLAlchemy** to safely handle database connections and protect against SQL injection.
* **Reactive GUI Design:** Translating technical database logic into an intuitive, "no-code" experience using Streamlit widgets and forms.



---

## Installation & Local Setup

### 1. Environment Setup
```bash
# Create the environment with all necessary dependencies
conda create -n library-env -c conda-forge python=3.12 streamlit sqlalchemy pandas pymysql

# Activate the project environment
conda activate library-env
