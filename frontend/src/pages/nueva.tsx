import React, { useState } from "react";
import "./VacunaForm.css"; // Make sure to create a VacunaForm.css file in the same directory

export default function VacunaForm() {
  const [vacuna, setVacuna] = useState({
    id: 0,
    dosis: 0,
    lote: "",
    empresa: "",
    fecha: "",
    lugar: "",
    tipo: "",
    vigencia: "",
  });

  function handleChange(e : any) {
    const { name, value } = e.target;
    setVacuna((prevVacuna) => ({
      ...prevVacuna,
      [name]: name === "id" || name === "dosis" ? parseInt(value) : value,
    }));
  }

  function handleSubmit(e : any) {
    e.preventDefault();
    // Handle the form submission logic here
    console.log("Submitted Vaccine Record:", vacuna);
  }

  return (
    <form className="vacuna-form" onSubmit={handleSubmit}>
      {Object.entries(vacuna).map(([key, value]) => (
        <div key={key} className="form-field">
          <label htmlFor={key}>{key.charAt(0).toUpperCase() + key.slice(1)}:</label>
          <input
            id={key}
            type={key === "id" || key === "dosis" ? "number" : "text"}
            name={key}
            value={value}
            onChange={handleChange}
            required
          />
        </div>
      ))}
      <button type="submit">Submit</button>
    </form>
  );
}