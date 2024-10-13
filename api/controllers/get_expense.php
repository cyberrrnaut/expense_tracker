<?php
// get_expenses.php
include '../database/db.php';

try {
    // Fetch all expenses
    $stmt = $pdo->query('SELECT * FROM expenses ORDER BY date DESC');
    $expenses = $stmt->fetchAll();

    // Return JSON response
    echo json_encode($expenses);
} catch (PDOException $e) {
    echo json_encode(['error' => $e->getMessage()]);
}
