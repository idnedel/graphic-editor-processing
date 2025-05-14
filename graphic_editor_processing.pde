// lista com as TextBox aceitas na janela principal
private ArrayList<TextBox> textboxes = new ArrayList<TextBox>();

int drawMode = 0;

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

TextBox rTriangle; // Red
TextBox gTriangle; // Green
TextBox bTriangle; // Blue
TextBox sizeTriangle; // Tamanho lado
TextBox strokeTriangle; // Espessura

// botao de limpar tela
TextBox clearButton;

// identificar se está desenhando círculos ou quadrados
boolean drawCircle = false;
boolean drawTriangle = false;

// config iniciais para o editor gráfico.
public void setup() {
    size(1280, 720);
    background(255);

    // config comuns para todas as TextBoxes
    final int textBoxWidth = 50;
    final int textBoxHeight = 40;
    final int startY = height - 100;
    final int squareStartX = 50;
    final int circleStartX = 450;
    final int triangleStartX = 790;
    final int xIncrement = 60;

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
    
        // Cria TextBoxes para o triângulo
    for (int i = 0; i < 4; i++) {
        TextBox tb = new TextBox();
        tb.X = triangleStartX + i * xIncrement;
        tb.Y = startY;
        tb.W = textBoxWidth;
        tb.H = textBoxHeight;
        textboxes.add(tb);
        
        switch(i) {
            case 0: rTriangle = tb; break;
            case 1: gTriangle = tb; break;
            case 2: bTriangle = tb; break;
            case 3: sizeTriangle = tb; break;
        }
    }
    
    // TextBox para espessura do quadrado
      strokeSquare = new TextBox();
      strokeSquare.X = 350;
      strokeSquare.Y = startY;
      strokeSquare.W = textBoxWidth;
      strokeSquare.H = textBoxHeight;
      strokeSquare.Text = "1";
      textboxes.add(strokeSquare);

      // TextBox para espessura do círculo
      strokeCircle = new TextBox();
      strokeCircle.X = 690;
      strokeCircle.Y = startY;
      strokeCircle.W = textBoxWidth;
      strokeCircle.H = textBoxHeight;
      strokeCircle.Text = "1";
      textboxes.add(strokeCircle);
      
      // TextBox para espessura do triângulo
      strokeTriangle = new TextBox();
      strokeTriangle.X = 1030;
      strokeTriangle.Y = startY;
      strokeTriangle.W = textBoxWidth;
      strokeTriangle.H = textBoxHeight;
      strokeTriangle.Text = "1";
      textboxes.add(strokeTriangle);
      
      clearButton = new TextBox();
      clearButton.X = width - 155;
      clearButton.Y = height - 100;
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
    text("G", 115, height - 35);
    text("B", 175, height - 35);
    text("L", 235, height - 35);
    text("A", 295, height - 35);
    text("Espessura", 355, height - 35);
    
    // configurações do círculo
    text("Círculo", 450, height - 120);
    text("R", 455, height - 35);
    text("G", 515, height - 35);
    text("B", 575, height - 35);
    text("D", 635, height - 35);
    text("Espessura", 695, height - 35);
    
    // Configurações do triângulo
    text("Triângulo", 790, height - 120);
    text("R", 795, height - 35);
    text("G", 855, height - 35);
    text("B", 915, height - 35);
    text("T", 975, height - 35);
    text("Espessura", 1035, height - 35);

    // desenha as TextBox de configurações
    for (TextBox t : textboxes) {
        t.DRAW();
    }
}

private void clearCanvas() {
    // Limpa apenas a área de desenho (direita da linha divisória)
    for (int x = 0; x < width; x++) {
        for (int y = 0; y < height - 150; y++) {
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
    
    // Verifica qual forma está selecionada
    if (rCircle.selected || gCircle.selected || bCircle.selected || dCircle.selected || strokeCircle.selected) {
        drawCircle = true;
        drawTriangle = false; // Adicionado
    } else if (rTriangle.selected || gTriangle.selected || bTriangle.selected || sizeTriangle.selected || strokeTriangle.selected) {
        drawCircle = false;
        drawTriangle = true; // Adicionado
    } else if (rSquare.selected || gSquare.selected || bSquare.selected || wSquare.selected || hSquare.selected || strokeSquare.selected) {
        drawCircle = false;
        drawTriangle = false; // Adicionado
    }
    
    for (TextBox t : textboxes) {
        t.PRESSED(mouseX, mouseY);
    }
    
    if (mouseY < height - 150) {
        if (drawCircle) {
            drawCircle();
        } else if (drawTriangle) { // Adicionado
            drawTriangle();
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

private void drawTriangle() {
    int size = int(sizeTriangle.Text);
    if (size <= 0) return; // Proteção contra tamanho inválido
    
    // Calcula os três pontos do triângulo equilátero
    int x1 = mouseX;
    int y1 = mouseY - size;
    int x2 = mouseX - size;
    int y2 = mouseY + size;
    int x3 = mouseX + size;
    int y3 = mouseY + size;
    
    // Define a cor do triângulo
    color triColor = color(int(rTriangle.Text), int(gTriangle.Text), int(bTriangle.Text));
    int thickness = max(1, int(strokeTriangle.Text));
    
    // Desenha as três linhas com a espessura correta
    drawTriangleLine(x1, y1, x2, y2, triColor, thickness);
    drawTriangleLine(x2, y2, x3, y3, triColor, thickness);
    drawTriangleLine(x3, y3, x1, y1, triColor, thickness);
}

private void drawTriangleLine(int x1, int y1, int x2, int y2, color lineColor, int thickness) {
    int halfThickness = thickness / 2;
    int dx = Math.abs(x2 - x1);
    int dy = Math.abs(y2 - y1);
    int sx = (x1 < x2) ? 1 : -1;
    int sy = (y1 < y2) ? 1 : -1;
    int err = dx - dy;
    
    while (true) {
        // Desenha a linha com espessura
        for (int i = -halfThickness; i <= halfThickness; i++) {
            for (int j = -halfThickness; j <= halfThickness; j++) {
                if (i*i + j*j <= halfThickness*halfThickness) {
                    set(x1 + i, y1 + j, lineColor);
                }
            }
        }
        
        if (x1 == x2 && y1 == y2) break;
        int e2 = 2 * err;
        if (e2 > -dy) { err -= dy; x1 += sx; }
        if (e2 < dx) { err += dx; y1 += sy; }
    }
}
