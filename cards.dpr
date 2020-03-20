program cards;

uses
  System.StartUpCopy,
  FMX.Forms,
  unt_main in 'unt_main.pas' {frm_cards};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_cards, frm_cards);
  Application.Run;
end.
