class No {
  // Identificador do no:
  final String id;

  // Posicao do no (x, y):
  final Map<String, int> posicao;

  // Construtor:
  No(this.id, this.posicao);
}

class Grafo {
  // "Lista" de adjacências:
  final List<No> Nos = [];

  // Quantidade de nós no grafo:
  int qntdNos = 0;

  void addNo(int x, int y) {
    // Cria um novo Nó:
    No novoNo = No('($x|$y)', {'x': x, 'y': y});

    // Adiciona o Nó na Lista de Nós:
    Nos.add(novoNo);

    // Incrementa a quantidade de nós no grafo:
    qntdNos++;
  }

  No? getNo(String id) {
    // Procura o Nó pelo ID na Lista de Nós:
    for (var no in Nos) {
      if (no.id == id) {
        return no;
      }
    }

    // Retorna null caso não encontre o Nó:
    return null;
  }

  void printGrafo() {
    // Percorre os nós da Lista de adjacências:
    for (var no in Nos) {
      // Printa o ID do Nó e o ID dos seus Vizinhos no console:

      print('Nó: ${no.id}');
    }
  }
}

class ElementoHeap {
  // Custo da aresta:
  double distancia = double.infinity;

  // Nó onde a aresta chega:
  final String noId;

  // Nó onde a aresta sai:
  final noVindo;

  // Construtor:
  ElementoHeap(this.noId, this.noVindo);
}

class Heap {
  final List<ElementoHeap> _heap = [];

  // Ver Raiz
  ElementoHeap? get verMenor => _heap.isEmpty ? null : _heap.first;

  // Adiciona um elemento
  void inserir(String no, String vindo) {
    ElementoHeap elemento = ElementoHeap(no, vindo);

    // Adiciona elemento
    _heap.add(elemento);

    // Shift Up
    _shiftUp(_heap.length - 1);
  }

  // Remove e retorna o menor elemento
  ElementoHeap? removerMenor() {
    if (_heap.isEmpty) return null;

    final ElementoHeap menorValor = _heap.first;

    // Substitui a raiz pelo último elemento e faz Heapfy
    _heap[0] = _heap.removeLast();

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
