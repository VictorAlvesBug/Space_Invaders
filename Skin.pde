class Skin
{
  String str, nome;
  PVector pos, index = new PVector(10, 10);
  float percent = 0.5, direcao = 1;
  ArrayList<Shot> shot = new ArrayList<Shot>();
  boolean visible = true;
  int vida;

  Skin()
  {
    this.pos = new PVector(width/2, height-30);

    /// Player
    str =
      "00000100000"+
      "00111111100"+
      "00111111100"+
      "01111111110";
    nome = "Player";
    vida = 5;
  }

  Skin(int x, int y)
  {
    index = new PVector(x, y);
    //area do jogo 300x200       (810x540)
    //area dos inimigos 200x80   (540x216)

    this.pos = new PVector(135+x*(540/11.0), 80+y*(216/5.0));

    /// Enemy
    str =
      "00100000100"+
      "00010001000"+
      "00111111100"+
      "01101110110"+
      "11111111111"+
      "10111111101"+
      "10100000101"+
      "00011011000";
    nome = "Enemy";
    vida = 1;
  }

  void atirar()
  {
    if (nome == "Player")
    {
      shot.add(new Shot(pos.x + (540/10.0)/2, pos.y, "up"));
    } else
    {
      shot.add(new Shot(pos.x + (540/15.0)/2, pos.y+40, "down"));
    }
  }

  void update()
  {
    pos.x += direcao/3;

    if (pos.x+20 < 80)
    {
      for (int row=0; row<5; row++)
      {
        for (int col=0; col<11; col++)
        {
          enemy[col][row].pos.y += 5;
          enemy[col][row].pos.x += 2;
          enemy[col][row].direcao = 1;
        }
      }
    } else if (pos.x+20 > width-80)
    {
      for (int row=0; row<5; row++)
      {
        for (int col=0; col<11; col++)
        {
          enemy[col][row].pos.y += 5;
          enemy[col][row].pos.x -= 2;
          enemy[col][row].direcao = -1;
        }
      }
    }

    if (visible && tiroEnemyAbilitado)
    {
      int col = (int)random(11);
      for (int row=4; row>=0; row--)
      { 
        if (enemy[col][row].visible)
        {
          tiroEnemyAbilitado = false;
          enemy[col][row].atirar();
          return;
        }
      }
    }
  }

  void draw()
  {
    switch((int)index.y)
    {
    case 0:
      fill(255, 0, 0);
      break;
    case 1:
      fill(255, 255, 0);
      break;
    case 2:
      fill(255, 128, 0);
      break;
    case 3:
      fill(0, 0, 128);
      break;
    case 4:
      fill(0, 128, 0);
      break;
    }

    if (vida <= 0)
    {
      visible = false;

      if (nome == "Player")
      {
        gameOver = true;
      }
    }

    if (visible)
    {
      float dim = (540/15.0)/11.0;

      if (percent < 0)
      {
        percent = 0;
      } else if (percent > 1)
      {
        percent = 1;
      }

      if (nome == "Player")
      {
        dim *= 1.5;
        pos.x = lerp(dim, width-dim, percent);
      } else
      {
        pos.x += 1*(percent-0.5)*2;
      }

      noStroke();

      pushMatrix();
      translate(pos.x, pos.y);

      for (int row=0; row<str.length()/11; row++)
      {
        for (int col=0; col<11; col++)
        {
          if (str.charAt(col+row*11) == '1')
          {
            rect(dim*col, dim*row, dim+1, dim+1);
          }
        }
      }
      popMatrix();

      for (Shot s : shot)
      {
        s.update();
        s.draw();
      }
    }
  }
}