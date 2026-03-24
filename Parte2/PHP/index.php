<!DOCTYPE html>
<html>
<head>
    <title>VINISYS</title>
</head>
<body>
    <h1>VINISYS</h1>
    <button onclick="window.location.href='colheitas.php'">Gestão de Colheitas</button>
    <button onclick="window.location.href='vinhos.php'">Listagem de Vinhos</button>
    <button onclick="window.location.href='gestao_vendas.php'">Gestão de Vendas</button>

	<?php
    include 'db_connect.php';
    echo "Connected successfully";
    ?>

</body>
</html>
