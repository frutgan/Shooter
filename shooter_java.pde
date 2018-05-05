import ddf.minim.*;

Minim minim;
AudioPlayer player;

int puntos=0;
int repinta=1;
int jugar=1;
float size;
int radio=30;
int radio_objetivo;
float posx;
float posy;

void setup() {
  size(900, 600);
  cursor(CROSS);
  minim = new Minim(this);

  // loadFile will look in all the same places as loadImage does.
  // this means you can find files that are in the data folder and the 
  // sketch folder. you can also pass an absolute path, or a URL.
  player = minim.loadFile("Headshot.mp3");
}

void draw() {

  if (repinta==1 && jugar==1) {

    dibujar_forma();
  }
  repinta=0;
}
void dibujar_forma() {
  background(0);
  //dibujar objetivos falsos.
  for (int i=0; i<=puntos; i++) {
    size=random(5, 50);
    fill(random(0, 255), random(0, 255), random(0, 255));
    ellipse(random(100, 800), random(100, 500), size, size);
  }

  //objetivo verdadero

  radio_objetivo= radio-puntos;

  fill(250, 0, 0);
  posx=random(100, 800);
  posy=random(100, 500);
  ellipse(posx,posy , radio_objetivo, radio_objetivo); 

  textAlign(CENTER);
  textSize(24);
  text("puntos: " +puntos, width/2, 25);
  if (radio_objetivo==5){
    ganar();
  }
    
}
void ganar(){
  background(255,255,255);
  textAlign(CENTER);
  textSize(64);
  text("YOU WIN!", width/2, height/2);
  jugar=0;
}
void mouseReleased() {
  if ( player.isPlaying() )
  {
    player.pause();
  }
  // if the player is at the end of the file,
  // we have to rewind it before telling it to play again
  else if ( player.position() == player.length() )
  {
    player.rewind();
    player.play();
  } else
  {
    player.play();
  }
}
void mousePressed(){
  if (jugar==1){
      if (repinta==0){
          repinta=1;
      }
      if (mouseX>posx-radio_objetivo && mouseX< posx+radio_objetivo && mouseY>posy-radio_objetivo && mouseY<posy+radio_objetivo){
  
            
        puntos+=1;
      }
      else{
         background(255,255,255);
        textAlign(CENTER);
        textSize(44);
        text("MEQUETREFE HAS PERDIDO XS", width/2, height/2);
       jugar=0;
      }
      
  }
  
}