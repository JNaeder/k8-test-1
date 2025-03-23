from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from datetime import datetime
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
  "Believe you can and you're halfway there.",
  "Do what you can, with what you have, where you are.",
  "Dream big and dare to fail.",
  "Stay hungry, stay foolish.",
  "Success is not final, failure is not fatal.",
  "You are stronger than you think.",
  "The only way to do great work is to love what you do.",
  "Doubt kills more dreams than failure ever will.",
  "Everything you’ve ever wanted is on the other side of fear.",
  "Act as if what you do makes a difference. It does.",
  "Happiness depends upon ourselves.",
  "What we achieve inwardly will change outer reality.",
  "Be yourself; everyone else is already taken.",
  "It always seems impossible until it’s done.",
  "With the new day comes new strength and new thoughts."
]


@app.get("/")
async def root():
    todayDate = datetime.now()
    random_num = random.randint(0, len(quotes) - 1)
    return {
        "status": "online",
        "time": todayDate,
        "quote": quotes[random_num]
    }


