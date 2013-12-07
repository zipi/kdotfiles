/* 

Nome:	guanaco.r		(midi)
Autore: Franco Cartieri
Email: 	cartierif@tin.it

Torneo 2013

Descrizione robot:
Guanaco è sostanzialmente Leopon, con l'unica modifica che l'oscillazione nel 4vs4 non è fatta contro le pareti dell'angolo
ma un po più verso il centro dell'arena.
Ad ogni ciclo controlla se nel proprio angolo è presente un robot.
Migliora leggermente nel f2f, ma peggiora pesantemente nel 4vs4.
*/

int x,y,dir,rng,orng,deg,odeg,xs,ys,en,timer,xd,yd,xp,yp,dmax,dmin,zd,angolo;

spara(dir)
{
	drive(dir,100);
	if ((orng=scan(deg, 10)) ) 
	{ 
		if (scan(deg-9,5)) 
		{ 
			if (scan(deg-=13,5)) 
			{ 
				if(scan(deg-3,5)) deg-=5; 
				else ++deg;
			}  
			else 
			{	
				if (scan(deg-5,5)) deg-=5;
				else ++deg;
			}
		} 
		else 	
		{
			if(scan(deg+9,5)) 
			{ 
				if (scan(deg+=13,5)) deg+=5;
				else --deg;
			}  
			else 	
			{
				if(scan(deg+5,5)) deg+=5;
				else --deg;
			}
		}
	}  
	else 	
	{
		if ((orng=scan(deg-=20,10))) 
		{ 
			if (scan(deg-9,10)) 
			{ 
				if (scan(deg-=13,5)) deg-=5;
				else ++deg;
			} 
			else 
			{	
				if(scan(deg+9,10)) deg+=5; 
				else --deg;
        		}  
		}
		else 	
		{
			if ((orng=scan(deg+=40,10))) 
			{ 
     	        	 	if (scan(deg+9,10)) deg+=12;
			}  
			else 	
			{
				if ((orng=scan(deg+=20,10)));
				else 
				{ 
					if (orng=scan(deg-=80,10)) 		return cannon(deg,orng); 
					else if (orng=scan(deg-=20,10)) 	return cannon(deg,orng); 	
					else if (orng=scan(deg+=120,10)) 	return cannon(deg,orng); 	
					else if (orng=scan(deg+=20,10))		return cannon(deg,orng); 	
					else if (orng=scan(deg-=160,10))	return cannon(deg,orng); 
					else return deg+=260;
				} 
			}
		}
	}
   	if (rng=scan(deg,10))
	{    
		cannon (deg, rng*135/(135+orng-rng) ); 
		if(rng>1000) 
			return deg+=40;
     	}  
	else if(scan(deg-20,10)) deg-=20; 
        	else if(scan(deg+=20,10));
			else deg+=40; 
} 

count()
{
   	while (dmin<=dmax) en+=(scan(dmin+=20,10)>0);
	dmin=zd; 
}

main()
{
	xp=300+(xs=loc_x(yp=300+(ys=(loc_y(en=0))>499)*400)>499)*400;
	drive(dir=((xd=180*xs)+180),100);
	while(check(xp,3-xs)) drive(dir,100);
	fire(dir,0);  
     	while(speed()>59);
	drive(dir=((yd=90+180*ys)+180),100);
	while(check(yp,7-ys)) drive(dir,100);
	fire(dir,0);  
     	while(speed()>59);

	count(dmax=(dmin=zd=(yd-115+90*(xs^ys)))+120);
	angolo = dmin+250;

  	while(en>1) 
	{
    		run(xd,xp,2-xs);	
	    	run(yd,yp,6-ys);	
  	}
	f2f();
}

fire(dir, v)
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
		if(rng=scan(deg+=20,10)) 	cannon(deg,rng);
		else if(rng=scan(deg-=40,10)) 	cannon(deg,rng);
		else deg+=80;	
	}
}

run(d,l,m) 
{ 
  	int r;
  	if(timer%12==2)
	{
		count(en=0);
  	}
  	while((++r)<3) 
	{
	  	drive(d,100);
 		if (++timer>400+damage()) f2f();
	 	if (scan(d,10)) 
			deg=d; 
		else	if (scan(angolo,10)) 
				deg=angolo; 
		while(check(l,m)) ;
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
	int b,fp;
	while(1) 
	{
		if ((x=loc_x(y=loc_y()))>850) dir=155+50*(y>500);
             	else 	if (x<150) dir=335+50*(y<500);
         	else 	if (y>850) dir=245+50*(x<500);
            	else 	if (y<150) dir=65+50*(x>500);
		else 
		{
 			if (orng<600) dir=deg+80+(b^=1)*190;
			else  dir=deg+50+(b^=1)*230; 
		}
		spara(dir);
		++fp; if(fp>5) ++fp; fp=5; 
		spara(dir);
	}
}
