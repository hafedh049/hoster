<?php
// Database connection settings
$dsn = 'mysql:host=localhost;dbname=db';
$username = 'root';
$password = '';

// Create a PDO instance
try {
    $conn = new PDO($dsn, $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Prepare SQL statement
    $stmt = $conn->prepare("SELECT * FROM subscriptions");

    // Execute statement
    $stmt->execute();

    $a = array();

    // Fetch all rows as associative arrays
    $subscription_data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    foreach ($subscription_data as $subscription) {
        $a[] = array('subscription_id'=>$subscription['subscription_id'],
        'total_price'=>$subscription['total_price'],
        'plan_duration'=>$subscription['plan_duration'],
        'subscription_date'=>$subscription['subscription_date'],
        'plan_name'=>$subscription['plan_name']);
    }
    echo json_encode(array('result'=>$a,'status'=>200));
} catch(PDOException $e) {
    echo json_encode(array('result'=>"Error: " . $e->getMessage(),'status'=>400));
}

?>