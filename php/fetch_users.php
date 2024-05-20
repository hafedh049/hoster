<?php
require_once 'db.php';


$dsn = 'mysql:host=localhost;dbname=db';
$username = 'root';
$password = '';
createSubscriptionsTable($dsn, $username, $password) ;
createMessagesTable($dsn, $username, $password) ;
createUsersTable($dsn, $username, $password) ;

try {
    $conn = new PDO($dsn, $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    
    $stmt = $conn->prepare("SELECT * FROM users");

    
    $stmt->execute();

    $users = array();

    
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


$conn = null;
?>