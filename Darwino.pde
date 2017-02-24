Board board;

void setup() {
  size(1900, 1200);
  board = new Board(1700, 1000, 100);
}

void draw() {
  background(60);
  translate(100, 100);
  fill(255);
  stroke(0);
  board.draw();
  board.startLife();
  translate(-100, -100);
  fill(0);
  noStroke();
  float boardHeight=board.getHeight() + 100;
  float boardWidth=board.getWidth() + 100;
  rect(0,0,1900,100);
  rect(0,0,100,1200);
  rect(0, boardHeight, 1900, boardHeight);
  rect(boardWidth, 0, boardWidth, 1200);}