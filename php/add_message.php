<?php
// Database connection settings
$dsn = 'mysql:host=localhost;dbname=db';
$username = 'root';
$password = '';

try {
    // Create a PDO instance
    $conn = new PDO($dsn, $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Prepare and execute SQL query to insert the message into the database
    $stmt = $conn->prepare("INSERT INTO messages (uid, id, message, timestamp, isYou) VALUES (:uid, :id, :message, :timestamp, :isYou)");
    $stmt->bindParam(':uid', $_POST['uid']);
    $stmt->bindParam(':id', $_POST['id']);
    $stmt->bindParam(':message', $_POST['message']);
    $stmt->bindParam(':timestamp', $_POST['timestamp']);
    $stmt->bindParam(':isYou', $_POST['isYou']);
    $stmt->execute();

    echo json_encode(array('result' => 'success', 'message' => 'Message added successfully','status'=>200));
} catch(PDOException $e) {
    // Handle database connection errors
    echo json_encode(array('result' => 'error', 'message' => 'Error adding message: ' . $e->getMessage(),'status'=>200));
}
?>
