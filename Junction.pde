class Junction {
  private ArrayList<Segment> enders;
  private ArrayList<Segment> starters;
  PVector pos;
  float radius;
  boolean seen;   // temp flag to avoid infinite loops while walking the graph

  Junction(PVector p, float r) {
    pos = p.copy(); 
    radius = r;
    enders = new ArrayList<Segment>();
    starters = new ArrayList<Segment>();
  }

  Junction(PVector p) {
    this(p, 30);
  }
  
  Segment addStarter(Segment s) {
    s.startjun = this;
    starters.add(s);
    return s;
  }

  Segment addEnder(Segment s) {
    s.endjun = this;
    enders.add(s);
    return s;
  }

  void draw(boolean editmode) {
    if (editmode) {
      stroke(70);
      noFill();
      // fill(#3DA329);  // light green
      ellipseMode(RADIUS);
      ellipse(pos.x, pos.y, radius, radius);
      strokeWeight(.5);
      for (Segment s : enders) {
        line(s.end.x, s.end.y, pos.x, pos.y);
        drawChevron(s.end, pos, 3);
      }
      stroke(0);
      for (Segment s : starters) {
        line(s.start.x, s.start.y, pos.x, pos.y);
        drawChevron(pos, s.start, 3);
      }
    } else {           // NON EDIT MODE
      fill(90);
      noStroke();
      ellipseMode(RADIUS);
      float r = 1.3 * radius;
      ellipse(pos.x, pos.y, r, r);
      fill(100);
      ellipse(pos.x, pos.y, radius, radius);
    }
  }


  ArrayList<Segment> openStarters(Segment ender, float dist) {
    ArrayList<Segment> temp = new ArrayList<Segment>();
    for (Segment s: starters) {
      if (s.isClear(dist)) temp.add(s);
    }
    return temp;
  }
  
  ArrayList<Junction> neighbors() {
    ArrayList<Junction> temp = new ArrayList<Junction>();
    for (Segment s: starters) 
      if (!temp.contains(s.endjun)) temp.add(s.endjun);
    for (Segment e: enders) 
      if (!temp.contains(e.startjun)) temp.add(e.startjun);
    return temp;
  }
  
  
}