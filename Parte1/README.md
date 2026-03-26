# Parte 1 – Modelação e Implementação da Base de Dados

Esta parte do projeto corresponde à **modelação e implementação da base de dados** do sistema VINISYS, para gestão de uma empresa distribuidora de vinhos.

---

## Objetivo

Construir a estrutura da base de dados com base nos requisitos fornecidos, garantindo a correta representação de todas as entidades e relações do sistema.

---

## Conteúdo

* `sql/` – Scripts SQL para:

  * Criação de tabelas
  * Definição de relações
  * Inserção de dados

* `modelagem/` – Diagramas desenvolvidos em BoUML

* `relatorio/` – Documento descritivo da solução

---

## Modelação do Sistema

A base de dados inclui entidades como:

* **Colheitas** – ano, datas e quantidade produzida
* **Vinhas e castas** – produção agrícola
* **Vinhos e edições** – características e produção
* **Produtores** – informação da empresa vinícola
* **Colaboradores** – enólogos e trabalhadores
* **Clientes e vendas** – faturação e devoluções

---

## Funcionalidades

* Representação das relações entre entidades
* Suporte a múltiplas colheitas e vinhos
* Registo de prémios e distinções
* Gestão de vendas e devoluções

---

## Como Utilizar

1. Executar os scripts SQL no SGBD
2. Criar a base de dados
3. Inserir os dados iniciais
4. Validar o modelo através de queries simples

---

## Observações

* A modelação foi feita com base no enunciado fornecido
* O sistema foi desenhado para garantir consistência e integridade dos dados
* Serve de base para as funcionalidades desenvolvidas na Parte 2
