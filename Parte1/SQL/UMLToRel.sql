drop table if exists plantação ;
drop table if exists newname_-1146088802 ;
drop table if exists newname_119802942 ;
drop table if exists colheita ;
drop table if exists regiao ;
drop table if exists vinha ;
drop table if exists vinho ;
drop table if exists edicao ;
drop table if exists prémio ;
drop table if exists enologos ;
drop table if exists casta ;
drop table if exists trabalhador ;
drop table if exists produtor ;
drop table if exists notasDegustacao ;
drop table if exists colaborador ;
drop table if exists cliente ;
drop table if exists venda ;
drop table if exists fatura ;
drop table if exists linhaFatura ;
drop table if exists devolução ;
drop table if exists data ;
drop table if exists tipoVinho ;
drop table if exists tipoEdição ;
drop table if exists tipoCliente ;
 
create table plantação
(
   vinha_codigoID_   Integer   not null,
   casta_casta_ID_   integer   not null,
   data_data_ID   integer   not null,
   áreaCultivada   double   null,
 
   constraint PK_plantação primary key (vinha_codigoID_, casta_casta_ID_)
);
 
create table newname_-1146088802
(
   edicao_ano_   Integer   not null,
   casta_casta_ID_   integer   not null,
 
   constraint PK_newname_-1146088802 primary key (edicao_ano_, casta_casta_ID_)
);
 
create table newname_119802942
(
   produtor_email_   text   not null,
   colaborador_numero_   Integer   not null,
 
   constraint PK_newname_119802942 primary key (produtor_email_, colaborador_numero_)
);
 
create table colheita
(
   regiao_denominacao   text   not null,
   enologos_colaborador_numero   Integer   not null,
   produtor_email   text   not null,
   anoColheita   Integer   not null,
   dataInicio   data   not null,
   dataFim   data   null,
   quantidade   double   null,
 
   constraint PK_colheita primary key (anoColheita, dataInicio)
);
 
create table regiao
(
   denominacao   text   not null,
 
   constraint PK_regiao primary key (denominacao)
);
 
create table vinha
(
   colheita_anoColheita   Integer   not null,
   colheita_dataInicio   data   not null,
   codigoID   Integer   not null,
   nome   text   null,
 
   constraint PK_vinha primary key (codigoID)
);
 
create table vinho
(
   regiao_denominacao   text   not null,
   produtor_email   text   not null,
   venda_venda_ID   integer   not null,
   data_data_ID   integer   not null,
   tipoVinho_tipoVinho_ID   integer   not null,
   quantidadeVinho   Integer   null,
   nome   text   not null,
   teorAlcool   double   null,
   classificacao   double   null,
 
   constraint PK_vinho primary key (nome)
);
 
create table edicao
(
   vinho_nome   text   not null,
   ano   Integer   not null,
   volumeProducao   double   null,
 
   constraint PK_edicao primary key (ano)
);
 
create table prémio
(
   edicao_ano   Integer   not null,
   data_data_ID   integer   not null,
   nome   text   not null,
   entidade   text   null,
 
   constraint PK_prémio primary key (edicao_ano, nome)
);
 
create table enologos
(
   colaborador_numero   Integer   not null,
   especializacao   text   null,
 
   constraint PK_enologos primary key (colaborador_numero)
);
 
create table casta
(
   casta_ID   integer   not null,
   tipoUva   text   null,
 
   constraint PK_casta primary key (casta_ID)
);
 
create table trabalhador
(
   colheita_anoColheita   Integer   not null,
   colheita_dataInicio   data   not null,
   trabalhador_colaborador_numero   Integer   null,
   colaborador_numero   Integer   not null,
   horas   Integer   null,
   remuneração   double   null,
   funcao   text   null,
 
   constraint PK_trabalhador primary key (colaborador_numero)
);
 
create table produtor
(
   nome   text   null,
   email   text   not null,
   morada   text   null,
   cpp   Integer   null,
   telefone   Integer   null,
 
   constraint PK_produtor primary key (email)
);
 
create table notasDegustacao
(
   notasDegustacao_ID   integer   not null,
   aroma   text   null,
   sabor   text   null,
   cor   text   null,
 
   constraint PK_notasDegustacao primary key (notasDegustacao_ID)
);
 
create table colaborador
(
   numero   Integer   not null,
   nome   text   null,
 
   constraint PK_colaborador primary key (numero)
);
 
create table cliente
(
   tipoCliente_tipoCliente_ID   integer   not null,
   nome   text   null,
   nif   Integer   not null,
   morada   text   null,
   número   Integer   null,
 
   constraint PK_cliente primary key (nif)
);
 
create table venda
(
   cliente_nif   Integer   not null,
   fatura_numero   Integer   not null,
   data_data_ID   integer   not null,
   venda_ID   integer   not null,
 
   constraint PK_venda primary key (venda_ID)
);
 
create table fatura
(
   venda_venda_ID   integer   not null,
   numero   Integer   not null,
   montanteTotal   double   null,
 
   constraint PK_fatura primary key (numero)
);
 
create table linhaFatura
(
   fatura_numero   Integer   not null,
   devolução_devolução_ID   integer   null,
   linhaFatura_ID   integer   not null,
   nºGarrafas   Integer   null,
   dimensão   double   null,
   preço   double   null,
 
   constraint PK_linhaFatura primary key (fatura_numero, linhaFatura_ID)
);
 
create table devolução
(
   data_data_ID   integer   not null,
   devolução_ID   integer   not null,
   montante   double   null,
 
   constraint PK_devolução primary key (devolução_ID)
);
 
create table data
(
   data_ID   integer   not null,
   dia   Integer   null,
   mes   Integer   null,
   ano   Integer   null,
 
   constraint PK_data primary key (data_ID)
);
 
create table tipoVinho
(
   tipoVinho_ID   integer   not null,
   tipo   text   null,
 
   constraint PK_tipoVinho primary key (tipoVinho_ID)
);
 
create table tipoEdição
(
   edicao_ano   Integer   not null,
   tipoEdição_ID   integer   not null,
   tipo   text   null,
 
   constraint PK_tipoEdição primary key (tipoEdição_ID)
);
 
create table tipoCliente
(
   tipoCliente_ID   integer   not null,
   tipo   text   null,
 
   constraint PK_tipoCliente primary key (tipoCliente_ID)
);
 
alter table plantação
   add constraint FK_vinha_plantação_casta_ foreign key (vinha_codigoID_)
   references vinha(codigoID)
   on delete cascade
   on update cascade
; 
alter table plantação
   add constraint FK_casta_plantação_vinha_ foreign key (casta_casta_ID_)
   references casta(casta_ID)
   on delete cascade
   on update cascade
; 
alter table plantação
   add constraint FK_plantação_dataPlantacao_data foreign key (data_data_ID)
   references data(data_ID)
   on delete restrict
   on update cascade
;
 
alter table newname_-1146088802
   add constraint FK_edicao_newname_-1146088802_casta_ foreign key (edicao_ano_)
   references edicao(ano)
   on delete cascade
   on update cascade
; 
alter table newname_-1146088802
   add constraint FK_casta_newname_-1146088802_edicao_ foreign key (casta_casta_ID_)
   references casta(casta_ID)
   on delete cascade
   on update cascade
;
 
alter table newname_119802942
   add constraint FK_produtor_newname_119802942_colaborador_ foreign key (produtor_email_)
   references produtor(email)
   on delete cascade
   on update cascade
; 
alter table newname_119802942
   add constraint FK_colaborador_newname_119802942_produtor_ foreign key (colaborador_numero_)
   references colaborador(numero)
   on delete cascade
   on update cascade
;
 
alter table colheita
   add constraint FK_colheita_colheitaDe_regiao foreign key (regiao_denominacao)
   references regiao(denominacao)
   on delete restrict
   on update cascade
; 
alter table colheita
   add constraint FK_colheita_acompanha_enologos foreign key (enologos_colaborador_numero)
   references enologos(colaborador_numero)
   on delete restrict
   on update cascade
; 
alter table colheita
   add constraint FK_colheita_noname_produtor foreign key (produtor_email)
   references produtor(email)
   on delete restrict
   on update cascade
;
 
 
alter table vinha
   add constraint FK_vinha_plantadas_colheita foreign key (colheita_anoColheita, colheita_dataInicio)
   references colheita(anoColheita, dataInicio)
   on delete restrict
   on update cascade
;
 
alter table vinho
   add constraint FK_vinho_origina_regiao foreign key (regiao_denominacao)
   references regiao(denominacao)
   on delete restrict
   on update cascade
; 
alter table vinho
   add constraint FK_vinho_produz_produtor foreign key (produtor_email)
   references produtor(email)
   on delete restrict
   on update cascade
; 
alter table vinho
   add constraint FK_vinho_quantidade_venda foreign key (venda_venda_ID)
   references venda(venda_ID)
   on delete restrict
   on update cascade
; 
alter table vinho
   add constraint FK_vinho_dataEngarrafamento_data foreign key (data_data_ID)
   references data(data_ID)
   on delete restrict
   on update cascade
; 
alter table vinho
   add constraint FK_vinho_tipo_tipoVinho foreign key (tipoVinho_tipoVinho_ID)
   references tipoVinho(tipoVinho_ID)
   on delete restrict
   on update cascade
;
 
alter table edicao
   add constraint FK_edicao_noname_vinho foreign key (vinho_nome)
   references vinho(nome)
   on delete restrict
   on update cascade
;
 
alter table prémio
   add constraint FK_prémio_compostaPor_edicao foreign key (edicao_ano)
   references edicao(ano)
   on delete cascade
   on update cascade
; 
alter table prémio
   add constraint FK_prémio_atribuidoem_data foreign key (data_data_ID)
   references data(data_ID)
   on delete restrict
   on update cascade
;
 
alter table enologos
   add constraint FK_enologos_colaborador foreign key (colaborador_numero)
   references colaborador(numero)
   on delete cascade
   on update cascade
;
 
 
alter table trabalhador
   add constraint FK_trabalhador_info_colheita foreign key (colheita_anoColheita, colheita_dataInicio)
   references colheita(anoColheita, dataInicio)
   on delete restrict
   on update cascade
; 
alter table trabalhador
   add constraint FK_trabalhador_noname_trabalhador foreign key (trabalhador_colaborador_numero)
   references trabalhador(colaborador_numero)
   on delete set null
   on update cascade
; 
alter table trabalhador
   add constraint FK_trabalhador_colaborador foreign key (colaborador_numero)
   references colaborador(numero)
   on delete cascade
   on update cascade
;
 
 
 
 
alter table cliente
   add constraint FK_cliente_tipo_tipoCliente foreign key (tipoCliente_tipoCliente_ID)
   references tipoCliente(tipoCliente_ID)
   on delete restrict
   on update cascade
;
 
alter table venda
   add constraint FK_venda_venda_cliente foreign key (cliente_nif)
   references cliente(nif)
   on delete restrict
   on update cascade
; 
alter table venda
   add constraint FK_venda_fatura_fatura foreign key (fatura_numero)
   references fatura(numero)
   on delete restrict
   on update cascade
; 
alter table venda
   add constraint FK_venda_dataDeVenda_data foreign key (data_data_ID)
   references data(data_ID)
   on delete restrict
   on update cascade
;
 
alter table fatura
   add constraint FK_fatura_fatura_venda foreign key (venda_venda_ID)
   references venda(venda_ID)
   on delete restrict
   on update cascade
;
 
alter table linhaFatura
   add constraint FK_linhaFatura_variasLinhas_fatura foreign key (fatura_numero)
   references fatura(numero)
   on delete cascade
   on update cascade
; 
alter table linhaFatura
   add constraint FK_linhaFatura_noname_devolução foreign key (devolução_devolução_ID)
   references devolução(devolução_ID)
   on delete set null
   on update cascade
;
 
alter table devolução
   add constraint FK_devolução_dataDevolucao_data foreign key (data_data_ID)
   references data(data_ID)
   on delete restrict
   on update cascade
;
 
 
 
alter table tipoEdição
   add constraint FK_tipoEdição_noname_edicao foreign key (edicao_ano)
   references edicao(ano)
   on delete restrict
   on update cascade
;
 
 
