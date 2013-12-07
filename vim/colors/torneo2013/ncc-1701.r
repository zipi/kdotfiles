/*
Crobot    : NCC-1701
Type      : Midi
Version   : 1.0
Author    : Olga Strelnikova
Begin     : 27-12-2012
Revision  : 21-01-2013

L'Enterprise NCC-1701 è frutto dell'unione dei due robot Flash8 dello scorso anno.
Long live and prosper!
*/
int a,b,c,x,y,z,t;
int dir,range,orange,ang,oang,asin,acos;

fire(d,v)
{
	drive(d,v);
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
		}
		return(cannon((ang<<1)-oang,(scan(ang,10)<<1)-range)); 
	} 
	else 
	{
		if(range=scan(ang+=20,10)) cannon(ang,range);
		else if(range=scan(ang-=40,10)) cannon(ang,range);
		else ang+=80;
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

main()
{
   dir=90*(a=((y=loc_y(t=2)<500)<<1)|((x=loc_x()<500)^y));
   while(1)
   {
     if (a&1) b=loc_y(); else b=loc_x();
     if (a&2) c=b>180;   else c=b<820;
     
     if (c)
     {
         if(speed()<100) drive(dir,100); 
         if(scan(ang,10) > 100)
      	 {  
          	asin=(sin(ang-dir)/14384);
    	      acos=(cos(ang-dir)/3796)-230;
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
     else
     {
       drive(dir+=90,0);
       if (++t==4)
       {
         t=0;
         if (
            ((scan(dir,    10)!=0)
            +(scan(dir+19, 10)!=0)
            +(scan(dir+38, 10)!=0)
            +(scan(dir+57, 10)!=0)
            +(scan(dir+76, 10)!=0)
            +(scan(dir+95, 10)!=0)
            )<2)
         {
         	while(1) 
        	{
        		if ((x=loc_x())>880) dir=180;
            else if (x<120 ) dir=0;
            else if ((y=loc_y())>880) dir=270;
            else if (y<120) dir=90;
        		else if (range>600) dir=ang+20;
        		else if (range<150) dir=ang+200;
        		else dir=ang+180*(z^=1);
        		fire(dir,100);
        		fire(dir,100);
        		fire(dir,100);
        	}
         }
       }
       if (scan(dir,10)) ang=dir; ++a;
     }
   }
}
