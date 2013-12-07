/****************************************************************************/
/*                                                                          */
/*  Torneo di CRobots (2013)                                                */
/*                                                                          */
/*  CROBOT: pjanic.r                                                        */
/*                                                                          */
/*  CATEGORIA: 2000 istruzioni                                              */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo                                                   */
/*                                                                          */
/****************************************************************************/

/*

SCHEDA TECNICA:

  Rimando draka, solo per avere il 4 robot, non ho proprio fatto in tempo a fare altro ...  
  
*/
/*********************/
/* Variabili globali */
/*********************/

int deg,rng,dir,odeg,orng,b,x,y,en,yHigh,xHigh,xLim,yLim,xOut,yOut,zOut,timer,timer2,dmin,dmax,t,xd,yd,zd,wd,welcome,dam;

main()
{
	/* Conta gli avversari */
	while (deg<360) 
		if (scan(deg+=20,10)) {
			en+=1;
			if (!welcome) {
				cannon(deg,scan(deg,10));
				welcome=1;
			}
		}
	
	/* Se f2f o scontro a 3 usa le tattiche specifiche */
	if (en==1) f2f();
	else if (en==2) {
		en=0; 
		while (deg) if (scan(deg-=20,10)) ++en;
		if (en==2) vs2(); 
	}
	
		
	/* Vai nell'angolo */
	if (yHigh=(loc_y()>500)) {
		while (loc_y()<880) fuoco(90,100);
		drive(90,0);
	} else {
		while (loc_y()>120) fuoco(270,100);		
		drive(270,0);
	}
	if (xHigh=(loc_x()>500)) {
		while (loc_x()<880) fuoco(0,100);		
		drive(0,0);
	} else {
		while (loc_x()>120) fuoco(180,100);
		drive(180,0);
	} 
		
	/* Calcola i parametri utilizzati nell'angolo */
	yLim=60+yHigh*880;
	xLim=60+xHigh*880;
	xOut=180*xHigh; 
	dmax=(dmin=zOut=((yOut=90+180*yHigh)-105+90*(xHigh^yHigh)))+100;

	/* Oscilla */ 
	while(en>1) {
		run(xOut,xLim,2-xHigh);	
		run(yOut,yLim,6-yHigh);	
	}
			
	f2f();
	
}

/*********************/
/* Routine di fuoco  */
/*********************/

fire()
{
	if ((orng=scan(odeg=deg,10))) {
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
		return cannon(deg+deg-odeg,scan(deg,10));
	} else {
		if (orng=scan(deg+=340,10)) return cannon(deg,2*scan(deg,10)-orng);
		if (orng=scan(deg+=40,10)) return cannon(deg,2*scan(deg,10)-orng);
		if (scan(deg+=300,10)) return cannon(deg,scan(deg,10));
		if (scan(deg+=80,10)) return cannon(deg,scan(deg,10));
		if (en>1) 
			if(scan(dir,10)) 
				return deg=dir; 
		deg+=60;
	}
}

fuoco(dir,v)
{
	drive(dir,v);
	if (rng=scan(odeg=deg,10)) {
		if (scan(deg-8,5))  { if (scan(deg-=5,2)) ; else deg-=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
		if (scan(deg+8,5))  { if (scan(deg+=5,2)) ; else deg+=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
		if (scan(deg,10))   { if (scan(deg-=2,2)) ; else deg+=4; return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); }
	}
	else if(scan(deg+=20,10));
	else if(scan(deg-=40,10));
	else if(scan(dir,10)) deg=dir;
	else deg+=77;
}

/***********************************/
/* Routines utilizzate nell'angolo */
/***********************************/

run(d,l,m) { 

	int r;

	/* Conta gli avversari */
	if (timer%12==2) {
		en=0;
		while (dmin<=dmax) en+=(scan(dmin+=20,10)>0);
		dmin=zOut; 
		if (en==2) 
			vs2(); 
		
		if (timer>400)
			if (en==3)
				if (damage()<40)
					{ vs3(); f2f(); }
	}

	/* Esegue i 2 movimenti della oscillazione */	
	while(++r<3) {
	
		drive(d,100);
		
		if (++timer>550) en=1; 
		if (scan(d,10)) {  while (scan(deg=d,10)>840) ; } else while(check(l,m)) ;
		fire(drive(d,0));  
		while(speed()>59) ;
		++m;  
		d+=180;
	} 
}

check(l,m) {
	/* Verifica la vicinanza al perimetro di gioco */
	int c1;
	if (m<5) c1=loc_x(); else c1=loc_y();
	if (m%2) return (c1>l); else return (c1<l);	
}	

/* Attacco in f2f */
f2f() {
	while(1) {			
        if ((x=loc_x(y=loc_y()))>880) dir=160+40*(y>500);
        else if (x<120) dir=340+40*(y<500);
        else if ((y)>880) dir=250+40*(x<500);
        else if (y<120) dir=70+40*(x>500);                        

		else if (orng>600) dir=deg+25+(b^=1)*235;
		else if (orng<150) dir=deg+170+(b^=1)*25;
		else dir=deg+180*(b^=1);
		
		drive(dir,100);		
		fire();
		drive(dir,100);		
		fire();
		fire();
		drive(dir,100);		
					
		drive(dir,60);
    }
}

/* Attacco contro 2 avversari */
vs2() {
	while(1) {
		while (loc_x()<930) fuoco(0,100);
		fuoco(90,0);
		while (loc_y()<930) fuoco(90,100);
		fuoco(180,0);
		while (loc_x()>70) fuoco(180,100);
		fuoco(270,0);
		while (loc_y()>70) fuoco(270,100);
		fuoco(0,0);
	} 
}

/* Attacco contro 3 avversari */
vs3() {

	if (xHigh) {
		if (yHigh) {
			xd=135; yd=315; zd=225;
		} else {
			xd=225; yd=45; zd=135;
		}
	} else {
		if (yHigh) {
			xd=45; yd=225; zd=315;
		} else {
			xd=315; yd=135; zd=45;
		}
	}	
	wd=zd+180;
	
	dam=damage()+40;
	
	while(damage()<dam) {
		
		deg=xd;
		if (xHigh) {
			while (loc_x()>550) fuoco(180,100);
			drive(180,0);
			while (loc_x()<600) fuoco(0,100);
			drive(0,0);
		} else {
			while (loc_x()<450) fuoco(0,100);
			drive (0,0);
			while (loc_x()>400) fuoco(180,100);
			drive (180,0);
		}
		
		deg=yd;
		if (yHigh) {
			while (loc_y()>550) fuoco(270,100);
			drive(270,0);
			while (loc_y()<600) fuoco(90,100);
			drive(90,0);
		} else {
			while (loc_y()<450) fuoco(90,100);
			drive (90,0);
			while (loc_y()>400) fuoco(270,100);
			drive (270,0);
		}
		
		while (scan(wd,10)) {
			deg=wd;
			if (yHigh) {
				while (loc_y()<650) fuoco(wd,100);
				drive (wd,0);
				while (loc_y()>600) fuoco(zd,100);
				drive (zd,0);
			} else {
				while (loc_y()>450) fuoco(wd,100);
				drive(wd,0);
				while (loc_y()<400) fuoco(zd,100);
				drive(zd,0);
			}		
		}

		deg=zd;
		if (yHigh) {
			while (loc_y()>500) fuoco(zd,100);
			drive(zd,0);
			while (loc_y()<600) fuoco(wd,100);
			drive(wd,0);
		} else {
			while (loc_y()<500) fuoco(zd,100);
			drive (zd,0);
			while (loc_y()>400) fuoco(wd,100);
			drive (wd,0);
		}		
	
	}

}
