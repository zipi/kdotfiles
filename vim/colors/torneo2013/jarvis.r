/**
* J.A.R.V.I.S.
* v.1.1
* Maurizio Camangi 2013
*
* J.A.R.V.I.S. è Rambo3, con delle diverse routine di fuoco. Inviato per fare massa e rompere
* le scatole agli altri robot, compresi i miei.
*/

int range, orange, ang, oang;
int x,y,z;  /* x is loc_x(), y is loc_y(), z is direction */

main()
{

  while(loc_x()<205) 
  {
    fire2(drive(0,100));
  }
  while(loc_x()>795) 
  {
    fire2(drive(180,100));
  }
  while(loc_y()<255) 
  {
    fire2(drive(90,100));
  }
  while(loc_y()>745)  
  {
    fire2(drive(270,100));
  }

  drive((z = 60),100); /*  start moving */

  while(1)  /* Main loop */
  {
    if(200>(x=loc_x()) || x>800)  /* bounce away from EAST/WEST walls */
    {
      drive((z=(540-z)%360),100);
      while(205>(x=loc_x()) || x>795)
      {
        fire(z);
      }
    }
    fire2();

    if(250>(y=loc_y()) || y>750)  /* bounce away from NORTH/SOUTH walls */
    {
      drive(z=(360-z)%360,100);
      while(255>(y=loc_y()) || y>745)
      {
        fire(z);
      }
    }

    if(speed()==0) drive(z,100);  /* robot-robot collision recovery */
    fire2();
  }
}

Search()
{
  	if (range=scan(ang+=350,10)) 	return cannon(ang,range);
  	if (range=scan(ang+=20,10))  	return cannon(ang,range);
  	if (range=scan(ang+=320,10)) 	return cannon(ang,range);
  	if (range=scan(ang+=60,10))  	return cannon(ang,range);
  	if (range=scan(ang+=280,10)) 	return cannon(ang,range);
  	Search(ang-=220);
}

fire(dir)
{
  drive(dir,100);
	if (range=scan(oang=ang,10)) 
	{
		if (scan(ang-8,5))  
		{ 	
			if (scan(ang-=5,2)) ; 
			else ang-=4; 
		}
		else
		{
			if (scan(ang+8,5))  
			{
				if (scan(ang+=5,2)) ; 
				else ang+=4; 
			}
      else
      {
				if (scan(ang,1)) ;
				else if (scan(ang-=3,2)) ; else ang+=6;
			}
		}
		return(cannon(ang+(ang-oang),(scan(ang,10)<<1)-range)); 
	} 
	else 
	{
		if(range=scan(ang+=20,10)) cannon(ang,range);
		else if(range=scan(ang-=40,10)) cannon(ang,range);
		else ang+=80;
	}
}


fire2()
{
int asin, acos;
 if(scan(ang,10) > 100)
 {  
  	asin=(sin(ang-z)/14384);
      acos=(cos(ang-z)/3796)-230;
  	ang-=18*(scan(ang-18,10)>0); 
      ang+=18*(scan(ang+18,10)>0); 
  	if(scan(ang-16,10)) ang-=8;
      else if(scan(ang+16,10)) ang+=8;
  	if(scan(ang-12,10)) ang-=4;
      else if(scan(ang+12,10)) ang+=4;
  	if(scan(ang-11,10)) ang-=2;
      if(scan(ang+11,10)) ang+=2;
  	if(orange=scan(oang=ang,3))
	    {
  	      if(scan(ang-13,10)) ang-=5;
        	else if(scan(ang+13,10)) ang+=5;
            if(scan(ang+12,10)) ang+=4;
  	      else if(scan(ang-12,10)) ang-=4;
        	if(scan(ang-11,10)) ang-=2;
            if(scan(ang+11,10)) ang+=2;
  	      cannon(ang+(ang-oang)*((880+(range=scan(ang,10)))/482)-asin, range*230/(orange-range-acos)); 
	    }
	else 	Search(); 
}
else 	Search();
}
