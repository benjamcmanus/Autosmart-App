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

function generateRandomPassword($length = 6) {
    $chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNPQRSTUVWXYZ0123456789";
    $charLength = strlen($chars);
    $password = "";

    for ($i = 0; $i < $length; $i++) {
        $password .= $chars[rand(0, $charLength - 1)];
    }

    return $password;
}

// Verifica si el formulario se ha enviado
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = isset($_POST["email"]) ? $_POST["email"] : "";

    // Validaciones para la recuperación de contraseña
    if (empty($email)) {
        $errors[] = "El campo Email es obligatorio.";
    }

    if (empty($errors)) {
        // Validar que el email esté registrado en la base de datos
        $sql = "SELECT * FROM usuarios WHERE email = '$email'";
        $result = $conn->query($sql);

        if ($result->num_rows == 1) {
            // Generar una nueva contraseña temporal
            $newPassword = generateRandomPassword();

            // Actualizar la contraseña en la base de datos
            $sql = "UPDATE usuarios SET password = '$newPassword' WHERE email = '$email'";

            if ($conn->query($sql) === TRUE) {
                // Enviar la nueva contraseña al usuario por correo o mostrarla en pantalla
                echo "Tu nueva contraseña temporal es: $newPassword";
                header("HTTP/1.1 200 OK");
            } else {
                echo "Error al actualizar la contraseña: " . $conn->error;
                header("HTTP/1.1 500 Internal Server Error");
            }
        } else {
            $errors[] = "El email no está registrado en nuestro sistema.";
            header("HTTP/1.1 404 Not Found");
        }
    }

} else {
    $errors[] = "Acción no válida.";
}

// Cerrar la conexión a la base de datos
$conn->close();
?>
