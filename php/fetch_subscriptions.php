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

    
    $stmt = $conn->prepare("SELECT * FROM subscriptions WHERE user_id = :uid;");

    
    $stmt->bindParam(':uid',$_POST['user_id']);

    
    $stmt->execute();

    $a = array();

    
    $subscription_data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    foreach ($subscription_data as $subscription) {
        $a[] = array('subscription_id'=>$subscription['subscription_id'],
        'total_price'=>$subscription['total_price'],
        'plan_duration'=>$subscription['plan_duration'],
        'subscription_date'=>$subscription['subscription_date'],
        'plan_name'=>$subscription['plan_name'],
         'user_id'=>$subscription['user_id']);
    }
    echo json_encode(array('result'=>$a,'status'=>200));
} catch(PDOException $e) {
    echo json_encode(array('result'=>"Error: " . $e->getMessage(),'status'=>400));
}

?>