package main

import (
	"os"
	"github.com/ajstarks/svgo"
)

func main() {
	width := 500
	height := 500
	canvas := svg.New(os.Stdout)
	canvas.Start(width, height)

	body_w := 190;
	body_h := 100;

	pad_w := 60;
	pad_h := 30;

	color := "blue"

	canvas.Roundrect(0,pad_w+5,body_w,body_h,10,10,"fill:"+color);
	canvas.Circle(body_w-20, pad_w+25, 10,"fill:white");
	canvas.Text(body_w/2, pad_w+5+body_h*3/4, "GHDL","font-family:monospace;text-anchor:middle;font-size:60px;fill:white")

	for i:=0; i<2; i++ {
	    for j:=0; j<3; j++ {
		    canvas.Roundrect(j*(pad_w+5), pad_h+i*140, pad_w, pad_h, 10, 10,"fill:"+color);
		    canvas.Roundrect(j*(pad_w+5)+pad_h/2, i*170, pad_h, pad_w, 10, 10,"fill:"+color);
		}
	}
	canvas.End()
}
