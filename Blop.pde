class Blop{
  double mass;
  PVector pos;
  float velocity = random(0, 10);
  float direction = random(0, 2*PI);
  PVector speed;
  PVector colour = new PVector(random(0,255), random(0,255), random(0,255));
  //PVector acceleration = new PVector(random(-0.1, 0.1), random(-0.1, 0.1));
  //PVector force = new PVector(acceleration.x * mass, acceleration.y * mass);

  double friction = mass * 0.01;
  
  public Blop(PVector pos, double size) {
    this.speed = new PVector(velocity * cos(direction), velocity * sin(direction)) ;
    this.pos = pos;  
    this.mass = (size/2)*(size/2)*PI;
  }
  
  public double getSize(){
    return 2*Math.sqrt(mass/PI);
  }
  
  public double getMass() {
    return this.mass;
  }
  
  public PVector getPos() {
    return pos;
  }
  
  public void setPos(PVector newPos) {
   this.pos = newPos; 
  }
  
  public void move(){
    this.pos.add(this.speed);
    this.mass -= this.speed.x*this.speed.x + this.speed.y*this.speed.y;
    /**PVector totalForce = force.copy();
    totalForce.setMag(force.mag()-friction);
    if(this.speed.mag() < totalForce.mag()) {
      this.speed.set(0,0);
    } else {
      this.speed.add(totalForce);
    }
    this.force.add(this.acceleration);
    this.acceleration.set(random(-0.1, 0.1), random(-0.1, 0.1)); **/
  }
  
  public PVector getSpeed() {
    return speed;
  }
  
  public void setSpeed(PVector speed) {
    this.speed = speed;
  }
  
  public void eat(double food) {
    this.mass += food;
  }
  
  public void draw(float x, float y) {
    fill(colour.x,colour.y, colour.z);
    ellipse(x, y, (float) getSize(), (float) getSize());
  }
  
  public void draw() {
    fill(colour.x,colour.y, colour.z);
    ellipse(pos.x, pos.y, (float) getSize(), (float) getSize());
    stroke(0, 0, 0);
    line(pos.x, pos.y, pos.x + (float) getSize() * cos(direction), pos.y + (float) getSize() * sin(direction));
  }
}