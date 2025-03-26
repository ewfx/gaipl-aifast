# 🚀 AI-FAST Generational Helpbot

## 📌 Table of Contents
- [Introduction](#introduction)
- [Demo](artifacts/demo/README.md)
- [Inspiration](#inspiration)
- [What It Does](#what-it-does)
- [How We Built It](#how-we-built-it)
- [Challenges We Faced](#challenges-we-faced)
- [How to Run](#how-to-run)
- [Tech Stack](#tech-stack)
- [Team](#team)

---

## 🎯 Introduction
This is a helpful Gemini gen ai LLM bot which runs on grounded data coming from multiple sources from integrated enterprise platform and able to provide usable solutions to the end user. End user will query the data using natural language and output will be in human understandsble format using RAG(Retrieval Augmentation Generation) behind the scenes

## 🎥 Demo
🔗 [Live Demo](#)(https://hackathon-webui-ipe-960367298527.us-central1.run.app/)  
📹 [Video Demo](artifacts/demo/DemoVideo/Demo_Video.mp4)

🖼️ [Screenshots](artifacts/demo/Screenshots/)
![Screenshot 1](artifacts/demo/Screenshots/Appstartpage.jpg)

## 💡 Inspiration
Organizations have tons of data lying scattered across different systems. Idea here is to organize it and provide a neat interface to the end user who can use natural language to find multitude of solutions which were hitherto unexplored

## ⚙️ What It Does
It provides a interface to the user to query through issues in natural language and find matching ones in lightning quick time

## 🛠️ How We Built It
We have used all tools from GCP - namely Agent Builder Agent.Datastore,Cloud Run,Cloud storage bucket,artifact registry,Bigquery and Gemini as LLM. terraform was used for building the infra set up and gcloud/python was used for building application front end.

## 🚧 Challenges We Faced
Major challenge was the time crunch to build this multi integration set up and making sure it works together. Another issue was in getting usable data. Ingestion of the data caused some challeneges but it was overcome a lot using gen ai itself .

## 🏃 How to Run
1. Clone the repository  
   ```sh
   git clone https://github.com/ewfx/gaipl-aifast.git
   ```
2. Deploy infrastruture
   Install open source terraform (how to install)[https://developer.hashicorp.com/terraform/install]
   ```sh
   
   Navigate to source code in Git repository
   cd code/src
   Update file `main.tf` with GCP project name in line #3
   Run following commands
   terraform init
   terraform validate
   terraform plan
   terraform apply
   ```
4. Application setup  
   
   Refer to [Application setup](https://github.com/ewfx/gaipl-aifast/blob/main/code/src/README.md#application-setup)
   

## 🏗️ Tech Stack
- 🔹 Frontend: HTML
- 🔹 Backend: Dialogflow
- 🔹 Database: Datastore(vector database)
- 🔹 Compute: Cloud Run
- 🔹 Hosted in : Google cloud platform
- 🔹 Terraform

## 👥 Team
- **AI-FAST** - [GitHub](https://github.com/ewfx/gaipl-aifast/)
- **Anil Manohar Mohapatra** - [GitHub](https://github.com/anilmm2005)
- **Harsha Vardhan Bhogi** - [GitHub](https://github.com/HarshaBhogi)
- **Vijay Maruthi Lagishetti** - [GitHub](https://github.com/Vijay2869)
- **Ravikiran Bollam** - [GitHub](https://github.com/rabollam)
- **Kuldeep Rana** - [GitHub](https://github.com/Ranagcp)
