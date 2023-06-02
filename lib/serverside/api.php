<?php
// Database connection settings
$host = 'mail005.ownmail.com';
$port = 5432;
$dbname = 'misc';
$user = 'domains';
$password = 'your_password';

// Connect to PostgreSQL
$conn = pg_connect("host=$host port=$port dbname=$dbname user=$user password=$password");
if (!$conn) {
    die("Connection failed: " . pg_last_error());
}

// API endpoint to retrieve user data
if ($_SERVER['REQUEST_METHOD'] === 'GET' && $_SERVER['REQUEST_URI'] === '/api/users') {
    // SQL query to fetch user data
    $query = "select agent_name,agent_queue,agent_status,login_time,logout_time  from agent_logs where domainname=\'pbx.warmconnect.in\' order by agent_queue, agent_status";
    $result = pg_query($conn, $query);
    if (!$result) {
        die("Query failed: " . pg_last_error());
    }

    // Fetch and process the data
    $users = [];
    while ($row = pg_fetch_assoc($result)) {
        $users[] = $row;
    }

    // Return the data as JSON response
    header('Content-Type: application/json');
    echo json_encode($users);
}

// Close the database connection
pg_close($conn);
?>
