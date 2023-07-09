unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

const
  delta = 30;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  deltaX, deltaY, deltaEll : integer;
  sh, col1, col, angle : integer;
  flagreverse, flagRevEll: boolean;

implementation

{$R *.lfm}

{ TForm1 }

procedure ClearScreen(Canvas: TCanvas);
begin
     Canvas.Clear;
     Canvas.Clear;
end;

procedure rotate(var x : integer; var y : integer; angle : double);
var
  xbuf : double;
  rangle : double;
begin
   rangle := angle * pi / 180;
   xbuf := x * cos(rangle) + y * sin(rangle);
   y := Trunc(-x * sin(rangle) + y * cos(rangle));
   x := Trunc(xbuf);
end;

procedure Sky(Canvas: TCanvas);
begin
     Canvas.Pen.Width := 2;
     Canvas.Pen.Color := clBlack;
     Canvas.Brush.Color := RGBToColor(22 , col1 , col);
     Canvas.Rectangle(-10, -10, 1500, 1500);
end;

procedure Clouds(Canvas: TCanvas);
begin
     Canvas.Pen.Width := 1;
     Canvas.Pen.Color := clBlack;
     Canvas.Brush.Color := clWhite;
     Canvas.Ellipse(0+3*sh, -60, 280+3*sh, 104);
end;

procedure Sun(Canvas: TCanvas);
begin
     Canvas.Pen.Width := 1;
     Canvas.Pen.Color := clYellow;
     Canvas.Brush.Color := clYellow;
     Canvas.Ellipse(0+sh, 0+sh, 200+sh, 200+sh);
end;

procedure Fence (Canvas: TCanvas);
var
  i, maxy : integer;
begin
maxy := 500;
for i := 6 to 100 do  begin
         Canvas.Pen.Width := 1;
         Canvas.Pen.Color := clBlack;
         Canvas.Brush.Color := RGBToColor(153 , 113 , 110);
         Canvas.Rectangle(i*20, maxy, 22 + i*20, maxy-80);
         Canvas.Polygon([Point(i*20, maxy-80),
         Point(10 + i*20, maxy-95), Point(22 + i*20, maxy-80)]);
     end;
end;

procedure Grass(Canvas: TCanvas);
begin
     Canvas.Pen.Width := 1;
     Canvas.Pen.Color := RGBToColor(133 , 183 , 138);
     Canvas.Brush.Color := RGBToColor(133 , 183 , 138);
     Canvas.Rectangle(0, 500, 1500, 1500);
end;

procedure Clock(Canvas: TCanvas);
begin
     Canvas.Pen.Width := 5;
     Canvas.Pen.Color := clBlack;
     Canvas.Brush.Color := clWhite;
     Canvas.Ellipse(910, 10, 1010, 110);
end;

procedure House(Canvas: TCanvas);
begin
     Canvas.Pen.Width := 2;
    Canvas.Brush.Color := clGray;
    Canvas.Rectangle(10,300,250,600);
    Canvas.Polygon([Point(0,300),Point(130,250),Point(260,300)]);
    Canvas.Brush.Color := clWhite;
    Canvas.Rectangle(30,350,110,433);
    Canvas.Rectangle(150,350,230,750);

    Canvas.Brush.Color := clGray;
    Canvas.Polygon([Point(150,300),Point(150,220),Point(210,230),Point(210,300)]);

    Canvas.Pen.Width := 4;
    Canvas.Line(65,350,65, 430);
end;

procedure Rain(Canvas: TCanvas);
begin
     Canvas.Pen.Width := 3;
     Canvas.Pen.Color := clBlack;
     Canvas.Brush.Color := clSkyBlue;
     Canvas.Ellipse(10, -10+sh, 20, -20+sh);

     Canvas.Ellipse(90, -10+2*sh, 100, -20+2*sh);

     Canvas.Ellipse(170, -10+sh*3, 180, -20+sh*3);

     Canvas.Ellipse(250, -10+sh, 260, -20+sh);

     Canvas.Ellipse(340, -10+sh*3, 350, -20+sh*3);
     Canvas.Ellipse(340, -10+sh, 350, -20+sh);

     Canvas.Ellipse(560, -10+sh*3, 570, -20+sh*3);

     Canvas.Ellipse(660, -10+sh*3, 670, -20+sh*3);

     Canvas.Ellipse(860, -10+sh*2, 870, -20+sh*2);

     Canvas.Ellipse(960, -10+sh, 970, -20+sh);
     Canvas.Ellipse(960, -10+sh*2, 970, -20+sh*2);
end;

procedure DrawPic(Canvas: TCanvas);
var
   x, y: integer;
begin
     ClearScreen(Canvas);

     Sky(Canvas);
     Clouds(Canvas);
     Sun(Canvas);
     Fence(Canvas);
     House(Canvas);
     Rain(Canvas);
     Grass(Canvas);
     Clock(Canvas);


     Canvas.Pen.Color := clBlue;
     Canvas.Pen.Width := 5;

     x := 30;
     y := 30;
     rotate(x, y, angle);

     Canvas.Pen.Color := clBlack;
     Canvas.Line(920 + deltaX, 20 + deltaY , 920 + x + deltaX, 20 + y + deltaY);

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
     flagreverse := False;
     timer1.Enabled := True;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
     timer1.Enabled := False;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  deltaX := 40;
  deltaY := 40;
  angle := 0;
  col := 255;
  col1 := 249;
  sh := 0;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if flagreverse then
     angle := angle + 5
  else
    begin
         angle := angle - 5;
         col := col - 3;
         col1 := col1 - 3;
         sh := sh + 10;
    end;
  if col < 45 then
    timer1.Enabled := False
  else
      DrawPic(Canvas);
end;

end.
