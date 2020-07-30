
#include "cd/include/cd.h"
#include "cd/include/cd_old.h"

int extraMM2Pixel ( cdCanvas * canvas, int mm, int isx )
{
	double mmdx;
	double mmdy;
	int    pixelx;
	int    pixely;
	mmdx = mmdy = 0;
	pixelx = pixely = 0;
	if (isx) {
		mmdx = (double)mm;
	}
	else {
		mmdy = (double)mm;
	}
	cdCanvasMM2Pixel(canvas, mmdx, mmdy, &pixelx, &pixely );

	return isx ? pixelx : pixely ;
}

int extraPixel2MM ( cdCanvas * canvas, int pixel, int isx )
{
	double mmdx;
	double mmdy;
	int    pixelx;
	int    pixely;
	mmdx = mmdy = 0;
	pixelx = pixely = 0;
	if (isx) {
		pixelx = pixel;
	}
	else {
		pixely = pixel;
	}
	cdCanvasPixel2MM(canvas, pixelx, pixely, &mmdx, &mmdy );

	return isx ? mmdx : mmdy ;
}

int extraCanvasGetWidth(cdCanvas *canvas)
{
	double width;
	cdCanvasGetSize(canvas, 0, 0, &width, 0);
	return (int) width;
}
int extraCanvasGetHeigth(cdCanvas *canvas)
{
	double high;
	cdCanvasGetSize(canvas, 0, 0, 0, &high);
	return (int) high;
}
