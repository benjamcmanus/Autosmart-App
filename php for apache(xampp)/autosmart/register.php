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
    $nombre = isset($_POST["firstName"]) ? $_POST["firstName"] : "";
    $apellido_paterno = isset($_POST["lastName"]) ? $_POST["lastName"] : "";
    $apellido_materno = isset($_POST["middleName"]) ? $_POST["middleName"] : "";
    $fecha_nacimiento = isset($_POST["dobController"]) ? $_POST["dobController"] : "";
    $email = isset($_POST["email"]) ? $_POST["email"] : "";
    $password = isset($_POST["password"]) ? $_POST["password"] : "";
    $confirmPassword = isset($_POST["confirmPassword"]) ? $_POST["confirmPassword"] : "";

    // Validaciones
    if (empty($nombre)) {
        $errors[] = "El campo Nombre es obligatorio.";
    }
    if (empty($apellido_paterno)) {
        $errors[] = "El campo Apellido Paterno es obligatorio.";
    }
    if (empty($apellido_materno)) {
        $errors[] = "El campo Nombre es obligatorio.";
    }
    if (empty($fecha_nacimiento)) {
        $errors[] = "El campo Nombre es obligatorio.";
    }
    if (empty($email)) {
        $errors[] = "El campo Nombre es obligatorio.";
    }
    if (empty($password)) {
        $errors[] = "El campo Nombre es obligatorio.";
    }
    if (empty($confirmPassword)) {
        $errors[] = "El campo Nombre es obligatorio.";
    }

    // Agrega más validaciones según tus requisitos

    
    // Verificar si hay errores
    if ( $password != $confirmPassword) {
        //Comprara las contraseñas
        echo "Las contraseñas no coinciden";
    } else if (empty($errors)) {
        // Validar que el email no esté en uso
        $sql = "SELECT * FROM usuarios WHERE email = '$email'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $errors[] = "El email ya está en uso. Por favor, elige otro.";
        } else {
            // Insertar el nuevo usuario en la base de datos
            $sql = "INSERT INTO usuarios VALUES ('','$nombre', '$apellido_paterno', '$apellido_materno', '$fecha_nacimiento', '$email', '$password')";

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