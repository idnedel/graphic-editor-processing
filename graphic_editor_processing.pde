// lista com as TextBox aceitas na janela principal
private ArrayList<TextBox> textboxes = new ArrayList<TextBox>();

// lista de quadrados/retangulos pelo TextBox
TextBox rSquare; // Red 
TextBox gSquare; // Green
TextBox bSquare; // Blue
TextBox wSquare; // Largura
TextBox hSquare; // Altura
TextBox strokeSquare; // Espessura

// lista dos circulos pelo TextBox
TextBox rCircle; // Red
TextBox gCircle; // Green
TextBox bCircle; // Blue
TextBox dCircle; // Diametro
TextBox strokeCircle; // Espessura

// botao de limpar tela
TextBox clearButton;

// identificar se está desenhando círculos ou quadrados
boolean drawCircle = false;

// config iniciais para o editor gráfico.
public void setup() {
    size(1280, 720);
    background(255);

    // config comuns para todas as TextBoxes
    final int textBoxWidth = 70;
    final int textBoxHeight = 40;
    final int startY = height - 100;
    final int squareStartX = 50;
    final int circleStartX = 700;
    final int xIncrement = 100;

    // cria TextBox para o quadrado/retangulo
    for (int i = 0; i < 5; i++) {
        TextBox tb = new TextBox();
        tb.X = squareStartX + i * xIncrement;
        tb.Y = startY;
        tb.W = textBoxWidth;
        tb.H = textBoxHeight;
        textboxes.add(tb);
        
        // atribui às variáveis originais
        switch(i) {
            case 0: rSquare = tb; break;
            case 1: gSquare = tb; break;
            case 2: bSquare = tb; break;
            case 3: wSquare = tb; break;
            case 4: hSquare = tb; break;
        }
    }

    // cria TextBoxes para o círculo
    for (int i = 0; i < 4; i++) {
        TextBox tb = new TextBox();
        tb.X = circleStartX + i * xIncrement;
        tb.Y = startY;
        tb.W = textBoxWidth;
        tb.H = textBoxHeight;
        textboxes.add(tb);
        
        // atribui às variáveis originais
        switch(i) {
            case 0: rCircle = tb; break;
            case 1: gCircle = tb; break;
            case 2: bCircle = tb; break;
            case 3: dCircle = tb; break;
        }
    }
    
    // TextBox para espessura do quadrado
      strokeSquare = new TextBox();
      strokeSquare.X = 550;
      strokeSquare.Y = startY;
      strokeSquare.W = textBoxWidth;
      strokeSquare.H = textBoxHeight;
      strokeSquare.Text = "1";
      textboxes.add(strokeSquare);

      // TextBox para espessura do círculo
      strokeCircle = new TextBox();
      strokeCircle.X = 1105;
      strokeCircle.Y = startY;
      strokeCircle.W = textBoxWidth;
      strokeCircle.H = textBoxHeight;
      strokeCircle.Text = "1";
      textboxes.add(strokeCircle);
      
      clearButton = new TextBox();
      clearButton.X = width - 136;
      clearButton.Y = height - 195;
      clearButton.W = 130;
      clearButton.H = 38;
      clearButton.Text = "Limpar Tela";
      textboxes.add(clearButton);
    
}

// desenha as configurações do editor gráfico na tela
public void draw() {
    // dsenha a linha divisória entre as configurações e a área de desenho
    line(0, height - 150, width, height - 150);
    
    // configurações do quadrado
    textSize(16);
    fill(0);
    text("Quadrado", 50, height - 120);
    text("R", 55, height - 35);
    text("G", 155, height - 35);
    text("B", 255, height - 35);
    text("L", 355, height - 35);
    text("A", 455, height - 35);
    text("Espessura", 550, height - 35);
    
    // configurações do círculo
    text("Círculo", 700, height - 120);
    text("R", 705, height - 35);
    text("G", 805, height - 35);
    text("B", 905, height - 35);
    text("D", 1005, height - 35);
    text("Espessura", 1105, height - 35);

    // desenha as TextBox de configurações
    for (TextBox t : textboxes) {
        t.DRAW();
    }
}

private void clearCanvas() {
    for (int x = 0; x < width; x++) {
        for (int y = 0; y < height - 0; y++) {
            set(x, y, color(255));
        }
    }
}

// eventos do mouse 
public void mousePressed() {
    // verifica se clicou no botão de limpar
    if (clearButton.overBox(mouseX, mouseY)) {
        clearCanvas();
        return;
    }
    
    if (rCircle.selected || gCircle.selected || bCircle.selected || dCircle.selected || strokeCircle.selected) {
        drawCircle = true;
    } else if (rSquare.selected || gSquare.selected || bSquare.selected || wSquare.selected || hSquare.selected || strokeSquare.selected) {
        drawCircle = false;
    }
    
    for (TextBox t : textboxes) {
        t.PRESSED(mouseX, mouseY);
    }
    
    if (mouseY < height - 150) {
        if (drawCircle) {
            drawCircle();
        } else {
            drawSquare();
        }
    }
}
 
// evento de precionar tecla do teclado

public void keyPressed() {
    for (TextBox t : textboxes) {
        t.KEYPRESSED(key, (int) keyCode);
    }
}


// desenha um quadrado utilizando o algoritmo clássico de Bresenham para desenhar linhas

private void drawSquare() {
    
    // calcula as extremidadades finais que devem ser desenhadas
    int x = mouseX + int(wSquare.Text);
    int y = mouseY + int(hSquare.Text);

    // desenha as quatro linhas para formar o quadrado
    drawLine(mouseX, mouseY, x, mouseY);
    drawLine(x, mouseY, x, y);
    drawLine(x, y, mouseX, y);
    drawLine(mouseX, y, mouseX, mouseY);
}

 
// desenha uma linha utilizando o algoritmo clássico de Bresenham
// recebe duas cordenadas XY para traçar a reta

private void drawLine(int x1, int y1, int x2, int y2) {
    int thickness = max(1, int(strokeSquare.Text));
    int halfThickness = thickness / 2;
    color lineColor = color(int(rSquare.Text), int(gSquare.Text), int(bSquare.Text));
    
    // Algoritmo de Bresenham modificado para linha grossa
    int dx = Math.abs(x2 - x1);
    int dy = Math.abs(y2 - y1);
    int sx = (x1 < x2) ? 1 : -1;
    int sy = (y1 < y2) ? 1 : -1;
    int err = dx - dy;
    
    while (true) {
        // desenha múltiplos pontos para criar a espessura
        for (int i = -halfThickness; i <= halfThickness; i++) {
            for (int j = -halfThickness; j <= halfThickness; j++) {
                if (i*i + j*j <= halfThickness*halfThickness) {
                    stroke(lineColor);
                    point(x1 + i, y1 + j);
                }
            }
        }
        
        if (x1 == x2 && y1 == y2) break;
        int e2 = 2 * err;
        if (e2 > -dy) { err -= dy; x1 += sx; }
        if (e2 < dx) { err += dx; y1 += sy; }
    }
    
    stroke(0, 0, 0);
}

// desenha um círculo utilizando o algoritmo de Bresenham
private void drawCircle() {
    int thickness = max(1, int(strokeCircle.Text));
    color circleColor = color(int(rCircle.Text), int(gCircle.Text), int(bCircle.Text));
    int radius = int(dCircle.Text) / 2;
    
    // desenha múltiplos círculos concêntricos para criar espessura
    for (int r = radius - thickness/2; r <= radius + thickness/2; r++) {
        if (r <= 0) continue;
        
        int x = 0;
        int y = r;
        int d = 3 - 2 * r;
        stroke(circleColor);
        
        while (x <= y) {
            plotPoints(mouseX, mouseY, x, y);
            if (d < 0) {
                d = d + 4 * x + 6;
            } else {
                d = d + 4 * (x - y) + 10;
                y--;
            }
            x++;
        }
    }
    
    stroke(0, 0, 0);
}


// desenha na tela os pontos necessários para o desenho do círculo 
// utilizando o algoritmo clássico de Bresenham

private void plotPoints(int centerX, int centerY, int x, int y) {
    point(centerX + x, centerY + y);
    point(centerX - x, centerY + y);
    point(centerX + x, centerY - y);
    point(centerX - x, centerY - y);
    point(centerX + y, centerY + x);
    point(centerX - y, centerY + x);
    point(centerX + y, centerY - x);
    point(centerX - y, centerY - x);
}
