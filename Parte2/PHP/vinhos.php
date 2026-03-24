<!DOCTYPE html>
<html>
<head>
    <title>Gestão de Vinhos</title>
</head>
<body>
    <h1>Listagem de Vinhos</h1>

    <?php
    include 'db_connect.php';

    // List all wines
    $sql = "SELECT VINHO.VINHO_ID, VINHO.nome, VINHO.tipo, REGIAO.denominacao AS regiao
            FROM VINHO
            JOIN REGIAO ON VINHO.REGIAO_ID = REGIAO.REGIAO_ID";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        echo "<ul>";
        while($row = $result->fetch_assoc()) {
            echo "<li><a href='vinho_individual.php?id=" . $row['VINHO_ID'] . "'>" . $row['nome'] . " - " . $row['tipo'] . " - " . $row['regiao'] . "</a></li>";
        }
        echo "</ul>";
    } else {
        echo "Nenhum vinho encontrado.";
    }
    ?>

    <h2>Pesquisar Vinho por ID</h2>
    <form action="vinhos.php" method="get">
        <label for="vinho_id">ID do Vinho:</label>
        <input type="number" id="vinho_id" name="vinho_id" required><br><br>
        <input type="submit" value="Pesquisar">
    </form>

    <?php
    if (isset($_GET['vinho_id'])) {
        $vinho_id = $_GET['vinho_id'];
        header("Location: vinho_individual.php?id=$vinho_id");
        exit();
    }
    ?>

    <h2>Listar Vinhos por Região</h2>
    <form action="vinhos.php" method="get">
        <label for="denominacao">Região:</label>
        <select id="denominacao" name="denominacao" required>
            <option value="">Selecione uma região</option>
            <?php
            $sql_regioes = "SELECT DISTINCT denominacao FROM REGIAO";
            $result_regioes = $conn->query($sql_regioes);
            while($row = $result_regioes->fetch_assoc()) {
                echo "<option value='" . $row['denominacao'] . "'>" . $row['denominacao'] . "</option>";
            }
            ?>
        </select><br><br>
        <input type="submit" value="Listar">
    </form>

    <?php
    if (isset($_GET['denominacao'])) {
        $denominacao = $_GET['denominacao'];
        $sql_regiao = "SELECT VINHO.VINHO_ID, VINHO.nome, VINHO.tipo, REGIAO.denominacao AS regiao
                       FROM VINHO
                       JOIN REGIAO ON VINHO.REGIAO_ID = REGIAO.REGIAO_ID
                       WHERE REGIAO.denominacao = '$denominacao'";
        $result_regiao = $conn->query($sql_regiao);

        if ($result_regiao->num_rows > 0) {
            echo "<h2>Vinhos da Região</h2>";
            echo "<ul>";
            while($row = $result_regiao->fetch_assoc()) {
                echo "<li><a href='vinho_individual.php?id=" . $row['VINHO_ID'] . "'>" . $row['nome'] . " - " . $row['tipo'] . " - " . $row['regiao'] . "</a></li>";
            }
            echo "</ul>";
        } else {
            echo "Nenhum vinho encontrado para esta região.";
        }
    }
    ?>

    <h2>Listar Vinhos por Características</h2>
    <form action="vinhos.php" method="get">
        <label for="tipo">Tipo:</label>
        <select id="tipo" name="tipo">
            <option value="">Selecione um tipo</option>
            <?php
            $sql_tipos = "SELECT DISTINCT tipo FROM VINHO";
            $result_tipos = $conn->query($sql_tipos);
            while($row = $result_tipos->fetch_assoc()) {
                echo "<option value='" . $row['tipo'] . "'>" . $row['tipo'] . "</option>";
            }
            ?>
        </select><br><br>

        <label for="classificacao">Classificação:</label>
        <select id="classificacao" name="classificacao">
            <option value="">Selecione uma classificação</option>
            <?php
            $sql_classificacoes = "SELECT DISTINCT classificacao FROM VINHO";
            $result_classificacoes = $conn->query($sql_classificacoes);
            while($row = $result_classificacoes->fetch_assoc()) {
                echo "<option value='" . $row['classificacao'] . "'>" . $row['classificacao'] . "</option>";
            }
            ?>
        </select><br><br>

        <label for="cor">Cor:</label>
        <select id="cor" name="cor">
            <option value="">Selecione uma cor</option>
            <?php
            $sql_cores = "SELECT DISTINCT cor FROM VINHO";
            $result_cores = $conn->query($sql_cores);
            while($row = $result_cores->fetch_assoc()) {
                echo "<option value='" . $row['cor'] . "'>" . $row['cor'] . "</option>";
            }
            ?>
        </select><br><br>

        <label for="aroma">Aroma:</label>
        <select id="aroma" name="aroma">
            <option value="">Selecione um aroma</option>
            <?php
            $sql_aromas = "SELECT DISTINCT aroma FROM VINHO";
            $result_aromas = $conn->query($sql_aromas);
            while($row = $result_aromas->fetch_assoc()) {
                echo "<option value='" . $row['aroma'] . "'>" . $row['aroma'] . "</option>";
            }
            ?>
        </select><br><br>

        <label for="sabor">Sabor:</label>
        <select id="sabor" name="sabor">
            <option value="">Selecione um sabor</option>
            <?php
            $sql_sabores = "SELECT DISTINCT sabor FROM VINHO";
            $result_sabores = $conn->query($sql_sabores);
            while($row = $result_sabores->fetch_assoc()) {
                echo "<option value='" . $row['sabor'] . "'>" . $row['sabor'] . "</option>";
            }
            ?>
        </select><br><br>

        <input type="submit" value="Listar">
    </form>

    <?php
    if (isset($_GET['tipo']) || isset($_GET['classificacao']) || isset($_GET['cor']) || isset($_GET['aroma']) || isset($_GET['sabor'])) {
        $sql_caracteristicas = "SELECT VINHO.VINHO_ID, VINHO.nome, VINHO.tipo, REGIAO.denominacao AS regiao
                                FROM VINHO
                                JOIN REGIAO ON VINHO.REGIAO_ID = REGIAO.REGIAO_ID
                                WHERE 1=1";

        if (isset($_GET['tipo']) && !empty($_GET['tipo'])) {
            $tipo = $_GET['tipo'];
            $sql_caracteristicas .= " AND VINHO.tipo = '$tipo'";
        }
        if (isset($_GET['classificacao']) && !empty($_GET['classificacao'])) {
            $classificacao = $_GET['classificacao'];
            $sql_caracteristicas .= " AND VINHO.classificacao = '$classificacao'";
        }
        if (isset($_GET['cor']) && !empty($_GET['cor'])) {
            $cor = $_GET['cor'];
            $sql_caracteristicas .= " AND VINHO.cor = '$cor'";
        }
        if (isset($_GET['aroma']) && !empty($_GET['aroma'])) {
            $aroma = $_GET['aroma'];
            $sql_caracteristicas .= " AND VINHO.aroma = '$aroma'";
        }
        if (isset($_GET['sabor']) && !empty($_GET['sabor'])) {
            $sabor = $_GET['sabor'];
            $sql_caracteristicas .= " AND VINHO.sabor = '$sabor'";
        }

        $result_caracteristicas = $conn->query($sql_caracteristicas);

        if ($result_caracteristicas->num_rows > 0) {
            echo "<h2>Vinhos com Características Selecionadas</h2>";
            echo "<ul>";
            while($row = $result_caracteristicas->fetch_assoc()) {
                echo "<li><a href='vinho_individual.php?id=" . $row['VINHO_ID'] . "'>" . $row['nome'] . " - " . $row['tipo'] . " - " . $row['regiao'] . "</a></li>";
            }
            echo "</ul>";
        } else {
            echo "Nenhum vinho encontrado com as características selecionadas.";
        }
    }
    ?>
</body>
</html>
