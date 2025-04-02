import "./App.css";
import { useState, useEffect } from "react";
import axios from "axios";
import k8Logo from "./assets/k8_logo.svg";
import refreshIcon from "./assets/refresh_icon.svg";
import githubIcon from "./assets/github_icon.svg";

function App() {
  const [backendStatus, setBackendStatus] = useState<String>("");
  const [backendDate, setBackendDate] = useState<String>("-");
  const [backendTime, setBackendTime] = useState<String>("-");
  const [backendQuote, setBackendQuote] = useState<String>("-");

  const handleClick = async () => {
    const url = `${window.location.protocol}//${window.location.hostname}${
      import.meta.env.MODE === "production" ? "" : ":8000"
    }`;
    const response = await axios.get(`${url}/api`);
    const data = response.data;
    const datetime = new Date(data["time"]);
    setBackendDate(datetime.toDateString());
    setBackendTime(
      `${datetime.getHours()}:${datetime.getMinutes()}:${datetime.getSeconds()}`
    );
    setBackendStatus(data["status"]);
    setBackendQuote(data["quote"]);
  };

  useEffect(() => {
    handleClick();
  }, []);

  return (
    <>
      <div className="container">
        <img src={k8Logo} height={200} className="k8-logo" />
        <h1>k8 Test {backendStatus == "online" ? "✅" : "❌"}</h1>
      </div>
      <div className="container">
        <h2 className="quote">{backendQuote}</h2>
        <button onClick={handleClick}>
          <img src={refreshIcon} height={30} className="refresh-logo" />
        </button>
      </div>
      <h3>Date: {backendDate}</h3>
      <h3>Time: {backendTime}</h3>
      <button
        onClick={() => {
          window.open("https://github.com/JNaeder/k8-test-1", "_blank");
        }}
      >
        <div className="button-container">
          <img src={githubIcon} height={50} className="github-logo" />
          GitHub Repository
        </div>
      </button>
      <p>Version 0.0.4</p>
      <p>By John Naeder</p>
    </>
  );
}

export default App;
