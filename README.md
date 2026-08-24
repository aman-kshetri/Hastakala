# Hastakala

Hastakala is a Java Servlet/JSP based e-commerce web application for handcrafted products, with separate customer and admin flows.

## Features

- User authentication (register, login, logout)
- Role-based access control (`CUSTOMER` and `ADMIN`)
- Product catalog with categories
- Shopping cart and checkout flow
- Order placement and order confirmation
- Customer profile and order history
- Admin dashboards for users, products, categories, orders, and reports

## Tech Stack

- Java 21
- Jakarta/Javax Servlet 3.1 + JSP + JSTL
- MySQL
- Apache Tomcat 8.5
- BCrypt (`jbcrypt`) for password hashing

## Project Structure

```text
src/main/java
├── controller
├── dao
├── filter
├── model
├── service
└── util

src/main/webapp
├── css
├── uploads
├── views
├── WEB-INF
│   ├── lib
│   └── web.xml
└── init.sql
```

## Prerequisites

- JDK 21
- MySQL Server (8.x recommended)
- Apache Tomcat 8.5
- Eclipse (Enterprise Java) or any IDE that supports Dynamic Web Projects

## Setup and Run

1. **Clone and import**
   - Open the project as an existing Eclipse Dynamic Web Project.
2. **Create database**
   - Run `/src/main/webapp/init.sql` in MySQL to create schema and tables.
3. **Configure database connection**
   - Update `/src/main/java/util/DBUtils.java`:
     - `DB_URL`
     - `DB_USER`
     - `DB_PASSWORD`
4. **Configure server**
   - Add Apache Tomcat 8.5 runtime in your IDE.
   - Deploy the project to Tomcat.
5. **Run application**
   - Start Tomcat and open:
     - `http://localhost:8080/ecommerce/`

## Notes

- Static dependencies are included under `src/main/webapp/WEB-INF/lib`.
- Session protection is enforced by `SessionFilter` for admin/customer routes.
