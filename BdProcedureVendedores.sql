create database bdProcedure;
use bdProcedure;
Create table Vendedores
(Cod_Vendedor int not null auto_increment primary key,
Nome_Vendedor varchar(30),
CPF varchar(14),
Salario_Fixo decimal(10,2)
);

DELIMITER //
CREATE PROCEDURE Sp_InsereVendedor(Nome varchar(30),Num_CPF char(14), Salario decimal(10,2))
BEGIN
if exists (select CPF from Vendedores where CPF = Num_CPF) then
SELECT 'CPF ja cadastrado' AS Mensagem;
ELSE insert into Vendedores(nome_vendedor, CPF, Salario_Fixo)
Values(Nome, Num_CPF, Salario);
SELECT concat('Vendedor(a): ', nome, ' cadastrado(a) com sucesso!') AS Mensagem;
END IF; 
END;
//

call Sp_InsereVendedor('Pedro', '288.234.876-20', 900);

DELIMITER //
CREATE PROCEDURE Sp_ExcluirVendedor(codigo int)
BEGIN
if not exists (select Cod_Vendedor from Vendedores where Cod_Vendedor = codigo) then
SELECT 'Código inválido' AS Mensagem;
ELSE 
Delete from Vendedores where cod_vendedor = codigo;
SELECT  ('Registro excluído com sucesso!') AS Mensagem;
END IF; 
END;
//

call Sp_ExcluirVendedor(1);

DELIMITER //
CREATE PROCEDURE Sp_AlteraDados(codigo int, nome varchar(30))
BEGIN
if not exists (select Cod_Vendedor from Vendedores where Cod_Vendedor = codigo) then
SELECT 'Código inválido' AS Mensagem;
ELSE update Vendedores Set nome_vendedor =nome where cod_vendedor=codigo;
SELECT  ('Registro alterado com sucesso!') AS Mensagem;
END IF; 
END;
//

call Sp_AlteraDados(3,'Felipe Porto');

DELIMITER //
CREATE PROCEDURE Sp_Busca_Vendedor(codigo int)
BEGIN
if not exists (select Cod_Vendedor from Vendedores where Cod_Vendedor = codigo) then
SELECT 'Código inválido' AS Mensagem;
ELSE select * from Vendedores where Cod_Vendedor = codigo ;
END IF; 
END;
//
call Sp_Busca_Vendedor(2);

DELIMITER //
CREATE PROCEDURE Sp_Aumenta_Salario2(codigo int, percentual decimal (5,2))
BEGIN
if not exists (select Cod_Vendedor from Vendedores where Cod_Vendedor = codigo) then
SELECT 'Código inválido' AS Mensagem;
ELSE update Vendedores set Salario_Fixo = Salario_Fixo + (Salario_Fixo/100) * percentual where Cod_Vendedor = codigo;
Select * from Vendedores;
END IF; 
END;
//

call Sp_Aumenta_Salario2(2, 50);
select * from Vendedores;

