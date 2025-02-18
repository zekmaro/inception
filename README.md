# Inception - A Dockerized System Architecture

## 🛠️ Project Overview

`Inception` is a system administration project from the 42 curriculum that involves setting up a full-fledged containerized infrastructure using Docker. This project demonstrates proficiency in Docker, container orchestration, and system management by setting up various services inside Docker containers.

## 🚀 Features
- **Containerized Services** - Uses Docker to manage system services.
- **Docker Compose** - Automates multi-container deployment.
- **Nginx Reverse Proxy** - Manages incoming HTTP requests.
- **MariaDB Database** - Provides a structured data storage solution.
- **WordPress Installation** - Implements a web application with database integration.
- **Secure Connections** - Utilizes SSL/TLS for encrypted communication.
- **Persistent Volumes** - Ensures data persistence across container restarts.
- **Multi-User Setup** - Configures system users and access management.
- **Resource Isolation** - Containers ensure minimal interference between services.

## 📥 Installation & Setup
### Prerequisites
- Linux-based OS (Ubuntu, Debian, or macOS with Docker)
- Installed versions of:
  - `Docker`
  - `Docker Compose`

### Setup Instructions
1. Clone the repository:
   ```sh
   git clone https://github.com/zekmaro/inception.git
   cd inception
   ```
2. Build and start the containers:
   ```sh
   docker-compose up --build -d
   ```
3. Access the services:
   - **WordPress Site:** `https://localhost`
   - **Database:** `mariadb://localhost:3306`
   - **Admin Panel:** `https://localhost/wp-admin`

### Stopping the Containers
```sh
docker-compose down
```

## 📸 Adding a Demo
To include a demonstration of the setup:
1. Record a session using `asciinema`:
   ```sh
   asciinema rec inception-demo.cast
   ```
2. Upload to [asciinema.org](https://asciinema.org) and link it:
   ```md
   [Watch Inception Demo](https://asciinema.org/a/YOUR_RECORDING_LINK)
   ```

## 🏗️ Project Structure
```
📂 inception/
 ├── 📂 srcs/          # Source files for containers
 │   ├── 📂 nginx/     # Reverse proxy setup
 │   ├── 📂 mariadb/   # Database configuration
 │   ├── 📂 wordpress/ # CMS installation
 │   ├── .env         # Environment variables
 │   ├── docker-compose.yml # Docker Compose setup
```

## 🏆 Skills & Technologies
- **Docker & Docker Compose** - Containerized infrastructure.
- **Nginx** - Reverse proxy & SSL configuration.
- **MariaDB** - SQL database management.
- **WordPress** - CMS setup and customization.
- **Linux System Administration** - Managing services and users.
- **Network Security** - SSL/TLS and secure configurations.

## 🎯 Future Enhancements
- Automate SSL certificate renewal using Certbot.
- Implement monitoring and logging with Prometheus & Grafana.
- Expand with Redis caching for improved performance.

## 🏆 Credits
- **Developer:** [zekmaro](https://github.com/zekmaro)
- **Project:** Part of the 42 School curriculum
- **Technologies:** Docker, Nginx, MariaDB, WordPress

---
💻 Feel free to explore and improve this containerized infrastructure. Contributions and feedback are welcome!

