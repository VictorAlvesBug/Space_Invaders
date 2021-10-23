class Shot
{
  PVector pos;
  String direcao;
  boolean visible = true;

  Shot(float x, float y, String dir)
  {
    pos = new PVector(x, y);
    direcao = dir;
  }

  void update()
  {
    if (pos.y>0 && pos.y<height)
    {
      if (direcao == "up")
      {
        pos.y -= 20;
      } else
      {
        pos.y += 15;
      }
    }
    else
    {
      visible = false;
    }

    if (visible)
    {
      if (player.visible &&
        pos.x > player.pos.x && pos.x < player.pos.x+40 &&
        pos.y > player.pos.y && pos.y < player.pos.y+30)
      {
        this.visible = false;
        player.vida--;
      }

      for (int row=0; row<5; row++)
      {
        for (int col=0; col<11; col++)
        {
          if (enemy[col][row].visible &&
            pos.x > enemy[col][row].pos.x && pos.x < enemy[col][row].pos.x+40 &&
            pos.y > enemy[col][row].pos.y && pos.y < enemy[col][row].pos.y+30)
          {
            this.visible = false;
            enemy[col][row].vida--;
          }
        }
      }
    }
  }

  void draw()
  {
    if (visible)
    {
      fill(255);
      rect(pos.x-1, pos.y-4, 2, 8);
    }
  }
}