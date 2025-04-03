from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from datetime import datetime
import pytz
import random

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

quotes = [
    "Kubernetes is the Linux of the cloud.",
    "The best way to predict the future is to deploy it.",
    "Kubernetes doesn’t just run containers, it orchestrates possibilities.",
    "With Kubernetes, you’re not just deploying apps—you’re scaling dreams.",
    "Automation is the first step towards reliability, and Kubernetes is the engine.",
    "Kubernetes: Where 'it works on my machine' finally meets 'it works everywhere.'",
    "In a world of microservices, Kubernetes is the conductor of the symphony.",
    "Kubernetes turns infrastructure into code, and ops into innovation.",
    "Containers are the present, Kubernetes is the future.",
    "Kubernetes teaches us that resilience isn’t optional—it’s designed.",
    "The cloud is just someone else’s computer, but Kubernetes makes it yours.",
    "Kubernetes: Because manually scaling applications is so 2010.",
    "Failures will happen. Kubernetes ensures they don’t take you down.",
    "Kubernetes is not just a tool—it’s a mindset of scalability and resilience.",
    "The only thing better than automation is self-healing automation. Thank you, K8s.",
    "Kubernetes is the bridge between developers and the infinite cloud.",
    "With great scalability comes great responsibility—Kubernetes helps you handle it.",
    "Kubernetes: Because 'works in production' should be the default, not the exception.",
    "If containers are the ships, Kubernetes is the global shipping network.",
    "Kubernetes doesn’t eliminate complexity—it tames it.",
    "This is my quote. k8 kicks ass"
]

@app.get("/")
async def test():
    return {
        "message": "This is a test"
    }

@app.get("/api")
async def root():
    est_time_zone = pytz.timezone("America/New_York")
    todayDate = datetime.now(est_time_zone)
    random_num = random.randint(0, len(quotes) - 1)
    return {
        "status": "online",
        "time": todayDate,
        "quote": quotes[random_num],
    }


