/* 

Nome: 	okapi.r		(macro)
Autore: Franco Cartieri
Email: 	cartierif@tin.it

Torneo 2013

Descrizione robot:
E' semplicemente Leopon con l'aggiunta di una routine specifica per il 3vs3, nei test che ho fatto peggiora le prestazioni.
Vediamo come si comporta.
*/

int x,y,dir,rng,orng,deg,odeg,asin,acos,xs,ys,en,timer,xd,yd,xp,yp,dmax,dmin,zd,nc,t,xmd,ymd;

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


Stop(dir) { drive(dir,0);  while(speed()>59); }

Ymin(dis,dir) { while(loc_y()<dis)	Fire(dir); 	Stop(dir); }

Ymax(dis,dir) { while(loc_y()>dis)	Fire(dir); 	Stop(dir); }

Xmin(dis,dir) { while(loc_x()<dis)	Fire(dir); 	Stop(dir); }

Xmax(dis,dir) { while(loc_x()>dis)	Fire(dir); 	Stop(dir); }

Look(d) { return (scan(d-10,10)+scan(d+10,10)); }

Radar() { int ang; en=0; ang=dmin; while (ang<=dmax) en+=(scan(ang+=20,10)>0); }

Fire(dir)
{
  	int asin,acos;
	if(scan(dir,10))
		deg = dir;
  	if (speed()<100) drive(dir,100); 	
	else 	
	{
		if(rng > 850) deg+=180;
	}
  	if (scan(deg,10) > 100)
  	{  
	      	asin=(sin(deg-dir)/14384);
      		acos=(cos(deg-dir)/3796)-230;
	      	deg-=18*(scan(deg-18,10)>0);  
      		deg+=18*(scan(deg+18,10)>0); 
	      	if(scan(deg-16,10)) deg-=8;
      		else if(scan(deg+16,10)) deg+=8;
	      	if(scan(deg-12,10)) deg-=4;
      		else if(scan(deg+12,10)) deg+=4;
	      	if(scan(deg-11,10)) deg-=2;
      		if(scan(deg+11,10)) deg+=2;
	      	if (orng=scan(odeg=deg,3))
     		{
        	    	if(scan(deg-13,10)) deg-=5;
            		else if(scan(deg+13,10)) deg+=5; 
        	    	if(scan(deg+12,10)) deg+=4;
	            	else if(scan(deg-12,10)) deg-=4;
            		if(scan(deg-11,10)) deg-=2;
	            	if(scan(deg+11,10)) deg+=2;
        	    	cannon(deg+(deg-odeg)*((880+(rng=scan(deg,10)))/482)-asin, rng*230/(orng-rng-acos)); 
     		}  
		else 	Search(); 
  	} 
	else 	Search();  
}

Search()
{
  	if (scan(deg-=350,10)) return FireXX();
  	if (scan(deg-=20,10))  return FireXX();
  	if (scan(deg-=320,10)) return FireXX();
  	if (scan(deg-=60,10))  return FireXX();
  	if (scan(deg-=280,10)) return FireXX();
  	if (scan(deg-=100,10)) return FireXX();
  	if (scan(deg-=240,10)) return FireXX();
  	if (scan(deg-=140,10)) return FireXX();
  	if (scan(deg-=200,10)) return FireXX();
  	if (scan(deg-=180,10)) return FireXX();
  	if (scan(deg-=160,10)) return FireXX();
  	if (scan(deg-=220,10)) return FireXX();
  	if (scan(deg-=120,10)) return FireXX();
	if (scan(deg-=260,10)) return FireXX();
}

FireXX()
{
  	if (rng=scan(odeg=deg,10)) 
	{    
    		if (scan(deg-13,10))  { if (scan(deg-=5,2)) ; else deg-=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
    		if (scan(deg+13,10))  { if (scan(deg+=5,2)) ; else deg+=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
    		if (scan(deg,10))     { if (scan(deg-=2,2)) ; else deg+=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
  	}  
	else 	Search();
}

main()
{
	xp=60+(xs=loc_x(yp=60+(ys=(loc_y(en=3))>499)*880)>499)*880;
  	if (xs=loc_x()>499) Xmin(850,0); else Xmax(150,180); 
  	if (ys=loc_y(xd=180*xs)>499) Ymin(850,90); else Ymax(150,270);
	dmax=(dmin=(yd=90+180*ys)+90*(xs^ys)-105)+100;
    	if (xs) { if (ys) { xmd=200; ymd=250; } else { xmd=160; ymd=110; } } 
	else {  if (ys) { xmd=340; ymd=290; } else { xmd=20; ymd=70; }  }
    	Radar();
	while((en>2) && (timer < 300) && (damage() < 50))
	{
    		run(xd,xp,2-xs);	
	    	run(yd,yp,6-ys);	
  	}
 	while (en>1) 
	{
		while(Look(xd) || Look(yd) || en) 
		{
			if (++timer>400+damage()) f2f();
			en=0;
      			if((nc+=1)<20)
			{
				if(t%2) { if(!Look(xd)) t+=1; }
				else    { if(!Look(yd)) t+=1; }
			}
			else t+=1;
			if(t%2)
			{
		     		if (ys) Ymax(450,ymd);    else Ymin(550,ymd); 
			      	if (xs) Xmin(850,xd-180); else Xmax(150,xd-180);
			      	if (ys) Ymin(850,yd-180); else Ymax(150,yd-180);
			}
			else
			{
		      		if (xs) Xmax(450,xmd);    else Xmin(550,xmd);
	     			if (ys) Ymin(850,yd-180); else Ymax(150,yd-180);
			      	if (xs) Xmin(850,xd-180); else Xmax(150,xd-180);
			}	
		}
	    	Radar();
  	}
	f2f();
}

fireto(deg)
{
	if (orng=scan(deg,10)) 
		return cannon(deg,2*scan(deg,10)-orng);
	else 	return 0;
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
		if(fireto(deg+=340))	return;
		if(fireto(deg+=40))	return;
		deg+=80;
	}
}

run(d,l,m) 
{ 
	int r;
  	if(timer%12==2)
	{
		Radar();
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
 	if (m<5) c1=loc_x(); 	else c1=loc_y();
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
