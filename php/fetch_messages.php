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


    $uid = $_POST['uid']; 

 
    $stmt = $conn->prepare("SELECT uid, id, message, timestamp, isYou FROM messages WHERE uid = :uid");
    $stmt->bindParam(':uid', $uid);
    $stmt->execute();

   
    $messages = $stmt->fetchAll(PDO::FETCH_ASSOC);


    echo json_encode(array('result'=>$messages,'status'=>200));
} catch(PDOException $e) {

    echo json_encode(array('result'=>$e->getMessage(),'status'=>400));
}
?>
