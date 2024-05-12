<?php
require_once 'db.php';

// Database connection settings
$dsn = 'mysql:host=localhost;dbname=db';
$username = 'root';
$password = '';
createSubscriptionsTable($dsn, $username, $password) ;
createMessagesTable($dsn, $username, $password) ;
createUsersTable($dsn, $username, $password) ;
function getClientPercentage() {
    global $dsn, $username, $password;

    try {
        // Create a PDO instance
        $conn = new PDO($dsn, $username, $password);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        // Query to count the number of personal and enterprise clients
        $stmt = $conn->prepare("SELECT COUNT(*) AS total, role FROM users WHERE uid <> '0' GROUP BY role;");
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

        // Calculate percentages

        $personalClients = 0;
        $enterpriseClients = 0;

        foreach ($result as $row) {
            if ($row['role'] == 'PERSONAL CLIENT') {
                $personalClients = $row['total'];
            } else if ($row['role'] == 'ENTERPRISE CLIENT') {
                $enterpriseClients = $row['total'];
            }
        }

        $totalClients = $personalClients + $enterpriseClients;

        // Calculate percentages
        $personalPercentage = ($personalClients / $totalClients) *100;
        $enterprisePercentage = ($enterpriseClients / $totalClients) * 100;

        return array("result"=>array(
            'personal_percentage' => $personalPercentage,
            'enterprise_percentage' => $enterprisePercentage
        ),"status"=>200);

    } catch (PDOException $e) {  return array('result'=>array('error' => 'Error: ' . $e->getMessage()),"status"=>200);
    }
}

// Usage example
$result = getClientPercentage();
echo json_encode($result);
?>