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
  "You're surprisingly good at that for a beginner!",
  "I love how you just don’t care what people think.",
  "You have such a unique sense of style—I've never seen anything like it!",
  "Wow, I never expected you to be so articulate!",
  "You're proof that confidence is more important than talent.",
  "I wish I had your level of patience with failure.",
  "It’s amazing how you always find a way to stand out—whether you mean to or not.",
  "You make being awkward look so natural!",
  "I admire how you don’t let a lack of experience stop you.",
  "You have such a refreshingly different way of thinking!",
  "I love how you embrace your flaws instead of trying to hide them.",
  "You're really brave for wearing that outfit.",
  "Your taste in music is... definitely unexpected!",
  "You have such a charmingly unpolished way of doing things.",
  "It's inspiring how you never let criticism get to you.",
  "You’re so independent—it’s impressive how little you rely on common sense.",
  "I love how you turn every mistake into a learning experience!",
  "You always manage to surprise me, one way or another.",
  "It’s great how you don’t let lack of talent hold you back.",
  "You bring such a different energy to the group—no one else could pull that off!"
]

@app.get("/")
async def test():
    return {
        "message": "This is a test"
    }


@app.get("/api")
async def root():
    todayDate = datetime.now()
    random_num = random.randint(0, len(quotes) - 1)
    return {
        "status": "online",
        "time": todayDate,
        "quote": quotes[random_num]
    }


