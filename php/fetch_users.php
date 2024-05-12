<?php
require_once 'db.php';

// Database connection settings
$dsn = 'mysql:host=localhost;dbname=db';
$username = 'root';
$password = '';
createSubscriptionsTable($dsn, $username, $password) ;
createMessagesTable($dsn, $username, $password) ;
createUsersTable($dsn, $username, $password) ;
// Create a PDO instance
try {
    $conn = new PDO($dsn, $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Prepare SQL statement
    $stmt = $conn->prepare("SELECT * FROM users");

    // Execute statement
    $stmt->execute();

    $users = array();

    // Fetch all rows as associative arrays
    $user_data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    foreach ($user_data as $user) {
        $users[] = array(
            'uid' => $user['uid'],
            'name' => $user['name'],
            'email' => $user['email'],
            'password' => $user['password'],
            'role' => $user['role'],
            'gender' => $user['gender']
        );
    }
    echo json_encode(array('result' => $users, 'status' => 200));
} catch(PDOException $e) {
    echo json_encode(array('result' => "Error: " . $e->getMessage(), 'status' => 400));
}

// Close database connection
$conn = null;
?>