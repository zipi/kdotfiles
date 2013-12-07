/*
 Pippo13b.r
 Torneo: Micro

 Tattica: passa da un lato all'altro, si usa un parametro fisso ed uno
 casuale in modo da girare tutti e 4 i lati ma in punti sempre differenti.

 
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
 vai(100,100+rand(800));
 vai(100+rand(800),100);
 vai(900,100+rand(800));
 vai(100+rand(800),900);
}

dist(x,y){  return (((x-=loc_x())*x+(y-=loc_y())*y));}

vai(xx,yy)
{
 if (loc_y()==yy) ++yy;
 drive(dir=180+180*(xx>loc_x())+atan(100000*(loc_y()-yy)/(loc_x()-xx)),100);
 while(dist(xx,yy)>10000) fuoco() ;
 while(speed(drive(dir,0))>50);
}

fuoco()
{
  int asin,acos;
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
