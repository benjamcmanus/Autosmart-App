<?php
// Conexión a la base de datos MySQL
$servername = "localhost";
$username = "root";
$password = "";
$database = "autosmart";

$conn = new mysqli($servername, $username, $password, $database);

// Verificar la conexión
if ($conn->connect_error) {
    die("Error en la conexión a la base de datos: " . $conn->connect_error);
}

// Inicializa un arreglo para almacenar los errores de validación
$errors = array();

// Verifica si el formulario se ha enviado
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Recibir datos del formulario de registro
    $marca = isset($_POST["marca"]) ? $_POST["marca"] : "";
    $modelo = isset($_POST["modelo"]) ? $_POST["modelo"] : "";
    $year = isset($_POST["year"]) ? $_POST["year"] : "";
    $patente = isset($_POST["patente"]) ? $_POST["patente"] : "";
    
    // Validaciones
    if (empty($marca)) {
        $errors[] = "El campo marca es obligatorio.";
    }
    if (empty($modelo)) {
        $errors[] = "El campo modelo es obligatorio.";
    }
    if (empty($year)) {
        $errors[] = "El campo year es obligatorio.";
    }
    if (empty($patente)) {
        $errors[] = "El campo patente es obligatorio.";
    }
   

    
    // Verificar si hay errores
     if (empty($errors)) {
        // Validar que el patente no esté en uso
        $sql = "SELECT * FROM vehiculos WHERE patente = '$patente'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $errors[] = "El patente ya está en uso. Por favor, elige otro.";
        } else {
            // Insertar el nuevo usuario en la base de datos
            $sql = "INSERT INTO vehiculos VALUES ('','$marca', '$modelo', '$year', '$patente', 1)";

            if ($conn->query($sql) === TRUE) {
                echo "Registro exitoso";
                header("HTTP/1.1 200 OK");
            } else {
                echo "Error en el registro: " . $conn->error;
                header("HTTP/1.1 404 Not Found");
            }
        }

    } else {
        // Mostrar errores de validación
        foreach ($errors as $error) {
            echo $error . "<br>";
        }
    }
}

// Cerrar la conexión a la base de datos
$conn->close();
?>