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
    $stmt = $conn->prepare("SELECT subscription_date, total_price FROM subscriptions");

    // Execute statement
    $stmt->execute();

    // Fetch all rows as associative arrays
    $subscription_data = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Group subscriptions by frequency and date
    $subscriptions = array(
        'per_week' => array(),
        'per_month' => array(),
        'per_year' => array()
    );

    foreach ($subscription_data as $subscription) {
        $subscription_date = $subscription['subscription_date'];
        $total_price = $subscription['total_price'];

        $date = date_create_from_format('Y-m-d', $subscription_date);
        $year = $date->format('Y');
        $month = $date->format('m');
        $week = $date->format('W');

        $key = '';

        // Group subscriptions per week
        $key = $year . '-W' . $week;
        if (!isset($subscriptions['per_week'][$key])) {
            $subscriptions['per_week'][$key] = 0;
        }
        $subscriptions['per_week'][$key] += $total_price;

        // Group subscriptions per month
        $key = $year . '-' . $month;
        if (!isset($subscriptions['per_month'][$key])) {
            $subscriptions['per_month'][$key] = 0;
        }
        $subscriptions['per_month'][$key] += $total_price;

        // Group subscriptions per year
        if (!isset($subscriptions['per_year'][$year])) {
            $subscriptions['per_year'][$year] = 0;
        }
        $subscriptions['per_year'][$year] += $total_price;
    }

    echo json_encode(array('result' => $subscriptions, 'status' => 200));

} catch (PDOException $e) {
    echo json_encode(array('result' => "Error: " . $e->getMessage(), 'status' => 400));
}

// Close database connection
$conn = null;
?>