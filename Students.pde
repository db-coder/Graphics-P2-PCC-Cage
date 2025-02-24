// Place student's code here
// Student's names: Anna Greene & Dibyendu Mondal
// Date last edited:
/* Functionality provided (say what works):
We created a SPCB controlled by 6 control points and used homeomorphism to put a texture over the curve.
Finally, we created an animation by prescribing circular motion to the control points. 
*/
// S->A; L->B; E->C; R->D; A->E; B->F

void b1(pt A, pt C, pt B, pt D, float a, float c){
  beginShape(); 
  stroke(#66A4E2);
  fill(#CCCCCC);
  vec CB = V(C,B);
  vec T = R(U(A,B));
  float radius = (c*c - n2(CB))/(2 * dot(CB,T));
  vec BQ = T; BQ.scaleBy(radius);
  pt Q = P(B,BQ);
  float w = atan(radius/c);
  vec CM = R(U(C,Q),w).scaleBy(c);
  pt M = P(C,CM);
  //drawCircleArcInHat(L,Q,M);
  
  vec AD = V(A,D);
  T = R(U(C,D));
  radius = (a*a - n2(AD))/(2 * dot(AD,T));
  vec DP = T; DP.scaleBy(radius);
  pt P = P(D,DP);
  w = atan(radius/a);
  vec AO = R(U(A,P),w).scaleBy(a);
  pt O = P(A,AO);
  //drawCircleArcInHat(R,P,O);
  
  stroke(#4C67E0);
  float a0 = angle(V(A,O),V(A,B)), da=a0/40;
  if (a0<0) {
    a0 = (TWO_PI)+a0;
    da = a0/60;
  }
  for (float x=0; x<=a0; x+=da) v(P(A,R(AO,x)));
  
  stroke(#23A356);
  drawCircleArcInHat(B,Q,M);
  
  stroke(#DB2967);
  float b = angle(V(C,M),V(C,D)), db=b/40;
  if (b<0) {
    b = (TWO_PI)+b;
    db = b/60;
  }
  for (float x=0; x<=b; x+=db) v(P(C,R(CM,x))); 
  
  stroke(#D8A338);
  drawCircleArcInHat(D,P,O);
  v(O);
  endShape();
}

void b2(pt A, pt C, pt B, pt D, pt E, pt F, float a, float c){
  beginShape();
  stroke(#66A4E2);
  fill(#EEEEEE);
  
  // BLUE ARC
  vec EB = V(E,B);
  vec T = R(U(A,B));
  float radius = (0 - n2(EB))/(2 * dot(EB,T));
  vec BQ = T; BQ.scaleBy(radius);
  pt Q = P(B,BQ);
  
  vec QB = U(V(Q,B));
  vec QE = U(V(Q,E));
  float angle = angle(QB,QE)/2;
  float x = radius*tan(angle);
  pt X = P(B,R(QB).scaleBy(x));
  
  // GREEN ARC
  vec T2 = U(Q,E);
  vec CE = V(C,E);
  radius = (c*c - n2(CE))/(2 * dot(CE,T2));
  vec EQ = T2; EQ.scaleBy(radius);
  pt Q2 = P(E,EQ);
  float omega = atan(radius/c);
  vec CM = R(U(C,Q2),omega).scaleBy(c);
  pt M = P(C,CM);
  
  vec Q2E = U(V(Q2,E));
  vec Q2M = U(V(Q2,M));
  angle = angle(Q2E,Q2M)/2;
  float y = radius*tan(angle);
  pt Y = P(E,R(Q2E).scaleBy(y));
  
  // ORANGE ARC
  vec FD = V(F,D);
  T = R(U(C,D));
  radius = (0 - n2(FD))/(2 * dot(FD,T));
  vec DP = T; DP.scaleBy(radius);
  pt P = P(D,DP);
  
  vec PD = U(V(P,D));
  vec PF = U(V(P,F));
  angle = angle(PD,PF)/2;
  float z = radius*tan(angle);
  pt Z = P(D,R(PD).scaleBy(z));
  float orangeArc = angle(U(V(Z,D)),U(V(Z,F)))*z;
  
  // PURPLE ARC
  T2 = U(P,F);
  vec AF = V(A,F);
  radius = (a*a - n2(AF))/(2 * dot(AF,T2));
  vec FP = T2; FP.scaleBy(radius);
  pt P2 = P(F,FP);
  omega = atan(radius/a);
  vec AN = R(U(A,P2),omega).scaleBy(a);
  pt N = P(A,AN);
  
  vec P2F = U(V(P2,F));
  vec P2N = U(V(P2,N));
  angle = angle(P2F,P2N)/2;
  float w = radius*tan(angle);
  pt W = P(F,R(P2F).scaleBy(w));
  float purpleArc = angle(U(V(W,F)),U(V(W,N)))*w;
  
  stroke(#4C67E0);
  drawCircleArcInHat(B,Q,E);
  
  stroke(#23A356);
  drawCircleArcInHat(E,Q2,M);
  
  // RED ARC
  stroke(#DB2967);
  float b = angle(V(C,M),V(C,D)), db=b/40;
  if (b<0) {
    b = (TWO_PI)+b;
    db = b/60;
  }
  for (float i=0; i<=b; i+=db) v(P(C,R(CM,i))); 
  
  stroke(#D8A338);
  drawCircleArcInHat(D,P,F);
  
  stroke(#DA90F4);
  drawCircleArcInHat(F,P2,N);
  
  // YELLOW ARC
  stroke(#EEF74F);
  float a0 = angle(V(A,N),V(A,B)), da=a0/40;
  if (a0<0) {
    a0 = (TWO_PI)+a0;
    da = a0/60;
  }
  for (float i=0; i<=a0; i+=da) v(P(A,R(AN,i)));
   
  v(B);
  endShape();
  
  //println(x,", ",y,", ",z,", ",w);
  
  // MEDIAL AXIS
  int transversals = 40;
  int vertSections = 20;
  float totalArc = purpleArc + orangeArc;
  float u = totalArc/(transversals);
  int orangeTrans = int(orangeArc/u);
  float theta = u/z;
  pts Arc = new pts();
  Arc.declare();
  pts orangeTraversalPts = new pts();
  orangeTraversalPts.declare();
  pts purpleTraversalPts = new pts();
  purpleTraversalPts.declare();
  pts cTraversalPts = new pts();
  cTraversalPts.declare();
  pts aTraversalPts = new pts();
  aTraversalPts.declare();
  beginShape();
  stroke(black);
  noFill();
  float DCM =angle(V(C,M),V(C,D));
  if (DCM<0) DCM+=TWO_PI;
  pt Ci=P(C,R(V(C,D),-1*(DCM)/2));
  v(Ci);
  v(C);
  pt C1=P(0,0);
  for (int i=1; i<=orangeTrans; i++) { //arcs starting from orange arc
    vec ZU = R(V(Z,D),(theta*i));
    pt U = P(Z,ZU);
    
    vec YU = V(Y,U);
    T = U(V(Z,U));
    if (z<0) T=M(T);
    float d = (y*y - n2(YU))/(2*(dot(YU,T) - y));
    pt Ma = P(U,T.scaleBy(d));
    
    vec YV = U(V(Y,Ma));
    if (y<0) YV=M(YV);
    YV.scaleBy(y);
    pt V = P(Y,YV);
    
    float det = det(V(U,V),V(V,E))*det(V(U,V),V(V,M));
    
    if (det<0){ //green arc
      v(Ma);
    }
    else if (det>0){ // blue arc
      vec XU = V(X,U);
      T = U(V(Z,U));
      if (z<0) T=M(T);
      d = (x*x - n2(XU))/(2*(dot(XU,T) - x));
      Ma = P(U,T.scaleBy(d));
      
      vec XV = U(V(X,Ma));
      if (x<0) XV=M(XV);
      XV.scaleBy(x);
      V = P(X,XV);
      v(Ma);
    }
    Arc.addPt(V);
    Arc.addPt(Ma);
    Arc.addPt(U);
    
    float UVang=angle(V(Ma,U),V(Ma,V))/2;
    float R2 = d(Ma,V)*tan(UVang);
    C1 = P(V,R(U(V(V,Ma))).scaleBy(R2));
    float VCUang = angle(V(C1,U),V(C1,V))/vertSections;
    orangeTraversalPts.addPt(V);
    for (int j=1;j<vertSections;j++){
      pt Vi = P(C1,R(V(C1,V),-1*VCUang*j));
      Vi.show();
      orangeTraversalPts.addPt(Vi);
    }
    orangeTraversalPts.addPt(U);
  }
  
  // calculate medial axis from points on the purple arc
  int purpleTrans = transversals - orangeTrans - 1; 
  theta = u/w;
  for (int i=purpleTrans; i>=1; i--) { //arcs starting from purple arc
    vec WU = R(V(W,N),(theta*i*-1));
    pt U = P(W,WU);
    
    vec XU = V(X,U);
    T = U(V(W,U));
    if (w<0) T=M(T);
    float d = (x*x - n2(XU))/(2*(dot(XU,T) - x));
    pt Ma = P(U,T.scaleBy(d));
    
    vec XV = U(V(X,Ma));
    if (x<0) XV=M(XV);
    XV.scaleBy(x);
    pt V = P(X,XV);
    
    float det = det(V(U,V),V(V,B))*det(V(U,V),V(V,E));
    
    if (det<0){ //blue arc
      v(Ma);
    }
    else if (det>0){ // green arc
      vec YU = V(Y,U);
      T = U(V(W,U));
      if (w<0) T=M(T);
      d = (y*y - n2(YU))/(2*(dot(YU,T) - y));
      Ma = P(U,T.scaleBy(d));
      
      vec YV = U(V(Y,Ma));
      if (y<0) YV=M(YV);
      YV.scaleBy(y);
      V = P(Y,YV);
      v(Ma);
    }
    Arc.addPt(V);
    Arc.addPt(Ma);
    Arc.addPt(U);
    
    float UVang=angle(V(Ma,U),V(Ma,V))/2;
    float R2 = d(Ma,V)*tan(UVang);
    C1 = P(V,R(U(V(V,Ma))).scaleBy(R2));
    float VCUang = angle(V(C1,U),V(C1,V))/vertSections;
    purpleTraversalPts.addPt(V);
    for (int j=1;j<vertSections;j++){
      pt Vi = P(C1,R(V(C1,V),-1*VCUang*j));
      Vi.show();
      purpleTraversalPts.addPt(Vi);
    }
    purpleTraversalPts.addPt(U);
  }  
  v(A);
  float BAN =angle(V(A,N),V(A,B));
  if (BAN<0) BAN+=TWO_PI;
  pt Ai=P(A,R(V(A,B),-1*(BAN)/2));
  v(Ai);
  endShape();
  
  // drawing the transversals
  for(int i=0; i<3*orangeTrans+3*purpleTrans;i=i+3)
  {
    beginShape();
    drawCircleArcInHat(Arc.G[i],Arc.G[i+1],Arc.G[i+2]);
    endShape();
  }
  
  //extending the transversals
  stroke(#A9A9A9);
  //circle A
  if (u<0) u*=-1;
  if (a<0) a*=-1;
  theta = u/a;
  BAN =angle(V(A,N),V(A,B));
  if (BAN<0) BAN+=TWO_PI;
  int j=0;
  while (theta*j*2<=BAN)
  {
    pt Bi=P(A,R(V(A,B),-1*theta*j));
    pt Ni=P(A,R(V(A,N),theta*j));
    beginShape();
    drawCircleArcInHat(Bi,A,Ni);
    endShape();
    
    float BNang=angle(V(A,Ni),V(A,Bi))/2;
    float R2 = d(A,Bi)*tan(BNang);
    C1 = P(Bi,R(U(V(Bi,A))).scaleBy(R2));
    float BCNang = angle(V(C1,Ni),V(C1,Bi))/vertSections;
    aTraversalPts.addPt(Bi);
    for (int k=1;k<vertSections;k++)
    {
      pt Vi = P(C1,R(V(C1,Bi),-1*BCNang*k));
      Vi.show();
      aTraversalPts.addPt(Vi);
    }
    aTraversalPts.addPt(Ni);
    j++;
  }
  aTraversalPts.addPt(Ai);
  
  //circle C
  if (c<0) c*=-1;
  theta = u/c;
  DCM =angle(V(C,M),V(C,D));
  if (DCM<0) DCM+=TWO_PI;
  j=0;
  while (theta*j*2<=DCM)
  {
    pt Di=P(C,R(V(C,D),-1*theta*j));
    pt Mi=P(C,R(V(C,M),theta*j));
    beginShape();
    drawCircleArcInHat(Di,C,Mi);
    endShape();
    
    float DMang=angle(V(C,Mi),V(C,Di))/2;
    float R2 = d(C,Di)*tan(DMang);
    C1 = P(Di,R(U(V(Di,C))).scaleBy(R2));
    float DCMang = angle(V(C1,Mi),V(C1,Di))/vertSections;
    cTraversalPts.addPt(Di);
    for (int k=1;k<vertSections;k++)
    {
      pt Vi = P(C1,R(V(C1,Di),-1*DCMang*k));
      Vi.show();
      cTraversalPts.addPt(Vi);
    }
    cTraversalPts.addPt(Mi);
    j++;
  }
  cTraversalPts.addPt(Ci);
  
  nR = vertSections + 1;
  nC = (orangeTraversalPts.nv +purpleTraversalPts.nv)/(nR) + (aTraversalPts.nv + cTraversalPts.nv - 2)/nR; 
  
  // creating grid for cat
  for(int i = 0;i < nC;i++)
  {
    for(j = 0;j < nR;j++)
    {
      G0.G[j*nC+i] = P((nC-i-1)*256/(nC-1),(nR-j-1)*256/(nR-1));
    }
  }
  
  // creating grid for blob
  
  // from circle A
  int Col = (aTraversalPts.nv - 1)/nR; 
  int k = 0;
  for(int i = 0;i < Col;i++)
  {
    for(j = 0;j < nR;j++)
    {
      if(i == 0)
      {
        G1.G[j*nC] = aTraversalPts.G[aTraversalPts.nv-1];
        continue;
      }
      else
      {
        G1.G[j*nC+i] = aTraversalPts.G[aTraversalPts.nv-2-k];
        k++;
      }
    }
  }
  
  // from purple traversal
  int Col_old = Col;
  Col = purpleTraversalPts.nv/nR; 
  k = 0;
  for(int i = 0;i < Col;i++)
  {
    for(j = 0;j < nR;j++)
    {
      G1.G[j*nC+i+Col_old] = purpleTraversalPts.G[purpleTraversalPts.nv-1-k];
      k++;
    }
  }
  
  // from orange traversal
  Col_old += Col;
  Col = orangeTraversalPts.nv/nR; 
  k = 0;
  for(int i = 0;i < Col;i++)
  {
    for(j = 0;j < nR;j++)
    {
      G1.G[j*nC+i+Col_old] = orangeTraversalPts.G[orangeTraversalPts.nv-1-k];
      k++;
    }
  }
  
  // from circle C
  Col_old += Col;
  Col = (cTraversalPts.nv - 1)/nR; 
  k = 0;
  for(int i = 0;i < Col;i++)
  {
    for(j = 0;j < nR;j++)
    {
      if(i == Col-1)
      {
        G1.G[j*nC+Col_old+i] = cTraversalPts.G[cTraversalPts.nv-1];
        continue;
      }
      G1.G[j*nC+i+Col_old] = cTraversalPts.G[k];
      k++;
    }
  }
  
  pts P1 = new pts();
  P1.declare();
  //P1.addPt(Q); P1.addPt(Q2); P1.addPt(P); P1.addPt(P2);
  //P1.addPt(M); P1.addPt(N);
  //P1.addPt(Z); P1.addPt(X); P1.addPt(Y); P1.addPt(W);
  //P1.addPt(C1);
  strokeWeight(1);
  noFill(); stroke(black); P1.draw(white); // paint empty disks around each control point
  fill(black); 
  //label(Q,V(-1,-2),"Q"); label(Q2,V(-1,-2),"Q2"); label(P,V(-1,-2),"P"); label(P2,V(-1,-2),"P2"); 
  //label(M,V(-1,-2),"M"); label(N,V(-1,-2),"N"); 
  //label(Z,V(-1,-2),"Z"); label(X,V(-1,-2),"X"); label(Y,V(-1,-2),"Y"); label(W,V(-1,-2),"W");
  //label(C1,V(-1,-2),"C1");
  noFill(); // fill them with labels
}