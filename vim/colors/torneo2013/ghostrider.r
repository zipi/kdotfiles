/****************************************************************************/
/*                                                                          */
/*  Torneo di CRobots (2013)                                                */
/*                                                                          */
/*  CROBOT: GhostRider.r                                                    */
/*                                                                          */
/*  CATEGORIA: midi                                                         */
/*                                                                          */
/*  AUTORE: Simone Ascheri                                                  */
/*                                                                          */
/****************************************************************************/

/*
Non ho il tempo di farla, ma tanto questo robot lo riconoscerete tutti.

*/

/*********************/
/* Variabili globali */
/*********************/

int x,y,b,dir,deg,rng,odeg,xs,ys,en,rd,timer,ff,xmax,xd,yd,xp,yp,dmax,dmin,zd,dam;
int orng;




/**********************/
/* ROUTINE PRINCIPALE */
/**********************/

main()
{

/****************************************************/
/* FASE 0: Calcolo parametri e ritirata nell'angolo */
/****************************************************/

	xp=60+(xs=loc_x(yp=60+(ys=(loc_y(en=3))>499)*880)>499)*880;
	drive(xd=180*xs,100); 
	dmax=(dmin=zd=((yd=90+180*ys)-105+90*(xs^ys)))+100;
  
/******************************/
/* FASE 1: Difesa nell'angolo */
/******************************/

	while(en>1) {
		Run(xd,xp,2-xs);	
		Run(yd,yp,6-ys);	
	}

/*******************/
/* FASE 2: Attacco */
/*******************/

	++ff;  
 	if(loc_y(x=(loc_x()>500))>500) {
                if(x) deg=195;
                else deg=285;
        } else {
                if(x) deg=105;
                else deg=375;
        }
            while(1) {
		if(orng>580) dir=deg+25+(b^=1)*225;
		else if(orng>150) dir=deg+80+(b^=1)*200;
                else dir=(deg/90)*90;                               
                if ((x=loc_x(y=loc_y()))>835) dir=165+30*(y>500);
                else if (x<165) dir=345+30*(y<500);
                else if (y>835) dir=255+30*(x<500);
                else if (y<165) dir=75+30*(x>500);
		else if(dam>75) dir+=180;
                dam=damage(spara(drive(dir,100)));
		if(scan(deg-15,10)) deg-=4;
		if(scan(deg+15,10)) deg+=4;
		spara(drive(dir,100));                
            }

}

/********************/
/* Routine di fuoco */
/********************/

Fire(dir,v)
{
	drive(dir,v);
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
		return(cannon(deg+ff*(deg-odeg),2*scan(deg,10)-rng)); 
	} else {
		if(rng=scan(deg+=20,10)) cannon(deg,rng);
		else if(rng=scan(deg-=40,10)) cannon(deg,rng);
		else deg+=80;
	}
}

/*********************************/
/* Routines utilizzate in FASE 1 */
/*********************************/

Run(d,l,m) { 
  int r;
  if (timer%12==2) {
    en=0;
    while (dmin<=dmax) en+=(scan(dmin+=20,10)>0);
    dmin=zd; 
  }
  
  while(r<2) {
  drive(d,100);
  
  ++r;
  if (++timer>500+damage()) en=1; 
  
  if (scan(d,10)) { deg=d; while (scan(d,10)>840) ; } else while(Check(l,m)) ;
    
   
  Fire(d,0);  
  while(speed()>59) ;
  ++m;  
  d+=180;
  } 
}

Check(l,m) {
  int c1;
  if (m<5) c1=loc_x(); else c1=loc_y();
  if (m%2) return (c1>l); else return (c1<l);	
}	


spara()
{
        if ((orng=scan(deg, 10)) ) { 
                if (scan(deg-15,10)) { 
                        if (scan(deg-=13,4)) { 
                                if(scan(deg-3,5)) deg-=5;
                                else ++deg;
                        }  else if (scan(deg-5,5)) deg-=5;
                } else if(scan(deg+14,10)) { 
                        if (scan(deg+=13,5)) deg+=5;
                        else --deg;
                }  else if(scan(deg+4,5)) deg+=5;
                else deg-=5;

        }  else if ((orng=scan(deg-=20,10))) { 
                if (scan(deg-9,10)) { 
                        if (scan(deg-=13,5)) deg-=5;
                        else ++deg;
                } else if(scan(deg+9,10)) deg+=6; 
        }  else if ((orng=scan(deg+=40,10))) { 
                if (scan(deg+9,10)) deg+=12;
        }  else if ((orng=scan(deg+=20,10)));
	else {
		if ((orng=scan(deg-=80,10))) return cannon(deg,orng);
		else if ((orng=scan(deg-=20,10))) return cannon(deg,orng);
		else if ((orng=scan(deg+=120,10))) return cannon(deg,orng);
		else if ((orng=scan(deg+=20,10))) return cannon(deg,orng);
		else if ((orng=scan(deg-=160,10))) return cannon(deg,orng);
		else return deg+=260;
	}  
        if (rng=scan(deg,10)){  
                cannon (deg, rng*145/(145+orng-rng) ); 
        }  else if(scan(deg-20,10)) deg-=21; 
        else if(scan(deg+=20,10));
	else deg+=40; 
} 





