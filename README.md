# ProFixer: Agentic AI Service Orchestrator

ProFixer is an AI-driven service management system designed to automate the informal economy (plumbers, electricians, tutors). It uses **Google Antigravity** as the central brain to orchestrate agent workflows, manage multi-step reasoning, and execute service bookings.

## 🏗 System Architecture
This app functions as a client for an Agentic AI system that automates the lifecycle of a service request.



## 🧠 Core Agentic Workflow
1.  **Intent Parsing:** Processes natural language (Urdu/Roman Urdu/English) to extract service type, location, and time.
2.  **Provider Discovery:** Identifies relevant providers based on real-time context.
3.  **Reasoning & Matching:** Ranks providers based on distance, availability, and rating.
4.  **Action Simulation:** Automates booking confirmation and scheduling.
5.  **Follow-up:** Manages reminders and completion status.

## 🚀 API Integration Requirements
To connect the frontend with the Antigravity-orchestrated backend, the system utilizes the following endpoints:

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `POST` | `/api/ai/intent-parse` | Translates user input into structured data. |
| `GET` | `/api/providers/find` | Retrieves ranked provider list. |
| `POST` | `/api/bookings/create` | Executes simulated booking flow. |

## 💻 Tech Stack
* **Frontend:** Flutter / Dart
* **Backend Orchestration:** Google Antigravity
* **Communication:** JSON over REST APIs

## 🛠 Getting Started
1. **Clone the repo:** `git clone https://github.com/AnumEjaz1/ProFixer.git`
2. **Install dependencies:** `flutter pub get`
3. **Run the application:** `flutter run`
