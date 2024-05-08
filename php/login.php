<?php
// Replace these with your actual database credentials
$db_host = 'localhost';
$db_username = 'root';
$db_password = '';
$db_name = 'db';

$email = $_POST['email']; // Assuming you're getting username and password from a form
$password = $_POST['password']; // Assuming you're getting username and password from a form
$hashed_password = sha1($password);

try {
    // Create a PDO connection
    $conn = new PDO("mysql:host=$db_host;dbname=$db_name", $db_username, $db_password);

    // Set PDO to throw exceptions on errors
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Prepare the query to prevent SQL injection
    $stmt = $conn->prepare("SELECT * FROM users WHERE email=:email AND password=:password");

    // Bind parameters and execute the query
    $stmt->execute(array(':email' => $email,':password' => $hashed_password));

    // Fetch the result
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($user) {
        // User exists and password matches, sign in successful
        echo json_encode(array('result'=>array(
            'uid' => $user['uid'],
            'name' => $user['name'],
            'email' => $user['email'],
            'password' => $user['password'],
            'role' => $user['role'],
            'gender' => $user['gender'],
        ),'status'=>true));
    } else {
        // User does not exist or password is incorrect
        echo json_encode(array('result'=>"USER NOT FOUND", 'status'=>true));
    }
} catch(PDOException $e) {
    echo json_encode(array('result'=>"Error: " . $e->getMessage(), 'status'=>false));

}
?>