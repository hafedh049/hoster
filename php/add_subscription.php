<?php
$subscription_id = uniqid();
$subscription_price = $_POST['plan_price'];
$selected_months = $_POST['plan_duration'];
$plan_name = $_POST['plan_name'];
$total_price = $subscription_price * $selected_months;
$subscription_date = date('Y-m-d');

// Database connection settings
$dsn = 'mysql:host=localhost;dbname=db';
$username = 'root';
$password = '';

// Create a PDO instance
try {
    $conn = new PDO($dsn, $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $stmt = $conn->prepare("INSERT INTO subscriptions (subscription_id, total_price, plan_duration, plan_name,subscription_date) VALUES (:subscription_id, :total_price, :plan_duration,:plan_name, :subscription_date)");


    $stmt->bindParam(':subscription_id', $subscription_id);
    $stmt->bindParam(':total_price', $total_price);
    $stmt->bindParam(':plan_duration', $selected_months);
    $stmt->bindParam(':subscription_date', $subscription_date);
    $stmt->bindParam(':plan_name', $plan_name);

    $stmt->execute();

    echo json_encode(array('result'=>"success",'status'=>200));
} catch(PDOException $e) {
    echo  json_encode(array('result'=>$e,'status'=>400));
}

$conn = null;
?>