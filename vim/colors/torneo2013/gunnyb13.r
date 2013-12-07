/* ************************************************************************************************************************************************************** */
/* == GUNNYBOY 2013 ==  By Paolo Di Benedetto == pl.dibenedetto@gmail.com											  */
/* Serie GUNNYBOY. Oscilla negli angoli, se non trova nessuno cambia angolo											  */
/* passando per il centro dell'arena cosi mi porto a meno di 700 anche se ci si nasconde negli angoli opposti			  				  */
/* La routine di fuoco e puntamento come ormai tradizione ricca di parametri custom. 									          */
/* Mancano routine f2f o conta degli avversari, tutto quello che ho provato peggiorava le cose...... sarà per l'anno prossimo 				          */
/* ************************************************************************************************************************************************************** */

/* dichiarazioni variabili globali */

int xpos,ypos, upper, lower, bordo, shift; /* memorizzano la posizione */
int dir, diago, amplitude, velocita; /* per muoversi */
int fuoco,ang,a1,a2,a3,a4,a5,a6,a7,a8,a9,ab; /*parametri vari*/
int safety, basta;

main()
{
/* inizializzazione variabili */
	ypos=loc_y();
	xpos=loc_x();
	a1= 1046; /* 1093 */
	a2= 479; /* 501 */
	a3= 38081; /* 26629 */
	a4= 142; /* 148 */
	a5= 9656; /* 11136 */
	a6= 234; /* 26 */
	a7= 60; /* 51 */
	a8= 16; /* safety=40 */
	a9= 175; /*shift=100 */
        ab= 2; /* fuoco=10 */

	safety = a8; /* aggiunge margine di sicurezza per evitare che il robot sbatta sui bordi */
	shift = a9; /* indica di quanto ci spostiamo in orizzontale dall'angolo prima di tornare indietro */
	fuoco = ab; /* da sottrarre all'angolo dopo aver sparato */
	
	/* Routine che guida il robot nello angolo piu vicino	*/	
	bordo = 1000*(ypos>500);
	ang = 180*(ypos>500);
	dir = plot(0, 1000*(ypos>500));
	amplitude = 8;
	upper = 100+(800-amplitude)*(ypos>500)+amplitude*(ypos<500);
	lower = upper-amplitude;
	velocita = 50;
	basta = 0;
	while (((xpos*xpos)+(ypos-bordo)*(ypos-bordo))>=20000)
	{
		spara();
		drive(dir,100);
		ypos=loc_y();
		xpos=loc_x();
	}
	drive(0,0);
	while (speed()>a7) spara();
 	diago=315;
	while(1) 
	{
		/* Routine principale di oscillazione nello angolo */
		xpos=loc_x();
		if (xpos>shift) {diago=225;} /*torno indietro */
		else
		{
			if (xpos<(shift-safety)) {diago=315;} /*torno indietro */
		}

		ypos=loc_y();
		if (ypos<lower) {dir=90;}
		if (ypos>upper) {dir=diago;}
		drive(dir,velocita);
		spara();
		if (basta > a6) {driveby();}/*mondo pieno di codardi, BASTA vado a cercarli io*/
	}
}

driveby()
{
	/* passo per il centro e mi rimetto al sicuro nello angolo */
	int upordown;
	upordown = (ypos<500);
	dir = 90*upordown-45; /* prima diagonale veloce a 45 poi correggo con plot la seconda per un atterraggio preciso */
	while (((xpos-500)*(xpos-500)+(ypos-500)*(ypos-500))>=50000)
	{
		spara();
		drive(dir,100);
		ypos=loc_y();
		xpos=loc_x();
	}
	drive(0,0);
	while (speed()>a7) spara();
	dir = plot(0,1000*upordown);
	while (((xpos)*(xpos)+(ypos-1000*upordown)*(ypos-1000*upordown))>=50000)
	{
		spara();
		drive(dir,100);
		ypos=loc_y();
		xpos=loc_x();
	}
	drive(0,0);
	while (speed()>a7) spara();
	basta = 0;
	upper = 100+800*(ypos>500)+amplitude*(ypos<500);
	lower = upper-amplitude;
	diago=315;
}

spara()
{
int oang;
int range;
int orange;
	while (!(orange=scan(ang,10))) ang += 20;
		/*prima scansione*/
		if(scan(ang+8,8)) ang+=4;
		else ang-=4;

		if(scan(ang+8,8)) ang+=2;
		else ang-=2;
		
		if(scan(ang+8,8)) {ang+=1; orange=scan(oang=ang,10);}
		else {ang-=1; orange=scan(oang=ang,10);}

		/*seconda scansione*/
		if(scan(ang+8,8)) ang+=4;
		else ang-=4;

		if(scan(ang+8,8)) ang+=2;
		else ang-=2;

		if(scan(ang+8,8)) ang+=1; 
		else ang-=1; 

		ang = ang+(ang-oang)*((a1+(range=scan(ang,10)))/a2)-(sin(ang-dir)/a3);
		range = range*a4/(a4+orange-range-(cos(ang-dir)/a5))+100*(range<60);
		cannon(ang,range);
		basta = (basta*(range>300)+1); /* se il nemico si ostina a stare lontano aspetto ma poi vado a prenderlo */
		ang-=fuoco;
}

plot (x,y)     /* solita funzione arcinota data una coordinata cartesiana ritorna la direzione per */
int x, y, r;      /* raggingerla dalla posizione attuale */
{
	int locx, locy, r;
	locx = loc_x();
	locy = loc_y();
	if (locx==x)
	 {
		if (y>locy) return 90;
		else return 270;
	 } 
	else
	 {
		 r=atan(100000*(locy-y)/(locx-x));
		 if( y < locy)
		 {
		 	if (x > locx) return 360 + r;
			else return 180 + r;
		  }
		  else if (x > locx) return r;
				else return (180+r);
	 }
}
