<?php
header('Content-Type: application/json');
include "konekdb.php";

$sql = "SELECT * FROM siswa";
$stmt = $konekdb->prepare($sql);
$stmt->execute();
$result = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);
?>