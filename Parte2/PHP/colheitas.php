<!DOCTYPE html>
<html>
<head>
    <title>Gestão de Colheitas</title>
</head>
<body>
    <h1>Gestão de Colheitas</h1>

    <h2>Registar Nova Colheita</h2>
    <form action="colheitas.php" method="post">
        <label for="ano">Ano:</label>
        <input type="number" id="ano" name="ano" required><br><br>

        <label for="data_inicio">Data de Início (YYYY-MM-DD):</label>
        <input type="date" id="data_inicio" name="data_inicio" required><br><br>

        <label for="regiao">Região:</label>
        <select id="regiao" name="regiao" required>
            <option value="">Selecione uma região</option>
            <?php
            include 'db_connect.php';
            $sql_regioes = "SELECT DISTINCT denominacao FROM REGIAO";
            $result_regioes = $conn->query($sql_regioes);
            while($row = $result_regioes->fetch_assoc()) {
                echo "<option value='" . $row['denominacao'] . "'>" . $row['denominacao'] . "</option>";
            }
            ?>
        </select><br><br>

        <label for="produtor">Produtor:</label>
        <select id="produtor" name="produtor" required>
            <option value="">Selecione um produtor</option>
            <?php
            $sql_produtores = "SELECT DISTINCT nome_vinicola FROM PRODUTOR";
            $result_produtores = $conn->query($sql_produtores);
            while($row = $result_produtores->fetch_assoc()) {
                echo "<option value='" . $row['nome_vinicola'] . "'>" . $row['nome_vinicola'] . "</option>";
            }
            ?>
        </select><br><br>

        <input type="submit" name="register" value="Registar Colheita">
    </form>

    <h2>Finalizar Colheita</h2>
    <form action="colheitas.php" method="post">
        <label for="id">ID da Colheita:</label>
        <input type="number" id="id" name="id" required><br><br>

        <label for="data_fim">Data de Fim:</label>
        <input type="date" id="data_fim" name="data_fim" required><br><br>

        <label for="quantidade">Quantidade Colhida:</label>
        <input type="number" step="0.01" id="quantidade" name="quantidade" required><br><br>

        <input type="submit" name="update" value="Finalizar Colheita">
    </form>

    <?php
    $error_message = "";

    if (isset($_SERVER["REQUEST_METHOD"]) && $_SERVER["REQUEST_METHOD"] == "POST") {
        if (isset($_POST['register'])) {
            $ano = $_POST['ano'];
            $data_inicio = $_POST['data_inicio'];
            $regiao = $_POST['regiao'];
            $produtor = $_POST['produtor'];

            $sql_regiao = "SELECT REGIAO_ID FROM REGIAO WHERE denominacao = '$regiao'";
            $result_regiao = $conn->query($sql_regiao);

            $sql_produtor = "SELECT PRODUTOR_ID FROM PRODUTOR WHERE nome_vinicola = '$produtor'";
            $result_produtor = $conn->query($sql_produtor);

            if ($result_regiao->num_rows > 0 && $result_produtor->num_rows > 0) {
                $row_regiao = $result_regiao->fetch_assoc();
                $regiao_id = $row_regiao['REGIAO_ID'];

                $row_produtor = $result_produtor->fetch_assoc();
                $produtor_id = $row_produtor['PRODUTOR_ID'];

                $sql = "INSERT INTO COLHEITA (REGIAO_ID, PRODUTOR_ID, ano, data_inicio) VALUES ('$regiao_id', '$produtor_id', '$ano', '$data_inicio')";

                if ($conn->query($sql) === TRUE) {
                    echo "Nova colheita registada com sucesso!";
                } else {
                    $error_message = "Erro: " . $sql . "<br>" . $conn->error;
                }
            } else {
                $error_message = "Região ou Produtor não encontrado.";
            }
        } elseif (isset($_POST['update'])) {
            $id = $_POST['id'];
            $data_fim = $_POST['data_fim'];
            $quantidade = $_POST['quantidade'];

            $sql = "UPDATE COLHEITA SET data_fim='$data_fim', quantidade='$quantidade' WHERE COLHEITA_ID='$id'";

            $result_colheita = $conn->query("SELECT COLHEITA_ID FROM COLHEITA WHERE COLHEITA_ID='$id'");

            if ($result_colheita->num_rows > 0) {
                if ($conn->query($sql) === TRUE) {
                    echo "Colheita finalizada com sucesso!";
                } else {
                    $error_message = "Erro: " . $sql . "<br>" . $conn->error;
                }
            } else {
                $error_message = "Colheita não encontrada.";
            }
        }
    }
    ?>

    <?php if ($error_message != ""): ?>
        <div style="border: 1px solid red; padding: 10px; margin-top: 20px; color: red;">
            <?php echo $error_message; ?>
        </div>
    <?php endif; ?>
</body>
</html>
