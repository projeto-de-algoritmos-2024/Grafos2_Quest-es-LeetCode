class ElementoHeap {
  // Custo da aresta:
  double distancia = double.infinity;

  // Nó onde a aresta chega:
  final String noId;

  // Nó onde a aresta sai:
  String noVindo = "";

  // Construtor:
  ElementoHeap(this.noId);
}

class Heap {
  final List<ElementoHeap> _heap = [];

  // Ver Raiz
  ElementoHeap? get verMenor => _heap.isEmpty ? null : _heap.first;

  // Adiciona um elemento
  void inserir(String no) {
    ElementoHeap elemento = ElementoHeap(no);

    // Adiciona elemento
    _heap.add(elemento);
  }

  void atualizarElemento(String id, double distancia, String noVindo) {
    // Procura o elemento
    final elemento = _heap.firstWhere((elemento) => elemento.noId == id);

    // Atualiza o elemento
    elemento.distancia = distancia;
    elemento.noVindo = noVindo;

    _shiftUp(_heap.indexOf(elemento));
  }

  // Remove e retorna o menor elemento
  ElementoHeap? removerMenor() {
    if (_heap.isEmpty) return null;

    final ElementoHeap menorValor = _heap.first;

    // Substitui a raiz pelo último elemento e faz Heapfy
    _heap[0] = _heap.last;
    _heap.removeLast();

    if (_heap.isNotEmpty) _heapfy(0);

    // Retorna o menor elemento
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

  // Troca dois Elementos
  void _swap(int a, int b) {
    final temp = _heap[a];
    _heap[a] = _heap[b];
    _heap[b] = temp;
  }

  // Retorna a heap para visualizar
  List<ElementoHeap> get elementos => List.unmodifiable(_heap);
}

class Solution {
  // Direções de "movimento" possíveis:
  List<List<int>> direcoes = [
    [0, 1],
    [0, -1],
    [1, 0],
    [-1, 0]
  ];

  void minCost(List<List<int>> grid) {}
}
