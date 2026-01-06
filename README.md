# AWS Highly Available Web Application Architecture

## Overview

This repository showcases a highly available, and scalable AWS architecture for hosting a web application using AWS best practices. The design separates public and private resources, minimizes attack surface, and enables controlled internet access for private workloads.

The architecture is deployed in **us-east-1** and uses **VPC, public/private subnets, Application Load Balancer, Auto Scaling, Bastion Host, NAT Gateway, IAM Roles, and S3**.

---

## Architecture Diagram

<img width="1458" height="671" alt="image" src="https://github.com/user-attachments/assets/533514a7-6a49-4b13-9f7b-46650d167fc8" />


---

## Architecture

- Virtual Private Cloud (VPC)
- Public and Private Subnets
- Internet Gateway (IGW)
- Application Load Balancer (ALB)
- Auto Scaling Group (ASG)
- EC2 Instances (Private)
- Bastion Host
- NAT Gateway
- IAM Role
- S3 Bucket

---

## Networking Design

### VPC
The VPC provides network isolation for all resources and controls IP addressing, routing, and security.

---

### Subnets

#### Public Subnets
Public subnets host internet-facing resources:
- Application Load Balancer
- NAT Gateway
- Bastion Host

Public subnets route traffic to the Internet Gateway.

#### Private Subnets
Private subnets host application EC2 instances:
- No direct internet access
- Outbound traffic routed through NAT Gateway

---

## Route Tables

### Public Route Table
| Destination | Target |
|------------|--------|
| 0.0.0.0/0 | Internet Gateway |

Associated with public subnets.

---

### Private Route Table
| Destination | Target |
|------------|--------|
| 0.0.0.0/0 | NAT Gateway |

Associated with private subnets.

---

## Compute Layer

### Application Load Balancer
- Internet-facing
- Distributes incoming traffic across private EC2 instances
- Performs health checks to ensure availability

---

### Auto Scaling Group
- Spans multiple private subnets
- Automatically adjusts capacity based on demand
- Ensures fault tolerance and high availability

---

### EC2 Instances (Private)
- No public IP addresses
- Accessible only via ALB or Bastion Host
- Outbound internet access through NAT Gateway
- Uses IAM Role to access S3

---

## Access & Security

### Bastion Host
- Located in a public subnet
- Used for secure SSH access to private EC2 instances
- Only port 22 is exposed

---

### Security Groups

#### Bastion Host Security Group
- Inbound: SSH (22) from trusted IPs
- Outbound: All traffic

#### ALB Security Group
- Inbound: HTTP/HTTPS from internet
- Outbound: Traffic to private EC2 instances

#### Private EC2 Security Group
- Inbound:
  - Application traffic from ALB
  - SSH from Bastion Host
- Outbound: All traffic

---

## NAT Gateway

- Deployed in a public subnet
- Allows private EC2 instances to access the internet
- Blocks inbound internet connections to private resources

---

## IAM & S3

### IAM Role
- Attached to private EC2 instances
- Grants least-privilege access to S3

### S3 Bucket
- Stores application assets, logs, or backups
- Accessed securely using IAM Role

---

## Traffic Flow

### User Request Flow
1. User sends request to application
2. Request reaches Application Load Balancer
3. ALB forwards traffic to private EC2 instances
4. Response is returned to the user

---

### Outbound Traffic Flow (Private EC2)
1. EC2 instance sends outbound request
2. Traffic passes through NAT Gateway
3. NAT Gateway routes traffic via Internet Gateway

---

### Administrative Access Flow
1. Administrator connects to Bastion Host via SSH
2. Bastion Host connects to private EC2 instance

---

## High Availability & Scalability

- Multi-subnet deployment
- Auto Scaling for elasticity
- Load balancing for fault tolerance

---

## Security Best Practices

- No public access to application servers
- IAM roles instead of static credentials
- Network segmentation
- Restricted SSH access

---

## Use Cases

- Production web applications
- Secure backend services
- Enterprise cloud architectures

---

