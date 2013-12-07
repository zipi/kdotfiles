/*
 ======  Crobot FRISA_13.R - 1 feb 2013  ======

 ROBOT: FRISA_13.R
 ------

 Derivato dal crobot marine.r del 2000 di mio nipote Andrea Cimini Jasci

 AUTORE:
-
 Luigi Cimini
 Via Roma, 2
 66030 Frisa (CH)
 ITALY

 Tel. 0872 58186
 Tel. +39 0872 58186

 Email: luigi.cimini@email.it 

 SCHEDA TECNICA: MARINE.R
 --------------------------
 Derivato dal crobots marin.r con alcune modifiche nell'attacco finale.

*/

int a,d,nn,oa,r,t,x,o;

main()
{
   finale();
   go(x=816*(loc_x()>400)+92,999*(loc_y()>500));
   while(1)
   {
      oscilla(x,x,15);
      finale();
   }
}

oscilla(x1,x2,t)
{
   while(--t)
   {
      while(loc_x(fire(180))>=x1);
      while(loc_x(fire(0))<=x2);
   }
   if(x1<333) while(loc_x(fire(180))>x1);
   drive(0,0);
}

fire(d)
{
   drive(d, 100);
   if((r=scan(oa=a,10))&&(r<833))
   return(cannon(a+=5+350*(scan(a+355,5)>0)+a-oa,(scan(a,10)<<1)-r));
   else if (scan(a+=339,10));
   else if (scan(a+=42, 10));
   else if (scan(a+=21, 10));
   else return(a+=42);
}

go(xx,yy)
{
   int x,y;
   x=xx;
   d=(360+((x-=loc_x())<0)*180+atan(((yy-loc_y())*100000)/x));
   while((x=xx-loc_x())*x+(y=yy-loc_y())*y>2304) fire(d);
   drive(d,0);
}

finale()
int deg;
{
   nn=0; deg=350; while(deg<710) if (scan(deg+=20,10)) ++nn;
   if ((nn<2) && (damage()<100))
   {
      while(1)
      {
         d=180; while(loc_x()>667) {drive(d,100); fuoco();}; fuoco();
         d=0;   while(loc_x()<667) {drive(d,100); fuoco();}; fuoco();
         d=90;  while(loc_y()<500) {drive(d,100); fuoco();}; fuoco();
         d=270; while(loc_y()>500) {drive(d,100); fuoco();}; fuoco();
      }
   }
}

scan14()
{
   if(scan(a+353,3)) a+=353; if(scan(a+7,3)) a+=7;
   if(scan(a+356,2)) a+=356; if(scan(a+4,2)) a+=4;
   if(scan(a+358,1)) a+=358; if(scan(a+2,1)) a+=2;
}

fuoco()
{
   if((r=scan(a,10))&&(r<833))
   {
      if (scan(a+=355,5)); else a+=10;
      if (r<250)
      {
         return(cannon(a,(scan(a,10)<<1)-r));
      }
      else
      {
	 scan14();
         if (o=scan(oa=a,7))
         {
	    scan14();		 
            if (r=scan(a,10))
            {
               return(cannon(a+(a-oa)*((1100+r)>>9)-(sin(a-d)>>14), r*179/(179+o-r-(cos(a-d)>>12))));
            }
            else
            {
               if (r=scan(a+=339, 10));
               else
               {
                  if (r=scan(a+=42, 10)); else return(a+=42);
               }
               return(cannon(a,(scan(a,10)<<1)-r));
            }
         }
         else
         {
            if (r=scan(a+=339, 10));
            else
            {
               if (r=scan(a+=42, 10)); else return(a+=42);
            }
            return(cannon(a,(scan(a,10)<<1)-r));
         }
      }
   }
   else
   {
      if (r=scan(a+=340,10));
      else
      {
         if (r=scan(a+=40, 10));
         else
         {
            if (r=scan(a+=300,10));
            else
            {
               if (r=scan(a+=80, 10));
               else
               {
                  if (r=scan(a+=260,10));
                  else
                  {
                     if (r=scan(a+=120,10));
                     else
                     {
                        if (r=scan(a+=220,10));
                        else
                        {
                           if (r=scan(a+=160,10)); else return(a+=100);
                        }
                     }
                  }
               }
            }
         }
      }
      return(cannon(a,(scan(a,10)<<1)-r));
   }
}
