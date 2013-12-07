/****************************************************************************/
/*                                                                          */
/*  Torneo di CRobots (2013)                                                */
/*                                                                          */
/*  CROBOT: destro.r                                                        */
/*                                                                          */
/*  CATEGORIA: 500 istruzioni                                               */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo                                                   */
/*                                                                          */
/****************************************************************************/

/*

SCHEDA TECNICA:

  Anche quest'anno pochissimo tempo da dedicare, ho solo fatto un ritocchino a  
  lycan dello scorso anno! 

  Spero in qualcosa di meglio per il prossimo torneo ...  

*/

/*********************/
/* Variabili globali */
/*********************/

int x,y,b,dir,deg,rng,odeg,xs,ys,en,rd,timer,ff,xmax,xd,yd,xp,yp,dmax,dmin,zd;

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
 
	while(1) {
		if ((x=loc_x())>880) dir=180;
                else if (x<120) dir=0;
                else if ((y=loc_y())>880) dir=270;
                else if (y<120) dir=90;
		else if (rng>650) dir=deg;
		else if (rng<150) dir=deg+180;
		else dir=deg+180*(b^=1);
		Fire(dir,100);
		Fire(dir,100);
		Fire(dir,100);
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

  en-=((++timer>400) || (damage()>30)); 
  
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
