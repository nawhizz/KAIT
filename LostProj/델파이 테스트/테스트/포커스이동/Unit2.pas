unit Unit2;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

procedure pSetKeyPress(Sender : TObject;var key : Char);

procedure pSetEnter(Sender : TObject);

implementation

procedure pSetKeyPress(Sender : TObject;var key : Char);
begin
  (Sender as TEdit).OnEnter := psetEnter;
end;

procedure pSetEnter(Sender : TObject);
begin
  (Sender as Tedit).SelectAll;
end;
end.
 