<?php
require_once 'db.php';

function generate_uid() {
    
    $random_string = bin2hex(random_bytes(4)); 

    
    $timestamp = time(); 
    $uid = $timestamp . $random_string;
    return $uid;
}
    $db_host = 'localhost';
    $db_username = 'root';
    $db_password = '';
    $db_name = 'db';

    $name = $_POST['name']; 
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
        
        $conn = new PDO("mysql:host=$db_host;dbname=$db_name", $db_username, $db_password);

        
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        
        $stmt = $conn->prepare("INSERT INTO users (uid,name, email, password,role,gender) VALUES (:uid,:name, :email, :password,:role,:gender)");

        
        $stmt->execute(array(':uid'=>$uid,':role'=>$role,':name' => $name, ':email' => $email, ':password' => $hashed_password,":gender" => $gender));

        
        if ($stmt->rowCount() > 0) {
            
            echo json_encode(array('result'=>$uid,'status'=>true));
        }
    } catch(PDOException $e) {
        
        die("Error: " . $e->getMessage());
        echo json_encode(array('result'=>'','status'=>false));
    }
?>