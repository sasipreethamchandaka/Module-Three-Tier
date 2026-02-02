![Uploading architecture.gif…]()

# Book Three-Tier Application on AWS (Custom Setup)

This repository showcases a production-style **three-tier web application**
(Frontend, Backend, and Database) deployed on AWS using a **custom infrastructure approach**.

It’s designed for hands-on **DevOps practice** and to explore real-world cloud architecture patterns.

---

## Application Architecture

The application follows a classic three-tier architecture:

- **Presentation Layer**: React (Frontend)
- **Application Layer**: Node.js + Express (Backend API)
- **Database Layer**: MySQL (Amazon RDS)

---

## High-Level Architecture Flow

User  
|  
Frontend Load Balancer (Public)  
|  
React Frontend (Private EC2 with Nginx)  
|  
Backend Load Balancer (Public or Internal)  
|  
Node.js Backend (Private EC2)  
|  
Amazon RDS (MySQL in Private Subnets)

---

## Tech Stack

### Frontend
- React
- Nginx

### Backend
- Node.js
- Express
- PM2

### Database
- MySQL
- Amazon RDS

### Cloud & Networking
- AWS EC2
- Application Load Balancer
- VPC with Public and Private Subnets

---

## Repository Structure

Book_Three_Tier_Application_infra  
├── Frontend-Backend_code  
│   ├── backend  
│   │   ├── index.js  
│   │   ├── package.json  
│   │   ├── package-lock.json  
│   │   └── test.sql  
│   └── client  
│       ├── build  
│       ├── public  
│       ├── src  
│       ├── entrypoint.sh  
│       ├── proxy.conf  
│       ├── package.json  
│       └── package-lock.json  

---

## Prerequisites

- AWS Account
- Amazon Linux EC2 instances
- Node.js
- Nginx
- MySQL client
- Basic AWS networking knowledge

---

## Infrastructure Setup (High-Level)

1. Create a **VPC** with both public and private subnets.  
2. Deploy **MySQL RDS** in private subnets.  
3. Launch **Backend EC2 instance** in a private subnet.  
4. Launch **Frontend EC2 instance** in a private subnet.  
5. Configure **Backend Load Balancer** and Target Group.  
6. Configure **Frontend Load Balancer** and Target Group.  

> **Note:** Without a reverse proxy, load balancers should be internet-facing.

---

## Database Setup (Backend Server)

### Clone the repository:
``` bash
git clone https://github.com/sasipreethamchandaka/Module-Three-Tier.git  
cd Frontend-Backend_code/backend  
```
### Create `.env` file:
``` bash
DB_HOST=<your-rds-endpoint>  
DB_USERNAME=admin  
DB_PASSWORD=<your-password>  
PORT=3306  
DATABASE=<database-name>
```
### Install MySQL client:
``` bash
sudo yum install mariadb105-server -y  
```
### Import database:
``` bash
mysql -h <your-rds-endpoint> -u admin -p < test.sql  
```
---

## Backend Deployment
``` bash
sudo dnf install -y nodejs  
npm install  
npm install dotenv  
npm install -g pm2  

pm2 start index.js --name book-backend  
pm2 startup
sudo systemctl enable pm2-root
pm2 save  
```
Backend should be reachable via the Backend Load Balancer DNS.

---

## Frontend Deployment

Clone the repository:
``` bash
git clone https://github.com/mahimapatel93/Book_Three_Tier_Application_infra.git  
cd Frontend-Backend_code/client  
```
Update backend API URL:
``` bash
vi client/src/pages/config.js
const API_BASE_URL = "http://<backend-load-balancer-dns>";
```
Install and build frontend:
``` bash
sudo dnf install -y nodejs
sudo yum install nginx -y
sudo systemctl start nginx
sudo systemctl enable --now nginx  

npm install  
npm run build  
sudo cp -r build/* /usr/share/nginx/html  
```
Frontend is accessible via the Frontend Load Balancer DNS.

---

##  Optional: Reverse Proxy (Internal Load Balancer)
**If backend is behind an internal load balancer, configure Nginx reverse proxy.**

###Files
- proxy.conf — Nginx server block (this file)

Update config.js
```bash
const API_BASE_URL = "/api";
```
Create Nginx Config
```bash
sudo vi /etc/nginx/conf.d/reverse-proxy.conf
```
```bash
server {
    listen 80;
    server_name _;

    # 🔥  API reverse proxy (WITH PATH FIX)
    location ^~ /api/ {
        proxy_pass http://backend-loadbalncer-url/;
        proxy_http_version 1.1;

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    # React build
    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
```
Reload Nginx
```bash
sudo nginx -tsudo systemctl reload nginx
```
---

## Verification Checklist

- Backend API reachable
- Frontend UI loads correctly
- Data fetched from MySQL RDS
- /api/books endpoint works
- No CORS or networking issues

---

## Author

**Mahima Patel** 
DevOps & Cloud Engineering   

GitHub: https://github.com/sasipreethamchandaka

