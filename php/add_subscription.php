<?php
require_once 'db.php';

$subscription_id = uniqid();
$subscription_price = (int)$_POST['plan_price'];
$selected_months = (int)$_POST['plan_duration'];
$plan_name = $_POST['plan_name'];
$user_id = $_POST['user_id'];
$total_price = $subscription_price * $selected_months;
$subscription_date = date('Y-m-d');

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

    // Check if the last subscription has expired
    $stmt = $conn->prepare("SELECT subscription_date, plan_duration FROM subscriptions WHERE user_id = :user_id ORDER BY subscription_date DESC LIMIT 1");
    $stmt->bindParam(':user_id', $user_id);
    $stmt->execute();
    $last_subscription = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$last_subscription || strtotime($last_subscription['subscription_date']) + $last_subscription['plan_duration'] * 30 * 24 * 60 * 60 < strtotime(date('Y-m-d'))) {
        // Last subscription doesn't exist or has expired, proceed with the new subscription
        $stmt = $conn->prepare("INSERT INTO subscriptions (subscription_id, total_price, plan_duration, plan_name, subscription_date, user_id) VALUES (:subscription_id, :total_price, :plan_duration, :plan_name, :subscription_date, :user_id)");

        $stmt->bindParam(':subscription_id', $subscription_id);
        $stmt->bindParam(':total_price', $total_price);
        $stmt->bindParam(':plan_duration', $selected_months);
        $stmt->bindParam(':subscription_date', $subscription_date);
        $stmt->bindParam(':plan_name', $plan_name);
        $stmt->bindParam(':user_id', $user_id);

        $stmt->execute();

        echo json_encode(array('result' => "success", 'status' => 200));
    } else {
        // Last subscription is still active, do not proceed with a new subscription
        echo json_encode(array('result' => "Last subscription is still active", 'status' => 400));
    }
} catch (PDOException $e) {
    echo json_encode(array('result' => $e, 'status' => 400));
}
?>
