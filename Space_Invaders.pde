Skin player;
Skin[][] enemy = new Skin[11][5];
boolean tiroPlayerAbilitado = true, tiroEnemyAbilitado = true, gameOver = false;
int cont = 0;

void setup()
{
  size(810, 540);

  player = new Skin();

  for (int row=0; row<5; row++)
  {
    for (int col=0; col<11; col++)
    {
      enemy[col][row] = new Skin(col, row);
    }
  }
}

void draw()
{
  background(0);
  //translate(width/2, height/2);

  fill(0, 255, 128);
  player.draw();

  for (int row=0; row<5; row++)
  {
    for (int col=0; col<11; col++)
    {
      enemy[col][row].update();
      enemy[col][row].draw();
    }
  }

  cont++;

  if (cont > 15)
  {
    tiroPlayerAbilitado = true;
    tiroEnemyAbilitado = true;
    cont = 0;
  }

  fill(0, 255, 0);
  textSize(30);
  text("Life: " + player.vida, 20, 60);

  if (gameOver)
  {
    background(0);
    player.visible = false;

    for (int row=0; row<5; row++)
    {
      for (int col=0; col<11; col++)
      {
        enemy[col][row].visible = false;
      }
    }

    fill(255, 0, 0);
    textSize(50);
    textAlign(CENTER);
    text("GAME OVER", width/2, height/3);

    noLoop();
  }
}

void keyPressed()
{
  switch(keyCode)
  {
  case LEFT:
    player.percent-=0.01;
    break;

  case RIGHT:
    player.percent+=0.01;
    break;

  case ' ':
    if (tiroPlayerAbilitado)
    {
      tiroPlayerAbilitado = false;
      player.atirar();
    }
    break;
  }
}