import "./App.css";
import { useState } from "react";
import axios from "axios";

function App() {
  const [backendData, setBackendData] = useState<String>("");

  const handleClick = async () => {
    const response = await axios.get("http://127.0.0.1:8000/api");
    setBackendData(JSON.stringify(response.data));
  };

  return (
    <>
      <h1>k8 Test</h1>
      <button onClick={handleClick}>Test Backend</button>
      <p>{backendData}</p>
    </>
  );
}

export default App;
