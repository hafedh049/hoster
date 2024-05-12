<?php
require_once 'db.php';

// Database connection settings
$dsn = 'mysql:host=localhost;dbname=db';
$username = 'root';
$password = '';
createSubscriptionsTable($dsn, $username, $password) ;
createMessagesTable($dsn, $username, $password) ;
createUsersTable($dsn, $username, $password) ;
try {
    // Create a PDO instance
    $conn = new PDO($dsn, $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Assuming $uid contains the specific user's ID
    $uid = $_POST['uid']; // You might want to sanitize this input

    // Prepare and execute SQL query with WHERE clause for specific user
    $stmt = $conn->prepare("SELECT uid, id, message, timestamp, isYou FROM messages WHERE uid = :uid");
    $stmt->bindParam(':uid', $uid);
    $stmt->execute();

    // Fetch all messages as associative array
    $messages = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Convert array of messages to JSON and echo
    echo json_encode(array('result'=>$messages,'status'=>200));
} catch(PDOException $e) {
    // Handle database connection errors
    echo json_encode(array('result'=>$e->getMessage(),'status'=>400));
}
?>
