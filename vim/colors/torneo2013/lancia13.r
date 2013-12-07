/*
 ======  Crobot LANCIANO_13.R  -  1 feb 2013  ======

 ROBOT: LANCIANO_13.R

 Derivato dal mio crobot COPPI_2K.R del 2000

 AUTORE:
 
 Luigi Cimini
 Via Roma, 2
 66030 Frisa (CH)
 ITALY

 Tel. 0872 58186
 Tel. +39 0872 58186

 Email: luigi.cimini@email.it 

 SCHEDA TECNICA: LANCIANO_13.R
 --------------------------
 Derivato dal crobots coppi_2k.r con alcune modifiche nell'attacco finale.
*/

int a,d,danno,n,r,o,oa,t,tt,xx,yy;

main()
{
   finale();
   if (loc_x()<500)
   {
      if (libero(180)) sx(5);
      else if (libero(0)) dx(995);
      else sx(5);
   }
   else
   {
      if (libero(0)) dx(995);
      else if (libero( 180)) sx(5);
      else dx(995);
   }
   
   if (loc_y()>500)
   {
      if (libero( 90)) up(995);
      else if (libero(270)) dn(5);
      else up(995);
   }
   else
   {
      if (libero(270)) dn(5);
      else if (libero( 90)) up(995);
      else dn(5);
   }
   
   tt=150;
   danno=damage()+8;
   while(((--tt)>0) && (damage()<danno))
   {
      t=5; while(((--t)>0) && (damage()<danno)) fuocof();
      finale();
   }
   while(1)
   {
      danno=damage()+15;
      if (loc_x(xx=92)<500); else xx=908;
      if (loc_y(yy=92)<500); else yy=908;
      
      while(damage()<danno)
      {
         t=5;
         while(--t)
         {
            d=180; while(loc_x()>xx) fire();
            d=90;  while(loc_y()<yy) fire();
            d=0;   while(loc_x()<xx) fire();
            d=270; while(loc_y()>yy) fire();
         }
         drive(d,0);
         finale();
      }
      if (loc_y()<500) { if (libero(90)) up(915); else movex(); }
      else { if (libero(270)) dn(85); else movex(); }
   }
}

libero(deg)
{
   return((scan(deg+710,10)+scan(deg+370,10))<167);
}

movex()
{
   if (loc_x()<500) {if (libero(1)) dx(915);} else {if (libero(180)) sx(85);}
}

sx(x) {d=180; while(loc_x()>x) fire(); drive(d,0); }
dx(x) {d=0;   while(loc_x()<x) fire(); drive(d,0); }
dn(y) {d=270; while(loc_y()>y) fire(); drive(d,0); }
up(y) {d=90;  while(loc_y()<y) fire(); drive(d,0); }

finale()
int deg;
{
   n=0; deg=350; while(deg<710) if (scan(deg+=20,10)) ++n;
   if ((n<2) && (damage()<100))
   {
      while(1)
      {
         d=180; while(loc_x()>667) {drive(d, 100); fuoco();} fuoco();
         d=0;   while(loc_x()<667) {drive(d, 100); fuoco();} fuoco();
         d=90;  while(loc_y()<500) {drive(d, 100); fuoco();} fuoco();
         d=270; while(loc_y()>500) {drive(d, 100); fuoco();} fuoco();
      }
   }
}

fire()
{
   drive(d,100);
   if((r=scan(a,10))&&(r<833))
   return(cannon(a+=5+350*(scan(a+355,5)>0),(scan(a,10)<<1)-r));
   else
   {
      if (r=scan(a+=339,10));
      else
      {
         if (r=scan(a+=42, 10));
         else
         {
            if (r=scan(a+=21, 10)); else return(a+=42);
         }
      }
      return(cannon(a,(scan(a,10)<<1)-r));
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
      if (r<200)
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

fuocof()
{
   if((r=scan(a,10))&&(r<833))
   {
      if (scan(a+=355,5)); else a+=10;
      if (r<200)
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
               return(cannon(a+(a-oa)*((1100+r)>>9), r*179/(179+o-r)));
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
