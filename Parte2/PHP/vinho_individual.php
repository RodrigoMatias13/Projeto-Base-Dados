<!DOCTYPE html>
<html>
<head>
    <title>Detalhes do Vinho</title>
</head>
<body>
    <h1>Detalhes do Vinho</h1>

    <?php
    include 'db_connect.php';

    if (isset($_GET['id'])) {
        $vinho_id = $_GET['id'];

        $sql_vinho = "SELECT * FROM VINHO WHERE VINHO_ID = $vinho_id";
        $result_vinho = $conn->query($sql_vinho);

        if ($result_vinho->num_rows > 0) {
            $vinho = $result_vinho->fetch_assoc();

            $regiao_id = $vinho['REGIAO_ID'];
            $sql_regiao = "SELECT * FROM REGIAO WHERE REGIAO_ID = $regiao_id";
            $result_regiao = $conn->query($sql_regiao);
            $regiao = $result_regiao->fetch_assoc();

            $produtor_id = $vinho['PRODUTOR_ID'];
            $sql_produtor = "SELECT * FROM PRODUTOR WHERE PRODUTOR_ID = $produtor_id";
            $result_produtor = $conn->query($sql_produtor);
            $produtor = $result_produtor->fetch_assoc();

            $sql_edicoes = "SELECT EDICAO_ID FROM EDICAO WHERE VINHO_ID = $vinho_id";
            $result_edicoes = $conn->query($sql_edicoes);
            $edicoes = [];
            while ($row = $result_edicoes->fetch_assoc()) {
                $edicoes[] = $row['EDICAO_ID'];
            }

            $premios = [];
            foreach ($edicoes as $edicao_id) {
                $sql_premios = "SELECT PREMIO.nome_distincao FROM PREMIO
                                JOIN GANHA ON PREMIO.PREMIO_ID = GANHA.PREMIO_ID
                                WHERE GANHA.EDICAO_ID = $edicao_id";
                $result_premios = $conn->query($sql_premios);
                while ($row = $result_premios->fetch_assoc()) {
                    $premios[] = $row['nome_distincao'];
                }
            }

            echo "<h2>Detalhes do Vinho</h2>";
            echo "<p>Nome: " . $vinho['nome'] . "</p>";
            echo "<p>Data de Engarrafamento: " . $vinho['data_engarrafamento'] . "</p>";
            echo "<p>Teor Alcoólico: " . $vinho['teor_alcoolico'] . "</p>";
            echo "<p>Tipo: " . $vinho['tipo'] . "</p>";
            echo "<p>Classificação: " . $vinho['classificacao'] . "</p>";
            echo "<p>Cor: " . $vinho['cor'] . "</p>";
            echo "<p>Aroma: " . $vinho['aroma'] . "</p>";
            echo "<p>Sabor: " . $vinho['sabor'] . "</p>";

            echo "<h3>Região</h3>";
            echo "<p>Nome da Região: " . $regiao['denominacao'] . "</p>";

            echo "<h3>Produtor</h3>";
            echo "<p>Nome do Produtor: " . $produtor['nome_vinicola'] . "</p>";

            echo "<h3>Prémios</h3>";
            if (!empty($premios)) {
                echo "<ul>";
                foreach ($premios as $premio) {
                    echo "<li>" . $premio . "</li>";
                }
                echo "</ul>";
            } else {
                echo "Nenhum prémio encontrado.";
            }
        } else {
            echo "Vinho não encontrado.";
        }
    } else {
        echo "ID do vinho não fornecido.";
    }
    ?>
</body>
</html>
