{**********************************************************************************}
{ VESTIS PCP  - SISTEMA PARA INDUSTRIAS DE CONFEC��ES.                             } 
{                                                                                  } 
{ Este arquivo � parte do codigo-fonte do sistema VESTIS PCP, � um software livre; }
{ voc� pode redistribu�-lo e/ou modific�-lo dentro dos termos da GNU LGPL vers�o 3 }
{ como publicada pela Funda��o do Software Livre (FSF).                            }
{                                                                                  }
{ Este programa � distribu�do na esperan�a que possa ser �til, mas SEM NENHUMA     }
{ GARANTIA; sem uma garantia impl�cita de ADEQUA��O a qualquer MERCADO ou          }
{ APLICA��O EM PARTICULAR. Veja a Licen�a P�blica Geral GNU/LGPL em portugu�s      }
{ para maiores detalhes.                                                           }
{                                                                                  }
{ Voc� deve ter recebido uma c�pia da GNU LGPL vers�o 3, sob o t�tulo              }
{ "LICENCA.txt", junto com esse programa.                                          }
{ Se n�o, acesse <http://www.gnu.org/licenses/>                                    }
{ ou escreva para a Funda��o do Software Livre (FSF) Inc.,                         }
{ 51 Franklin St, Fifth Floor, Boston, MA 02111-1301, USA.                         }
{                                                                                  }
{                                                                                  }
{ Autor: Adriano Zanini -  vestispcp.indpcp@gmail.com                              }
{                                                                                  }
{**********************************************************************************}


{***********************************************************************************
**  SISTEMA...............: VESTIS PCP                                            **
**  DESCRI��O.............: SISTEMA ERP PARA INDUSTRIAS DE CONFEC��ES             **
**  LINGUAGEM/DB..........: DELPHI XE7  /  SQL SERVER 2014                        ** 
**  ANO...................: 2010 - 2018                                           ** 
**                                                                                **
** ------------------------------------------------------------------------------ **
**                                                                                **
**  AUTOR/DESENVOLVEDOR...: ADRIANO ZANINI                                        **
**  MINHAS AUTORIAS.......:  Vestis PCP e IndPCP                                  **
**  - VESTISPCP (� gratuito, disponivel no GitHub). N�o dou Suporte T�cnico.      **
**  - INDPCP (� pago). Dou Suporte T�cnico.                                       **
**                                                                                **
** -----------------------------------------------------------------------------  **
**                                                                                **
** - VESTISPCP � C�DIGO-FONTE LIVRE. O CODIGO-FONTE N�O PODE SER COMERCIALIZADO.  **
**                                                                                **
** - INDPCP � RESTRITO. SOMENTE EU, O AUTOR, POSSO COMERCIALIZAR O CODIGO-FONTE.  **
**                                                                                **
***********************************************************************************}

Unit FCidades;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   Buttons, ExtCtrls, StdCtrls, Menus, Mask, DBCtrls,ShellAPI, DB,  
      FFrameBotoes, FFrameBarra, ISFEdit, ISFEditbtn, ISFdbEditbtn,
  IDBEdit, uEstSearchDialogZeos,   FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
   TFrmCidades = class(TForm)
      GroupBox1: TGroupBox;
      Label5: TLabel;
    ds_Cidades: TDataSource;
    db_Cidades:  TFDQuery;
    db_CidadesCEP: TStringField;
    db_CidadesTIPO: TStringField;
    db_CidadesENDERECO: TStringField;
    db_CidadesBAIRRO: TStringField;
    db_CidadesCIDADE: TStringField;
    db_CidadesCIDADE_CODIGO: TStringField;
    db_CidadesUF: TStringField;
    db_CidadesUF_CODIGO: TIntegerField;
    EditCEP: TDBEdit;
    EditTipo: TDBEdit;
    EditEndereco: TDBEdit;
    FrmFrameBarra1: TFrmFrameBarra;
    EditBairro: TDBEdit;
    FrmFrameBotoes1: TFrmFrameBotoes;
    EditCodigoIBGE: TDBEdit;
    EditMunicipio: TDBEdit;
    EditCodigoIBGEUF: TDBEdit;
    EditUF: TDBEdit;
    CEPProcurar: TIDBEditDialog;
    db_CidadesAREAKM2: TBCDField;
    db_CidadesPOPULACAO: TIntegerField;
    DBAdvEdit1: TDBEdit;
    DBAdvEdit2: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FrmFrameBotoes1SpbAdicionarClick(Sender: TObject);
    procedure FrmFrameBotoes1SpbEditarClick(Sender: TObject);
    procedure FrmFrameBotoes1SpbSalvarClick(Sender: TObject);
    procedure FrmFrameBotoes1SpbCancelarClick(Sender: TObject);
    procedure FrmFrameBotoes1SpbExcluirClick(Sender: TObject);
    procedure FrmFrameBotoes1SpbSairClick(Sender: TObject);
    procedure db_CidadesBeforePost(DataSet: TDataSet);
    procedure FrmFrameBotoes1SpbProcurarClick(Sender: TObject);
    procedure EditCodigoIBGEKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
   private
      { Private declarations }
   public
      { Public declarations }
   end;

var
   FrmCidades: TFrmCidades;

implementation

uses FPrincipal, SQLServer, Biblioteca, Global, Classe.Usuarios;

{$R *.DFM}

procedure TFrmCidades.db_CidadesBeforePost(DataSet: TDataSet);
begin
   db_Cidades.ParamByname('CEP').AsInteger :=
     db_Cidades.FieldByName('CEP').AsInteger;


   if empty(db_Cidades.FieldByName('CEP').AsString) Then
   Begin
      AvisoSistema('Informe o CEP');
      EditCEP.Setfocus;
      Abort;
   End;

   if empty(db_Cidades.FieldByName('TIPO').AsString) Then
   Begin
      AvisoSistema('Informe o TIPO DE ENDERE�O (RUA/AVENIDA/PRA�A/ETC...)');
      EditTipo.Setfocus;
      Abort;
   End;

   if empty(db_Cidades.FieldByName('ENDERECO').AsString) Then
   Begin
      AvisoSistema('Informe o ENDERE�O');
      EditEndereco.Setfocus;
      Abort;
   End;

   if empty(db_Cidades.FieldByName('BAIRRO').AsString) Then
   Begin
      AvisoSistema('Informe o BAIRRO');
      EditBairro.Setfocus;
      Abort;
   End;

   if empty(db_Cidades.FieldByName('CIDADE_CODIGO').AsString) Then
   Begin
      AvisoSistema('Informe o CODIGO DA CIDADE fornecido pelo IBGE'+
               sLineBreak+
               sLineBreak+
               'Veja no site: '+
               sLineBreak+
               'http://www.ibge.gov.br/home/geociencias/areaterritorial/area.shtm'
               );
      EditCodigoIBGE.Setfocus;
      Abort;
   End;

   if empty(db_Cidades.FieldByName('CIDADE').AsString) Then
   Begin
      AvisoSistema('Informe o nome da CIDADE');
      EditMunicipio.Setfocus;
      Abort;
   End;

   if empty(db_Cidades.FieldByName('UF_CODIGO').AsInteger) Then
   Begin
      AvisoSistema('Informe o CODIGO DO ESTADO fornecido pelo IBGE'+
               sLineBreak+
               sLineBreak+
               'Veja no site: '+
               sLineBreak+
               'http://www.ibge.gov.br/home/geociencias/areaterritorial/area.shtm'
               );
      EditCodigoIBGEUF.Setfocus;
      Abort;
   End;

   if empty(db_Cidades.FieldByName('UF').AsString) Then
   Begin
      AvisoSistema('Informe a sigla do ESTADO');
      EditUF.Setfocus;
      Abort;
   End;


end;

procedure TFrmCidades.EditCodigoIBGEKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key=VK_HOME  then
   begin
     If pergunta('Acessar site do IBGE para Consulta de Munic�pio?')=false Then
        exit;
     strURL := 'http://www.ibge.gov.br/home/geociencias/areaterritorial/area.shtm';
     ShellExecute(0, nil, pchar(strURL), nil, nil, SW_SHOW);
   end;
end;

procedure TFrmCidades.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   db_Cidades.close;
   FreeAndNil(FrmCidades);
end;

procedure TFrmCidades.FormCreate(Sender: TObject);
begin
  FrmFrameBotoes1.DataSource :=ds_Cidades;
end;

procedure TFrmCidades.FrmFrameBotoes1SpbAdicionarClick(Sender: TObject);
begin
  FrmFrameBotoes1.SpbAdicionarClick(Sender);
  EditCEP.SetFocus;

end;

procedure TFrmCidades.FrmFrameBotoes1SpbCancelarClick(Sender: TObject);
begin
  FrmFrameBotoes1.SpbCancelarClick(Sender);

end;

procedure TFrmCidades.FrmFrameBotoes1SpbEditarClick(Sender: TObject);
begin
  FrmFrameBotoes1.SpbEditarClick(Sender);

end;

procedure TFrmCidades.FrmFrameBotoes1SpbExcluirClick(Sender: TObject);
begin
  FrmFrameBotoes1.SpbExcluirClick(Sender);

end;

procedure TFrmCidades.FrmFrameBotoes1SpbProcurarClick(Sender: TObject);
begin

   if CEPProcurar.Execute then
   begin
      db_Cidades.close;
      db_Cidades.ParamByName('CEP').AsInteger :=CEPProcurar.ResultFieldAsInteger('CEP');
      db_Cidades.open;

   end;

end;

procedure TFrmCidades.FrmFrameBotoes1SpbSairClick(Sender: TObject);
begin
  FrmFrameBotoes1.SpbSairClick(Sender);

end;

procedure TFrmCidades.FrmFrameBotoes1SpbSalvarClick(Sender: TObject);
begin
  FrmFrameBotoes1.SpbSalvarClick(Sender);

end;

end.
