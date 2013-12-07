/* 

Nome: 	axolotl.r		(micro)
Autore: Franco Cartieri
Email: 	cartierif@tin.it

Torneo 2013

Descrizione robot:
Axolotl è l'ennesima rivisitazione di Minion e simili.
All'inizio dell'incontro si posiziona nell'angolo e inizia a muoversi lungo i lati dell'arena prima orizzontalmente poi verticalmente 
senza mai allontanarsi troppo dall'angolo.
Ogni 12 cicli controlla il numero di avversari, se ne è rimasto uno solo inizia l'attacco finale.
Anche se il numero di oscillazioni supera una certa soglia parte all'attacco anche se è rimasto più di un nemico 
nella speranza che siano già abbastanza danneggiati.
L'attacco finale consiste in una serie di oscillazioni veloci volte a mantenere il nemico ad una distanza abbastanza costante.

*/

int rng,orng,deg,odeg,x,y,xs,ys,en,timer,xd,yd,xp,yp,dmax,dmin,zd;

main()
{
	xp=60+(xs=loc_x(yp=60+(ys=(loc_y(en=3))>499)*880)>499)*880;
  	drive(xd=180*xs,100); 
 	dmax=(dmin=zd=((yd=(90+180*ys))-105+90*(xs^ys)))+100;
 	while(en>1) 
	{
    		run(xd,xp,2-xs);	
	    	run(yd,yp,6-ys);	
  	}
	f2f();	
}

fire(dir,v)
{
	drive(dir,v);
	if (rng=scan(odeg=deg,10)) 
	{
		if (scan(deg-8,5))  
		{ 	
			if (scan(deg-=5,2)) ; 
			else deg-=4; 
		}
		else
		{
			if (scan(deg+8,5))  
			{
				if (scan(deg+=5,2)) ; 
				else deg+=4; 
			}
			else 
			{
				if (scan(deg,1)) ;
				else if (scan(deg-=3,2)) ; else deg+=6;
			}
		}
		return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); 
	} 
	else 
	{
		if(rng=scan(deg+=20,10)) cannon(deg,rng);
		else if(rng=scan(deg-=40,10)) cannon(deg,rng);
		else deg+=80;	
	}
}

run(d,l,m) 
{ 
  	int r;
  	if(timer%12==2)
	{
    		en=0;
    		while (dmin<=dmax) en+=(scan(dmin+=20,10)>0);
    		dmin=zd; 
  	}
  	while((++r)<3) 
	{
	  	drive(d,100);
 		if (++timer>400+damage()) f2f();
    		if (scan(d,10)) 
		{ 
			deg=d; 
			while (scan(d,10)>840) ; 
		} 
		else 	while(check(l,m)) ;
	     	fire(d,0);  
  		while(speed()>59) ;
  		++m;  
  		d+=180;
  	} 
}

check(l,m) 
{
  	int c1;
  	if (m<5) c1=loc_x(); else c1=loc_y();
  	if (m%2) return (c1>l); else return (c1<l);	
}	

f2f()
{
	int b,dir;
	while(1) 
	{
		if (((x=loc_x())%850)<150) dir=180*(x>500);
		else if (((y=loc_y())%850)<150) dir=90+180*(y>500);
		else if (rng>600) dir=deg;
		else if (rng<200) dir=deg+180;
		else dir=deg+180*(b^=1);
		fire(dir,100);
		fire(dir,100); 
		fire(dir,100);
	}
}
