<?php
// add_expense.php
include '../database/db.php';

// Ensure the request method is POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get the data from the request
    $data = json_decode(file_get_contents('php://input'), true);
    $description = $data['description'] ?? null;
    $amount = $data['amount'] ?? null;
    $date = $data['date'] ?? null;
    

    // Check if all required fields are provided
    if ($description && $amount && $date) {
        // Prepare the SQL statement
        $sql = "INSERT INTO expenses (description, amount, date) VALUES (:description, :amount, :date)";
        $stmt = $pdo->prepare($sql);

        // Bind parameters
        $stmt->bindParam(':description', $description);
        $stmt->bindParam(':amount', $amount);
        $stmt->bindParam(':date', $date);

        // Execute the statement
        try {
            $stmt->execute();
            echo "Expense added successfully.";
        } catch (PDOException $e) {
            echo "Error adding expense: " . $e->getMessage();
        }
    } else {
        echo "Invalid input. Make sure to provide description, amount, and date.";
    }
} else {
    echo "Only POST requests are allowed.";
}
