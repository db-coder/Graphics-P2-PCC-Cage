// LecturesInGraphics: vector interpolation
// Template for sketches
// Author: Jarek ROSSIGNAC
PImage DBPix; // picture of author's face, should be: data/pic.jpg in sketch folder
PImage AnnaPix; // picture of author's face, should be: data/pic.jpg in sketch folder
// S->A; L->B; E->C; R->D; A->E; B->F

//**************************** global variables ****************************
pts P = new pts();
float t=0.5, f=0;
Boolean animate=false, linear=true, circular=true, beautiful=true;
boolean b1=false, b2=true, b3=true, b4=true;
float len=200; // length of arrows
PImage Cat;
pts G0 = new pts();
pts G1 = new pts();
int nC, nR;
float r1 = 12.5, r2 = 15.0, r3 = 17.5, r4 = 20.0, r5 = 22.5, r6 = 40.0, w1 = 157, w2 = -203, w3 = 261, w4 = -152, w5 = 209, w6 = -240;
pt old_A, old_B, old_C, old_D, old_E, old_F;
vec Up = U(V(0,-1));

//**************************** initialization ****************************
void setup() {               // executed once at the begining 
  size(800, 800, P2D);            // window size
  frameRate(30);             // render 30 frames per second
  smooth();                  // turn on antialiasing
  DBPix = loadImage("data/Dibyendu.jpg");  // load image from file pic.jpg in folder data *** replace that file with your pic of your own face
  AnnaPix = loadImage("data/Anna.jpg");  // load image from file pic.jpg in folder data *** replace that file with your pic of your own face
  P.declare().resetOnCircle(4);
  P.loadPts("data/pts");
  Cat = loadImage("data/HappyCat.png");
  image(Cat,0,0);
  old_A = P.G[0];
  old_B = P.G[1];
  old_C = P.G[2];
  old_D = P.G[3];
  old_E = P.G[4];
  old_F = P.G[5];
  }

//**************************** display current frame ****************************
void draw() {      // executed at each frame
  background(white); // clear screen and paints white background
  if(snapPic) beginRecord(PDF,PicturesOutputPath+"/P"+nf(pictureCounter++,3)+".pdf"); // start recording for PDF image capture

  
  if(animating) {t+=0.01; if(t>=1) {t=1; animating=false;}} 

  strokeWeight(2);
  pt A=P(old_A,U(R(Up,w1*t)).scaleBy(r1)),
  C=P(old_B,U(R(Up,w2*t)).scaleBy(r2)), B=P(old_C,U(R(Up,w3*t)).scaleBy(r3)), D=P(old_D,U(R(Up,w4*t)).scaleBy(r4)), E=P(old_E,U(R(Up,w5*t)).scaleBy(r5)), F=P(old_F,U(R(Up,w6*t)).scaleBy(r6));
  stroke(black); edge(A,B); edge(C,D);

  float a=d(A,B), c=d(C,D); // radii of control circles computed from distances
  //CIRCLE Cs = C(S,s), Ce = C(E,e); // declares circles
  //stroke(dgreen); Cs.drawCirc(); stroke(red); Ce.drawCirc(); // draws both circles in green and red
 

  strokeWeight(5);
  if(b1)
    {
      b1(A,C,B,D,a,c);
    }
//    
  if(b2)
    {
      b2(A,C,B,D,E,F,a,c);
    }

   // texture code
   G1.paintImage(nC,nR,G0);
  
   stroke(black);   strokeWeight(1);

   if(b3)
     {
     fill(black); scribeHeader("t="+nf(t,1,2),2); noFill();
     // your code for part 4
      strokeWeight(3); stroke(blue); 
     //    drawCircleInHat(Mr,M,Ml);  
     }
   strokeWeight(1);
  if(!animating)
  {
    noFill(); stroke(black); P.draw(white); // paint empty disks around each control point
    fill(black); label(A,V(-1,-2),"A"); label(C,V(-1,-2),"C"); label(B,V(-1,-2),"B"); label(D,V(-1,-2),"D"); label(E,V(-1,-2),"E"); label(F,V(-1,-2),"F"); noFill(); // fill them with labels
  }
  if(snapPic) {endRecord(); snapPic=false;} // end saving a .pdf of the screen

  fill(black); displayHeader();
  if(scribeText && !filming) displayFooter(); // shows title, menu, and my face & name 
  if(filming && (animating || change)) saveFrame("FRAMES/F"+nf(frameCounter++,4)+".jpg"); // saves a movie frame 
  change=false; // to avoid capturing movie frames when nothing happens
  if(animating)
  {
    old_A = A;
    old_B = C;
    old_C = B;
    old_D = D;
    old_E = E;
    old_F = F;
  }
  }  // end of draw()

  
//**************************** user actions ****************************
void keyPressed() { // executed each time a key is pressed: sets the "keyPressed" and "key" state variables, 
                    // till it is released or another key is pressed or released
  if(key=='?') scribeText=!scribeText; // toggle display of help text and authors picture
  if(key=='!') snapPicture(); // make a picture of the canvas and saves as .jpg image
  if(key=='`') snapPic=true; // to snap an image of the canvas and save as zoomable a PDF
  if(key=='~') {filming=!filming; } // filming on/off capture frames into folder FRAMES 
  if(key=='a') {animating=true; f=0; t=0;}  
  if(key=='s') P.savePts("data/pts");   
  if(key=='l') P.loadPts("data/pts"); 
  //if(key=='1') b1=!b1;
  //if(key=='2') b2=!b2;
  //if(key=='3') b3=!b3;
  //if(key=='4') b4=!b4;
  if(key=='Q') exit();  // quit application
  change=true; // to make sure that we save a movie frame each time something changes
  }

void mousePressed() {  // executed when the mouse is pressed
  P.pickClosest(Mouse()); // used to pick the closest vertex of C to the mouse
  change=true;
  }

void mouseDragged() {
  if (!keyPressed || (key=='a')) P.dragPicked();   // drag selected point with mouse
  if (keyPressed) {
      if (key=='.') t+=2.*float(mouseX-pmouseX)/width;  // adjust current frame   
      if (key=='t') P.dragAll(); // move all vertices
      if (key=='r') P.rotateAllAroundCentroid(Mouse(),Pmouse()); // turn all vertices around their center of mass
      if (key=='z') P.scaleAllAroundCentroid(Mouse(),Pmouse()); // scale all vertices with respect to their center of mass
      }
  change=true;
  }  

//**************************** text for name, title and help  ****************************
String title ="6491 2017 P2: PCC Cage", 
       name ="Student: Anna Greene; Dibyendu Mondal",
       menu="?:(show/hide) help, s/l:save/load control points, a: animate, `:snap picture, ~:(start/stop) recording movie frames, Q:quit",
       guide="click and drag to edit, press '1' or '2' to toggle LINEAR/CIRCULAR,"; // help info


  
float timeWarp(float f) {return sq(sin(f*PI/2));}