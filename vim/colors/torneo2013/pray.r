/**************
 *            *
 * P R A Y .r *
 *            *
 **************

 Mini robot per il torneo 2013

 Michelangelo Messina                         


Il minirorobot e' una minima evoluzione di BEAT.r, di cui eredita tutti i difetti.
Il risultato e' abbastanza scadente... ma non so fare di meglio!


All'avvio si posiziona nell'angolo piu' vicino, e oscilla verticalmente
e orizzontalmente, senza restare mai fermo.
Le routine di fuoco e di attacco sono spudoratamente copiate da lycan.r


Qualcuno un giorno mi spiegherà come si fa a scrivere un crobots decente in 500 istruzioni macchina...

*/



int     deg,odeg,x,y,rng;
int     up,dx;
int     dir;
int     b,sc;



main()
{
    dx=(loc_x(up=(loc_y()>500))>500);
    if(up) {
            if(dx) sc=145;
            else sc=235;
    } else {
            if(dx) sc=55;
            else sc=325;
    }
    while (1) { 
    		if (dx) {
                        deg=180;
                        xmag(890);
                        s(xmin(925));
                } else {
                        deg=360;
                        xmin(110);
                        s(xmag(75));
                }

                if (up) {
                        deg=270;
                        ymag(890);
                        s(ymin(925));
                } else {
                        deg=90;
                        ymin(110);
                        s(ymag(75));
                }
		
                if(++b%6); else attacco(dir=sc);

    }
}


attacco()
{
                x=4;
                while((dir+=20)<sc+121) x-=(!scan(dir,10));
                if (x<0) {
			b=0;  
			while(1) {
				if ((x=loc_x())>880) dir=180;
		                else if (x<120) dir=0;
		                else if ((y=loc_y())>880) dir=270;
		                else if (y<120) dir=90;
				else if (rng>650) dir=deg;
				else if (rng<150) dir=deg+180;
				else dir=deg+180*(b^=1);
				m();
				m();
				m();
			}
                }
}



/* spostamento */
xmag(xx) { while(loc_x(m(dir=180))>xx); } 
xmin(xx) { while(loc_x(m(dir=360))<xx); } 
ymag(yy) { while(loc_y(m(dir=270))>yy); } 
ymin(yy) { while(loc_y(m(dir=90))<yy); } 

m()
{
     spara(drive(dir,100));
}

s()
{
     spara(drive(dir,0));
}




spara()
{
	if (rng=scan(odeg=deg,10)) {
		if (scan(deg-8,5)) { 	
			if (scan(deg-=5,2)) ; 
			else deg-=4; 
		} else {
			if (scan(deg+8,5)) {
				if (scan(deg+=5,2)) ; 
				else deg+=4; 
			} else {
				if (scan(deg,1)) ;
				else if (scan(deg-=3,2)) ; else deg+=6;
			}
		}
		return(cannon(deg,2*scan(deg,10)-rng)); 
	} else {
		if(rng=scan(deg+=20,10)) cannon(deg,rng);
		else if(rng=scan(deg-=40,10)) cannon(deg,rng);
		else deg+=80;
	}
}

