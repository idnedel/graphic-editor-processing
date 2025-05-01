// lista com as TextBox aceitas na janela principal
private ArrayList<TextBox> textboxes = new ArrayList<TextBox>();

// lista de quadrados/retangulos pelo TextBox
TextBox rSquare; // Red 
TextBox gSquare; // Green
TextBox bSquare; // Blue
TextBox wSquare; // Largura
TextBox hSquare; // Altura

// lista dos circulos pelo TextBox
TextBox rCircle; // Red
TextBox gCircle; // Green
TextBox bCircle; // Blue
TextBox dCircle; // Diametro

// identificar se está desenhando círculos ou quadrados
boolean drawCircle = false;

// config iniciais para o editor gráfico.
public void setup() {
    size(1280, 720);
    background(255);

    // config comuns para todas as TextBoxes
    final int textBoxWidth = 120;
    final int textBoxHeight = 40;
    final int startX = 35;
    final int squareStartY = 50;
    final int circleStartY = 350;
    final int yIncrement = 50;

    // arrays para armazenar as TextBox
    TextBox[] squareTextBoxes = new TextBox[5]; // R, G, B, L, A
    TextBox[] circleTextBoxes = new TextBox[4]; // R, G, B, D

    // cria TextBox para o quadrado/retangulo
    for (int i = 0; i < squareTextBoxes.length; i++) {
        TextBox tb = new TextBox();
        tb.X = startX;
        tb.Y = squareStartY + i * yIncrement;
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
    for (int i = 0; i < circleTextBoxes.length; i++) {
        TextBox tb = new TextBox();
        tb.X = startX;
        tb.Y = circleStartY + i * yIncrement;
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
}

 
// desenha as configurações do editor gráfico na tela

public void draw() {
    
    textSize(16);
    text("Quadrado", 15, 25);
    text("Círculo", 15, 325);

    // configurações do quadrado    
    text("R", 15, 75);
    text("G", 15, 125);
    text("B", 15, 175);
    text("L", 15, 225);
    text("A", 15, 275);

    // configurações do círculo
    text("R", 15, 375);
    text("G", 15, 425);
    text("B", 15, 475);
    text("D", 15, 525);

    // desenha a linha divisória entre as configurações e a área de desenho
    line(180, 0, 180, height);

    // desenha as TextBox de configurações
    for (TextBox t : textboxes) {
        t.DRAW();
    }
}


// eventos do mouse 

public void mousePressed() {
    // se a última configuração selecionado foi de círculo, indica que deve desenhar círculos
    if (rCircle.selected || gCircle.selected || bCircle.selected || dCircle.selected) {
        drawCircle = true;
    // se a última configuração selecionado foi de quadrado, indica que deve desenhar quadrados
    } else if (rSquare.selected || gSquare.selected || bSquare.selected || wSquare.selected || hSquare.selected) {
        drawCircle = false;
    }

    // varre os Text Boxes para inserir o que foi digitado
    for (TextBox t : textboxes) {
        t.PRESSED(mouseX, mouseY);
    }
    
    // testa se clicou o mouse na área de desenho (área permitida)
    if (mouseX > 250) {
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
    int dx = Math.abs(x2 - x1);
    int dy = Math.abs(y2 - y1);
    int sx = (x1 < x2) ? 1 : -1;
    int sy = (y1 < y2) ? 1 : -1;
    int err = dx - dy;
    stroke(int(rSquare.Text), int(gSquare.Text), int(bSquare.Text));
    while (true) {
        point(x1, y1);
        if (x1 == x2 && y1 == y2) {
            break;
        }
        int e2 = 2 * err;
        if (e2 > -dy) {
            err -= dy;
            x1 += sx;
        }
        if (e2 < dx) {
            err += dx;
            y1 += sy;
        }
    }
    stroke(0, 0, 0);
}

// desenha um círculo utilizando o algoritmo de Bresenham

private void drawCircle() {
    int x = 0;
    int y = int(dCircle.Text) / 2;
    int d = 3 - 2 * y;
    stroke(int(rCircle.Text), int(gCircle.Text), int(bCircle.Text));
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
