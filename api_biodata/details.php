<?php
header('Content-Type: application/json');
Include "konekdb.php";

$id = (int) $_POST['id'];
$stmt = $konekdb->prepare("SELECT * FROM siswa WHERE id = ?");
$stmt->execute([$id]);
$result = $stmt->fetch(PDO::FETCH_ASSOC);
echo json_encode($result);
?>