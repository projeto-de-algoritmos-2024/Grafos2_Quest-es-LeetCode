class No {
  // Custo da aresta:
  double distancia = double.infinity;

  // Posição X do nó:
  final int x;

  // Posição Y do nó:
  final int y;

  // Construtor:
  No(this.x, this.y);
}

class Heap {
  final List<No> _heap = [];

  // Ver Raiz
  No? get verMenor => _heap.isEmpty ? null : _heap.first;

  // Adiciona um no
  void inserir(int x, int y) {
    No no = No(x, y);

    // Adiciona no
    _heap.add(no);
  }

  void atualizarNo(int x, int y, double distancia) {
    // Procura o no
    final no = _heap.firstWhere((no) => no.x == x && no.y == y);

    // Atualiza o no
    no.distancia = distancia;

    _shiftUp(_heap.indexOf(no));
  }

  // Remove e retorna o menor no
  No? removerMenor() {
    if (_heap.isEmpty) return null;

    final No menorValor = _heap.first;

    // Substitui a raiz pelo último no e faz Heapfy
    _heap[0] = _heap.last;
    _heap.removeLast();

    if (_heap.isNotEmpty) _heapfy(0);

    // Retorna o menor no
    return menorValor;
  }

  void _shiftUp(int indice) {
    // Verifica se não é a raiz
    while (indice > 0) {
      // Pai do indice atual
      final indicePai = (indice - 1) ~/ 2;

      // Verifica se o atual é menor que o pai
      if (_heap[indice].distancia < (_heap[indicePai].distancia)) {
        // Troca
        _swap(indice, indicePai);

        // Atualiza indice
        indice = indicePai;
      } else {
        break;
      }
    }
  }

  void _heapfy(int indice) {
    // Ultimo indice
    final ultimoIndice = _heap.length - 1;

    while (true) {
      // Filhos da esquerda e direita
      final filhoEsquerda = 2 * indice + 1;
      final filhoDireita = 2 * indice + 2;

      // Menor indice
      int menorIndice = indice;

      // Verifica se o indice "filho da esquerda" está na heap, e se é menor que o de cima:
      if (filhoEsquerda <= ultimoIndice &&
          _heap[filhoEsquerda].distancia < (_heap[menorIndice].distancia)) {
        // Atualia o menor indice:
        menorIndice = filhoEsquerda;
      }

      // Verifica se o indice "filho da direita" está na heap, e se é menor que o de cima:
      if (filhoDireita <= ultimoIndice &&
          _heap[filhoDireita].distancia < (_heap[menorIndice].distancia)) {
        // Atualiza o menor indice:
        menorIndice = filhoDireita;
      }

      // Se chegou na raiz, para:
      if (menorIndice == indice) break;

      // Troca com a raiz pois é menor:
      _swap(indice, menorIndice);

      // Atualiza para continuar descendo na heap e verificando:
      indice = menorIndice;
    }
  }

  // Troca dois Nos
  void _swap(int a, int b) {
    final temp = _heap[a];
    _heap[a] = _heap[b];
    _heap[b] = temp;
  }

  // Retorna a heap para visualizar
  List<No> get nos => List.unmodifiable(_heap);
}

class Solution {
  // Direções de "movimento" possíveis:
  List<List<int>> direcoes = [
    [0, 1],
    [0, -1],
    [1, 0],
    [-1, 0]
  ];

  void minCost(List<List<int>> grid) {
    // Custo final:
    double custo = -1;

    // Tamanho da Grid:
    int linhas = grid.length;
    int colunas = grid[0].length;

    // Matriz Distâncias (Vai ser nosso pseudo grafo):
    List<List<double>> distancias =
        List.generate(linhas, (_) => List.filled(colunas, double.infinity));

    // Heap:
    final Heap heap = Heap();

    // Adiciona nos da Grid na Heap:
    for (int i = 0; i < linhas; i++) {
      for (int j = 0; j < colunas; j++) {
        heap.inserir(i, j);
      }
    }

    while (heap.nos.isNotEmpty) {
      // Pega o menor no e Heapfy:
      final No menorNo = heap.removerMenor()!;

      // Verifica se chegou na última posição da Grid:
      if (menorNo.x == linhas - 1 && menorNo.y == colunas - 1) {
        // Atualiza o custo total:
        custo = menorNo.distancia;
        break;
      }
    }
  }
}
