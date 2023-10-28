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

// Verifica si el formulario de inicio de sesión se ha enviado
if (isset($_POST["email"]) && isset($_POST["password"])) {
    $email = isset($_POST["email"]) ? $_POST["email"] : "";
    $password = isset($_POST["password"]) ? $_POST["password"] : "";

    // Validaciones (puedes agregar más validaciones según tus requisitos)
    if (empty($email)) {
        $errors[] = "El campo Email es obligatorio.";
    }
    if (empty($password)) {
        $errors[] = "El campo Contraseña es obligatorio.";
    }

    // Verificar si hay errores
    if (empty($errors)) {
        // Consultar la base de datos para verificar las credenciales del usuario
        $sql = "SELECT * FROM usuarios WHERE email = '$email'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            
            // Comparar la contraseña proporcionada por el usuario con la contraseña almacenada
            if ($password === $row["password"]) {
                // Las credenciales son válidas, el usuario ha iniciado sesión con éxito
                $_SESSION['id_usuarios'] = $row["id_usuarios"]; // Almacenar el id_usuarios en la sesión
                $responseMessage = "Inicio de sesión exitoso," . $row["nombre"] . "," . $row["id_usuarios"];
                echo $responseMessage;
            } else {
                $errors[] = "Contraseña incorrecta.";
                header("HTTP/1.1 401 Unauthorized");
            }
        } else {
            $errors[] = "Email no encontrado. Por favor, regístrate si eres un nuevo usuario.";
            header("HTTP/1.1 404 Not Found");
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