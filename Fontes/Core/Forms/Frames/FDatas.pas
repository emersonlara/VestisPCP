{**********************************************************************************}
{ VESTIS PCP  - SISTEMA PARA INDUSTRIAS DE CONFECÇÕES.                             } 
{                                                                                  } 
{ Este arquivo é parte do codigo-fonte do sistema VESTIS PCP, é um software livre; }
{ você pode redistribuí-lo e/ou modificá-lo dentro dos termos da GNU LGPL versão 3 }
{ como publicada pela Fundação do Software Livre (FSF).                            }
{                                                                                  }
{ Este programa é distribuído na esperança que possa ser útil, mas SEM NENHUMA     }
{ GARANTIA; sem uma garantia implícita de ADEQUAÇÃO a qualquer MERCADO ou          }
{ APLICAÇÃO EM PARTICULAR. Veja a Licença Pública Geral GNU/LGPL em português      }
{ para maiores detalhes.                                                           }
{                                                                                  }
{ Você deve ter recebido uma cópia da GNU LGPL versão 3, sob o título              }
{ "LICENCA.txt", junto com esse programa.                                          }
{ Se não, acesse <http://www.gnu.org/licenses/>                                    }
{ ou escreva para a Fundação do Software Livre (FSF) Inc.,                         }
{ 51 Franklin St, Fifth Floor, Boston, MA 02111-1301, USA.                         }
{                                                                                  }
{                                                                                  }
{ Autor: Adriano Zanini -  vestispcp.indpcp@gmail.com                              }
{                                                                                  }
{**********************************************************************************}


{***********************************************************************************
**  SISTEMA...............: VESTIS PCP                                            **
**  DESCRIÇÃO.............: SISTEMA ERP PARA INDUSTRIAS DE CONFECÇÕES             **
**  LINGUAGEM/DB..........: DELPHI XE7  /  SQL SERVER 2014                        ** 
**  ANO...................: 2010 - 2018                                           ** 
**                                                                                **
** ------------------------------------------------------------------------------ **
**                                                                                **
**  AUTOR/DESENVOLVEDOR...: ADRIANO ZANINI                                        **
**  MINHAS AUTORIAS.......:  Vestis PCP e IndPCP                                  **
**  - VESTISPCP (é gratuito, disponivel no GitHub). Não dou Suporte Técnico.      **
**  - INDPCP (é pago). Dou Suporte Técnico.                                       **
**                                                                                **
** -----------------------------------------------------------------------------  **
**                                                                                **
** - VESTISPCP É CÓDIGO-FONTE LIVRE. O CODIGO-FONTE NÃO PODE SER COMERCIALIZADO.  **
**                                                                                **
** - INDPCP É RESTRITO. SOMENTE EU, O AUTOR, POSSO COMERCIALIZAR O CODIGO-FONTE.  **
**                                                                                **
***********************************************************************************}

unit FDatas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask;

type

   TFrameDatas = class(TFrame)
      GrupoFrameData: TGroupBox;
      MskDataFim: TMaskEdit;
      Label4: TLabel;
      MskDataIni: TMaskEdit;
      Label3: TLabel;
      procedure FrameEnter(Sender: TObject);
      procedure MskDataFimExit(Sender: TObject);
      procedure MskDataIniExit(Sender: TObject);

   private

   public

   end;

implementation

uses Global, Biblioteca;

{$R *.dfm}


procedure TFrameDatas.MskDataIniExit(Sender: TObject);
begin
   MskDataIni.text := fncDataValidar(MskDataIni.text);
end;

procedure TFrameDatas.MskDataFimExit(Sender: TObject);
begin

   MskDataFim.text := fncDataValidar(MskDataFim.text);

   if StrToDate(MskDataIni.text) > StrToDate(MskDataFim.text) then
   begin
      BeepCritica;
      Informar('Data Final deve ser igual ou maior que a data Inicial' + #13 +
        #10 + 'Verifique.');

      MskDataFim.Setfocus;
   end;

end;

procedure TFrameDatas.FrameEnter(Sender: TObject);
begin
   MskDataIni.text := DateToStr(Date);
   MskDataFim.text := DateToStr(Date);
   MskDataIni.Setfocus;
end;

end.
