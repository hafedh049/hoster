<?php
// Database connection settings
$dsn = 'mysql:host=localhost;dbname=db';
$username = 'root';
$password = '';

function insertSubscriptions() {
    global $dsn, $username, $password;

    try {
        // Create a PDO instance
        $conn = new PDO($dsn, $username, $password);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        // Prepare SQL statement to insert subscriptions
        $stmt = $conn->prepare("INSERT INTO subscriptions (subscription_id, total_price, plan_duration, subscription_date, plan_name, user_id) VALUES (:subscription_id, :total_price, :plan_duration, :subscription_date, :plan_name, :user_id)");

        // Generate 100 subscriptions
        $today = date("Y-m-d");
        $totalSubscriptions = 100;
        $successCount = 0;

        // List of possible plan names
        $planNames = ['STARTER', 'PREMIUM', 'PROFESSIONAL'];

        for ($i = 0; $i < $totalSubscriptions; $i++) {
            // Randomly generate subscription details
            $subscriptionId = uniqid(); // Generate unique subscription ID
            $totalPrice = rand(50, 200);
            $planDuration = rand(1, 12); // Assuming plan duration is in months
            $subscriptionDate = date("Y-m-d", strtotime("-$i days", strtotime($today)));
            $planName = $planNames[array_rand($planNames)]; // Randomly select plan name
            $userId = uniqid(); // Assuming user IDs are integers from 1 to 100

            // Bind parameters and execute the query
            $stmt->bindParam(':subscription_id', $subscriptionId);
            $stmt->bindParam(':total_price', $totalPrice);
            $stmt->bindParam(':plan_duration', $planDuration);
            $stmt->bindParam(':subscription_date', $subscriptionDate);
            $stmt->bindParam(':plan_name', $planName);
            $stmt->bindParam(':user_id', $userId);

            if ($stmt->execute()) {
                $successCount++;
            }
        }

        return $successCount;

    } catch(PDOException $e) {
        return 0; // Return 0 if there's an error
    }
}

// Usage example
$insertCount = insertSubscriptions();
echo "Inserted $insertCount subscriptions.";
?>