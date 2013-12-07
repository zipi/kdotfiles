/*
 ======  Crobot ORTONA_13.R  -  1 feb 2013  ======

 ROBOT: ORTONA_13.R

 Derivato dal mio crobot BACH_2K.R del 2000

 AUTORE:
 
 Luigi Cimini
 Via Roma, 2
 66030 Frisa (CH)
 ITALY

 Tel. 0872 58186
 Tel. +39 0872 58186

 Email: luigi.cimini@email.it 

 SCHEDA TECNICA: ORTONA_13.R
 --------------------------
 Derivato dal crobots bach_2k.r con alcune modifiche nell'attacco finale.
*/

int a,d,danno,n,r,o,oa,t,deg;

scan14()
{
   if(scan(a+353,3)) a+=353; if(scan(a+7,3)) a+=7;
   if(scan(a+356,2)) a+=356; if(scan(a+4,2)) a+=4;
   if(scan(a+358,1)) a+=358; if(scan(a+2,1)) a+=2;
}

fuoco()
{
   drive(d, 100);
   if (r=scan(a,10))
   {
      if (scan(a+=355,5)); else a+=10;
      if (r<200)
      {
         if (scan(a+=357,3)); else a+=6;
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
         }
         else return(fire());
      }
   }
   else
   {
      if (scan(a+=340,10)) return;
      else
      {
         if (scan(a+=40, 10)) return;
         else
         {
            if (scan(a+=300,10)) return;
            else
            {
               if (scan(a+=80, 10)) return;
               else
               {
                  if (scan(a+=260,10)) return;
                  else
                  {
                     if (scan(a+=120,10)) return;
                     else
                     {
                        if (scan(a+=220,10)) return;
                        else
                        {
                           if (scan(a+=160,10)) return; else return(a+=100);
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

finale()
int deg;
{
   n=0; deg=350; while(deg<710) if (scan(deg+=20,10)) ++n;
   if ((n<2) && (damage()<100))
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

fire()
{
   if ((r=scan(a,10)) && (r<833))
   {
      if (scan(a+=355,5)); else a+=10;
      if (scan(a+=357,3)); else a+=6;
      return(cannon(a,(scan(a,10)<<1)-r));
   }
   else
   {
      if (scan(a+=339,10)) return;
      if (scan(a+=42, 10)) return; else return(a+=42);
   }
}

sx(x) {d=180; while(loc_x()>x) {drive(d,100); fire();} drive(d,0); }
dx(x) {d=0;   while(loc_x()<x) {drive(d,100); fire();} drive(d,0); }
dn(y) {d=270; while(loc_y()>y) {drive(d,100); fire();} drive(d,0); }
up(y) {d=90;  while(loc_y()<y) {drive(d,100); fire();} drive(d,0); }

sito()   /* 0=SO 1=SE 2=NE 3=NO */
{
   if (loc_x()<500) {if (loc_y()<500) return(0); else return(3);}
   else             {if (loc_y()<500) return(1); else return(2);}
}

libero(deg)
{
   return((scan(deg+710,10)+scan(deg+370,10))<100);
}

movex()
{
   if (loc_x()<500) {if (libero(1)) dx(915);} else {if (libero(180)) sx(85);}
}

main()
{
   finale();
   if (loc_x()<450) sx(85); else dx(915);
   if (loc_y()<500) dn(85); else up(915);
   while(1)
   {
      d=(a=sito()*90)+45;
      danno=damage()+20;
      while(damage()<danno)
      {
         t=5;
         if (loc_y()<500)
         {
            while(--t)
            {
               while(loc_y() < 85) {drive(d,100); fire();} d+=180;
               while(loc_y() > 85) {drive(d,100); fire();} drive(d,0); d+=180;
            }
         }
         else
         {
            while(--t)
            {
               while(loc_y() >915) {drive(d,100); fire();} d+=180;
               while(loc_y() <915) {drive(d,100); fire();} drive(d,0); d+=180;
            }
         }
         finale();
      }
      if (loc_y()<500) { if (libero(90)) up(915); else movex(); }
      else { if (libero(270)) dn(85); else movex(); }
   }
}
