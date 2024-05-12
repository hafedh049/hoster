<?php
// Database connection settings
$dsn = 'mysql:host=localhost;dbname=db';
$username = 'root';
$password = '';

function createSubscriptionsTable($dsn, $username, $password) {
    try {
        // Create a PDO instance
        $conn = new PDO($dsn, $username, $password);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        // SQL statement to create the table if not exists
        $sql = "CREATE TABLE IF NOT EXISTS subscriptions (
            subscription_id VARCHAR(60),
            total_price INT(11) NOT NULL,
            plan_duration INT(11) NOT NULL,
            subscription_date DATE NOT NULL,
            plan_name VARCHAR(60) NOT NULL,
            user_id VARCHAR(60) NOT NULL,
            PRIMARY KEY(subscription_id,subscription_date)
        )";

        // Execute SQL query
        $conn->exec($sql);
    } catch(PDOException $e) {
    }

}

function createMessagesTable($dsn, $username, $password) {
    try {
        // Create a PDO instance
        $conn = new PDO($dsn, $username, $password);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        // SQL statement to create the table if not exists
        $sql = "CREATE TABLE IF NOT EXISTS messages (
            uid VARCHAR(60),
            id VARCHAR(60),
            message TEXT NOT NULL,
            timestamp DATETIME NOT NULL,
            isYou VARCHAR(60) NOT NULL,
            PRIMARY KEY (timestamp, id)
        )";

        // Execute SQL query
        $conn->exec($sql);

    } catch(PDOException $e) {
    }
}

function createUsersTable($dsn, $username, $password) {
    try {
        // Create a PDO instance
        $conn = new PDO($dsn, $username, $password);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        // SQL statement to create the table if not exists
        $sql = "CREATE TABLE IF NOT EXISTS users (
            uid VARCHAR(60),
            name VARCHAR(60) NOT NULL,
            email VARCHAR(60),
            password VARCHAR(60) NOT NULL,
            role VARCHAR(60) NOT NULL,
            gender VARCHAR(60) NOT NULL,
            PRIMARY KEY (uid, email)
        )";

        // Execute SQL query
        $conn->exec($sql);

    } catch(PDOException $e) {
    }
}

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
?>