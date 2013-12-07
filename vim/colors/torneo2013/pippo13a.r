/*
 Pippo13a.r
 Torneo: Micro

 Strategia:
 Si posiziona nell'angolo in basso a sinistra e da li oscilla in alto
 e basso con un angolo leggermente spostato diverso dalla verticale.

 Routine di fuoco, Š la stessa di quella dell'anno scorso con un
 alleggerimento di codice.
  
 ciao

 Andrea Creola
 a.creola@libero.it
 www.baragin.it
*/
int rng,
    deg,  
    orng,
    odeg, 
    dir,
    un1,
    ody,
    od,
    tt;
    
main()
{
 while(loc_x()>200) fuoco(180);
 stop();

 while(loc_y()>200) fuoco(270);
 stop();

 while(1)
  {
   while(loc_y()<800) fuoco(67);
   stop();
   while(loc_y()>200) fuoco(292);
   stop();
   while(loc_y()<800) fuoco(112);
   stop();
   while(loc_y()>200) fuoco(248);
   stop();

  }
}

fuoco(dd)
{
  int asin,acos;
  drive(dir=dd,100);
  if (speed()>90)
   {
    if (scan(dir,10)) deg=dir;
    if (rng>850) { deg+=120; }
   }

  if (scan(deg,10))
  {
    asin=(sin(deg-dir)/14384);
    acos=(cos(deg-dir)/3796)-230;
    Find();
    if (orng=scan(odeg=deg,3))
    {
      Find();
      cannon(deg+(deg-odeg)*((880+(rng=scan(deg,10)))/482)-asin,
             rng*230/(orng-rng-acos));
      return;
    }
    
  }
  if (rng=scan(deg+=350,10));
  else if (rng=scan(deg+=20,10));
  else if (rng=scan(deg+=320,10));
  else if (rng=scan(deg+=60,10));
  else if (rng=scan(deg+=280,10));
  else if (scan(dir,10)) return(deg=dir);
  else
   {
    while (!scan(deg,10)) drive(dir,100+(deg+=21));
    return;
   }
 cannon(deg,rng);


}

Find()
{
  if(scan(deg-13,10)) deg-=5;
  else if(scan(deg+13,10)) deg+=5;
  if(scan(deg+12,10)) deg+=4;
  else if(scan(deg-12,10)) deg-=4;
  if(scan(deg-11,10)) deg-=2;
  if(scan(deg+11,10)) deg+=2;
}

stop() {  while(speed(drive(dir,0))>50);/* Fire(0);*/ }
