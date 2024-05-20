<?php
require_once 'db.php';


$db_host = 'localhost';
$db_username = 'root';
$db_password = '';
$db_name = 'db';

$email = $_POST['email']; 
$password = $_POST['password']; 
$hashed_password = sha1($password);
createSubscriptionsTable($dsn, $username, $password) ;
createMessagesTable($dsn, $username, $password) ;
createUsersTable($dsn, $username, $password) ;
try {
    
    $conn = new PDO("mysql:host=$db_host;dbname=$db_name", $db_username, $db_password);

    
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    
    $stmt = $conn->prepare("SELECT * FROM users WHERE email=:email AND password=:password");

    
    $stmt->execute(array(':email' => $email,':password' => $hashed_password));

    
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($user) {
        
        echo json_encode(array('result'=>array(
            'uid' => $user['uid'],
            'name' => $user['name'],
            'email' => $user['email'],
            'password' => $user['password'],
            'role' => $user['role'],
            'gender' => $user['gender'],
        ),'status'=>true));
    } else {
        
        echo json_encode(array('result'=>"USER NOT FOUND", 'status'=>true));
    }
} catch(PDOException $e) {
    echo json_encode(array('result'=>"Error: " . $e->getMessage(), 'status'=>false));

}
?>