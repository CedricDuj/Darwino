import java.util.Iterator;

class Board{
  int width;
  int height;
  int minPopulation;
  ArrayList<Blop> population = new ArrayList();
  
  public Board(int width, int height, int minPopulation) {
    this.height = height;
    this.width = width;
    this. minPopulation = minPopulation;
    seed(minPopulation);
  }
  
  public void startLife() {
      for(Blop blop : population) {
        blop.move();
        PVector blopPos = blop.getPos();
        
        if (blopPos.x <= 0) {
          blop.setPos(new PVector(blopPos.x + width, blopPos.y));
        }
        else if(blopPos.x > width) {
          blop.setPos(new PVector(blopPos.x - width, blopPos.y));
        }
        if (blopPos.y <= 0) {
          blop.setPos(new PVector(blopPos.x, blopPos.y + height));
        } 
        else if ( blopPos.y > height) {
          blop.setPos(new PVector(blopPos.x, blopPos.y - height));
        }
      }
      
      ArrayList<Blop> uncheckBlop = new ArrayList<Blop>(population.size());
      for (Blop blop: population) {
        uncheckBlop.add(blop);
      }
      double distance;
      PVector firstBallPos, secondBallPos;
      double firstBallRadius, secondBallRadius, firstBallMass;
      Blop firstBall, secondBall;
      for (int i = 0; i < population.size() - 1; i++)  {
        
        firstBall = uncheckBlop.get(i);
        firstBallMass = firstBall.getMass();
        if(firstBallMass > 0) {
          for (int j = i + 1; j < population.size(); j++) {
            secondBall = uncheckBlop.get(j);
            firstBallPos = firstBall.getPos();
            firstBallRadius = firstBall.getSize() / 2;
            secondBallPos = secondBall.getPos();
            secondBallRadius = secondBall.getSize() / 2;
            if (firstBallPos.x + firstBallRadius + secondBallRadius > secondBallPos.x && firstBallPos.x < secondBallPos.x + firstBallRadius + secondBallRadius 
            && firstBallPos.y + firstBallRadius + secondBallRadius > secondBallPos.y && firstBallPos.y < secondBallPos.y + firstBallRadius + secondBallRadius) {
              distance = (firstBallPos.x - secondBallPos.x)*(firstBallPos.x - secondBallPos.x) + (firstBallPos.y - secondBallPos.y)*(firstBallPos.y - secondBallPos.y);
              if(distance < (firstBallRadius + secondBallRadius) * (firstBallRadius + secondBallRadius)) {
                if(firstBallRadius < secondBallRadius) {
                  secondBall.eat(firstBallMass);
                  population.remove(firstBall);
                } else if(secondBallRadius < firstBallRadius) {
                  firstBall.eat(secondBall.getMass());
                  population.remove(secondBall);
                } else {
                  population.remove(firstBall);
                  population.remove(secondBall);
                }
              }
            }
          }
        } else {
          population.remove(firstBall);
        }
      }
      
  }
  
  private void seed(int minPopulation) {
    int amountBlop = 0;
    int amountTry = 0;
    float blopSize;
    while(amountBlop < minPopulation && amountTry < 1000000) {
      blopSize = 100;
      PVector blopPos = new PVector(random(blopSize / 2, width - blopSize/2),random(blopSize / 2, height - blopSize / 2));
      if (!overlap(blopSize, blopPos)) {
        population.add(new Blop(blopPos, blopSize));
        amountBlop++;
      }
      amountTry++;
    }
  }
  
  private boolean overlap(float blopSize, PVector blopPos){
    for(Blop other : population) {
      if(blopPos.dist(other.getPos()) < (blopSize + other.getSize())) {
        return true;
      }
    }
    return false;
  }
  
  public void draw() {
    rect(0,0,width, height);
    for (Blop blop : population) {
      PVector pos = blop.getPos();
      double size = blop.getSize();
      if(pos.x <= size/2) {
        blop.draw(pos.x + width, pos.y);
      } else if(pos.x > width - size/2) {
        blop.draw(pos.x - width, pos.y);
      }
      if(pos.y <= size/2) {
        blop.draw(pos.x, pos.y + height);
      } else if(pos.y > height - size/2) {
        blop.draw(pos.x, pos.y - height);
      }
      blop.draw();
    }
  }
  
  public int getHeight(){
    return height;
  }
  
  public int getWidth() {
    return width;
  }
}