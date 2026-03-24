<!DOCTYPE html>
<html>
<head>
    <title>Gestão de Vendas</title>
</head>
<body>
    <h1>Listagem de Clientes</h1>

    <table border='1'>
        <tr>
            <th>Nome</th>
            <th>Tipo</th>
            <th>NIF</th>
            <th>Morada</th>
            <th>Quantidade Total Comprada</th>
            <th>Valor Total Gasto</th>
        </tr>
        <?php
        include 'db_connect.php';

        $sql_clientes = "SELECT CLIENTE.numero_cliente, CLIENTE.nome_cliente, CLIENTE.tipo, CLIENTE.NIF, CLIENTE.morada,
                                COALESCE(SUM(FATURA.valor_total), 0) AS total_valor,
                                COALESCE(SUM(ITEM.quantidade), 0) AS total_quantidade
                         FROM CLIENTE
                         LEFT JOIN FATURA ON CLIENTE.numero_cliente = FATURA.CLIENTE_numero_cliente
                         LEFT JOIN ITEM ON FATURA.num_fatura = ITEM.FATURA_num_fatura
                         GROUP BY CLIENTE.numero_cliente";
        $result_clientes = $conn->query($sql_clientes);

        if ($result_clientes->num_rows > 0) {
            while($row = $result_clientes->fetch_assoc()) {
                $total_quantidade = $row['total_quantidade'] > 0 ? $row['total_quantidade'] : "N/A";
                $total_valor = $row['total_valor'] > 0 ? $row['total_valor'] : "N/A";
                echo "<tr>
                        <td>" . $row['nome_cliente'] . "</td>
                        <td>" . $row['tipo'] . "</td>
                        <td>" . $row['NIF'] . "</td>
                        <td>" . $row['morada'] . "</td>
                        <td>" . $total_quantidade . "</td>
                        <td>" . $total_valor . "</td>
                      </tr>";
            }
        } else {
            echo "<tr><td colspan='6'>Nenhum cliente encontrado.</td></tr>";
        }
        ?>
    </table>

    <h2>Apagar Clientes Sem Faturas</h2>
    <form action="gestao_vendas.php" method="post">
        <input type="submit" name="delete_clients" value="Apagar Clientes Sem Faturas">
    </form>

    <?php
    if (isset($_POST['delete_clients'])) {
        $sql_delete = "DELETE FROM CLIENTE
                       WHERE numero_cliente NOT IN (SELECT DISTINCT CLIENTE_numero_cliente FROM FATURA)";
        if ($conn->query($sql_delete) === TRUE) {
            echo "Clientes sem faturas apagados com sucesso.";
        } else {
            echo "Erro ao apagar clientes: " . $conn->error;
        }
    }
    ?>
</body>
</html>
