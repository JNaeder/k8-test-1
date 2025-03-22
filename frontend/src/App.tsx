import "./App.css";
import { useState } from "react";
import axios from "axios";

function App() {
  const [backendStatus, setBackendStatus] = useState<String>("");
  const [backendTime, setBackendTime] = useState<String>("");

  const handleClick = async () => {
    const backendURL =
      import.meta.env.VITE_BACKEND_URL || "http://127.0.0.1:8000";
    const response = await axios.get(backendURL);
    const data = response.data;
    setBackendStatus(data["status"]);
    setBackendTime(data["time"]);
  };

  return (
    <>
      <h1>k8 Test</h1>
      <button onClick={handleClick}>Test Backend</button>
      <p>Status: {backendStatus}</p>
      <p>Time: {backendTime}</p>
      <div></div>
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
