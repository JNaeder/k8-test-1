import "./App.css";
import { useState } from "react";
import axios from "axios";
import k8Logo from "./assets/k8_logo.svg";

function App() {
  const [backendStatus, setBackendStatus] = useState<String>("");
  const [backendDate, setBackendDate] = useState<String>("-");
  const [backendTime, setBackendTime] = useState<String>("-");
  const [backendQuote, setBackendQuote] = useState<String>("-");

  const handleClick = async () => {
    const backendURL =
      import.meta.env.VITE_BACKEND_URL || "http://127.0.0.1:8000";
    const response = await axios.get(backendURL);
    const data = response.data;
    const datetime = new Date(data["time"]);
    setBackendDate(datetime.toDateString());
    setBackendTime(
      `${datetime.getHours()}:${datetime.getMinutes()}:${datetime.getSeconds()}`
    );
    setBackendStatus(data["status"]);
    setBackendQuote(data["quote"]);
  };

  return (
    <>
      <div className="container">
        <img src={k8Logo} height={100} />
        <h1>k8 Test</h1>
      </div>
      <p>⚠️currently not running on k8⚠️</p>
      <h2>{backendQuote}</h2>
      <h3>
        Status: {backendStatus.toUpperCase()}{" "}
        {backendStatus == "online" ? "✅" : "❌"}
      </h3>
      <h3>Date: {backendDate}</h3>
      <h3>Time: {backendTime}</h3>
      <button onClick={handleClick}>Test Backend</button>
      <div></div>
      <br />
      <button
        onClick={() => {
          window.open("https://github.com/JNaeder/k8-test-1", "_blank");
        }}
      >
        GitHub Repository
      </button>
    </>
  );
}

export default App;
