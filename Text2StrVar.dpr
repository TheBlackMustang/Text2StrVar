program Text2StrVar;

uses
  System.Classes,
  System.SysUtils,
  IO in 'IO.pas';

var
  FilenameInput: string;
  FilenameOutput: string;
  InList: TStringList;
  i, n: Integer;
  s: string;
begin
  ParseCMDLine(FilenameInput, FilenameOutput);
  InList := TStringList.Create;
  try
    InList.LoadFromFile(FilenameInput);
    n := InList.Count - 1;
    for i := 0 to n do begin
      s := InList.Strings[i];
      if s = '' then begin
        if i <> n then
          InList.Strings[i] := '    #13#10 +'
        else
          InList.Strings[i] := '    '';';
      end else begin
        if i <> n then
          InList.Strings[i] := '    ''' + InList.Strings[i] + ''' + #13#10 +'
        else
          InList.Strings[i] := '    ''' + InList.Strings[i] + ''';';
      end;
    end;
    InList.Insert(0, 'const');
    InList.Insert(1, '  S :=');
    InList.SaveToFile(FilenameOutput);
    Writeln('Use this directive {$I <FilenameOutput>} for adding this string in a project or use "copy-paste" into your code.');
  finally
    InList.Free;
  end;
end.
