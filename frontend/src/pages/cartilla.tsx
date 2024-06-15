import React, { useState } from "react";
import "./RegistroForm.css"; // Make sure to create a RegistroForm.css file in the same directory

export default function RegistroForm() {
  const [registro, setRegistro] = useState({
    vacuna: "",
    enfermedades: "",
    rangoEdad: "",
    frecuencia: "",
    fecha: "",
    aplicada: false,
    detalle: "",
  });

  function handleChange(e : any) {
    const { name, value, type, checked } = e.target;
    setRegistro((prevRegistro) => ({
      ...prevRegistro,
      [name]: type === "checkbox" ? checked : value,
    }));
  }

  function handleSubmit(e : any) {
    e.preventDefault();
    // Handle the form submission logic here
    console.log("Submitted Registro:", registro);
  }

  return (
    <form className="registro-form" onSubmit={handleSubmit}>
      <div className="form-field">
        <label htmlFor="vacuna">Vacuna:</label>
        <input
          id="vacuna"
          type="text"
          name="vacuna"
          value={registro.vacuna}
          onChange={handleChange}
          required
        />
      </div>
      <div className="form-field">
        <label htmlFor="enfermedades">Enfermedades:</label>
        <input
          id="enfermedades"
          type="text"
          name="enfermedades"
          value={registro.enfermedades}
          onChange={handleChange}
          required
        />
      </div>
      <div className="form-field">
        <label htmlFor="rangoEdad">Rango de edad:</label>
        <input
          id="rangoEdad"
          type="text"
          name="rangoEdad"
          value={registro.rangoEdad}
          onChange={handleChange}
          required
        />
      </div>
      <div className="form-field">
        <label htmlFor="frecuencia">Frecuencia:</label>
        <input
          id="frecuencia"
          type="text"
          name="frecuencia"
          value={registro.frecuencia}
          onChange={handleChange}
          required
        />
      </div>
      <div className="form-field">
        <label htmlFor="fecha">Fecha:</label>
        <input
          id="fecha"
          type="date"
          name="fecha"
          value={registro.fecha}
          onChange={handleChange}
          required
        />
      </div>
      <div className="form-field">
        <label htmlFor="aplicada">Aplicada:</label>
        <input
          id="aplicada"
          type="checkbox"
          name="aplicada"
          checked={registro.aplicada}
          onChange={handleChange}
        />
      </div>
      <div className="form-field">
        <label htmlFor="detalle">Detalle:</label>
        <textarea
          id="detalle"
          name="detalle"
          value={registro.detalle}
          onChange={handleChange}
          required
        />
      </div>
      <button type="submit">Submit</button>
    </form>
  );
}