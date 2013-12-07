/****************************************************************************/
/*                                                                          */
/*  Torneo di CRobots (2013)                                                */
/*                                                                          */
/*  CROBOT: osvaldo.r                                                       */
/*                                                                          */
/*  CATEGORIA: 500 istruzioni                                               */
/*                                                                          */
/*  AUTORE: Daniele Nuzzo                                                   */
/*                                                                          */
/****************************************************************************/

/*

SCHEDA TECNICA:

  lycan versione f2f, va bene nei test micro dello scorso torneo, vedremo 
  quest'anno...
  
*/

/*********************/
/* Variabili globali */
/*********************/

int x,y,b,dir,deg,rng,odeg;

/**********************/
/* ROUTINE PRINCIPALE */
/**********************/

main()
{

/***********/
/* Attacco */
/***********/

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
		return(cannon(deg+(deg-odeg),2*scan(deg,10)-rng)); 
	} else {
		if(rng=scan(deg+=20,10)) cannon(deg,rng);
		else if(rng=scan(deg-=40,10)) cannon(deg,rng);
		else if(rng=scan(deg+=60,10)) cannon(deg,rng);
		else if(rng=scan(deg-=80,10)) cannon(deg,rng);
		else deg+=120;
	}
}
