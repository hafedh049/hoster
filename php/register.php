<?php
require_once 'db.php';

function generate_uid() {
    // Generate a random string
    $random_string = bin2hex(random_bytes(4)); // Generates a 8-character (4 bytes * 2 hex characters per byte) random string

    // Get current timestamp
    $timestamp = time(); // Current Unix timestamp

    // Concatenate timestamp and random string to create UID
    $uid = $timestamp . $random_string;

    return $uid;
}

    // Replace these with your actual database credentials
    $db_host = 'localhost';
    $db_username = 'root';
    $db_password = '';
    $db_name = 'db';

    $name = $_POST['name']; // Assuming you're getting name, email, and password from a form
    $email = $_POST['email'];
    $password = $_POST['password'];
    $role = $_POST['role'];
    $gender = $_POST['gender'];

    $hashed_password = sha1($password);

    createSubscriptionsTable($dsn, $username, $password) ;
    createMessagesTable($dsn, $username, $password) ;
    createUsersTable($dsn, $username, $password) ;
    try {
        $uid = generate_uid();
        // Create a PDO connection
        $conn = new PDO("mysql:host=$db_host;dbname=$db_name", $db_username, $db_password);

        // Set PDO to throw exceptions on errors
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        // Prepare the query to prevent SQL injection
        $stmt = $conn->prepare("INSERT INTO users (uid,name, email, password,role,gender) VALUES (:uid,:name, :email, :password,:role,:gender)");

        // Bind parameters and execute the query
        $stmt->execute(array(':uid'=>$uid,':role'=>$role,':name' => $name, ':email' => $email, ':password' => $hashed_password,":gender" => $gender));

        // Check if the insertion was successful
        if ($stmt->rowCount() > 0) {
            // Sign up successful
            echo json_encode(array('result'=>$uid,'status'=>true));
        }
    } catch(PDOException $e) {
        // Handle any exceptions
        die("Error: " . $e->getMessage());
        echo json_encode(array('result'=>'','status'=>false));
    }
?>