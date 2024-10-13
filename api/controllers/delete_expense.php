<?php
// delete_expense.php
include '../database/db.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id = $_POST['id'];

    // Delete query
    $stmt = $pdo->prepare('DELETE FROM expenses WHERE id = ?');
    $result = $stmt->execute([$id]);

    if ($result) {
        echo json_encode(['status' => 'success']);
    } else {
        echo json_encode(['status' => 'error']);
    }
}
?>
