// Classe para representar um Nó:
class No {
  // Identificador do no:
  final String id;

  // Posicao do no (x, y):
  final Map<String, int> posicao;

  // Construtor:
  No(this.id, this.posicao);
}

class Aresta {
  // Nós que a aresta conecta:
  final No u, v;

  // Peso da aresta:
  final int peso;

  // Construtor:
  Aresta(this.u, this.v, this.peso);
}

// Classe para representar um Grafo:
class Grafo {
  // "Lista" de adjacências:
  final Map<No, List<Aresta>> adjacencias = {};

  // Quantidade de nós no grafo:
  int qntdNos = 0;

  // Quantidade de arestas no grafo:
  int qntdArestas = 0;

  void addNo(int x, int y) {
    // Cria um novo Nó:
    No novoNo = No('($x|$y)', {'x': x, 'y': y});

    // Adiciona o Nó na Lista de adjacências:
    adjacencias[novoNo] = [];

    // Incrementa a quantidade de nós no grafo:
    qntdNos++;
  }

  void addAresta(No u, No v, int peso) {
    // Cria uma nova Aresta:
    Aresta novaAresta = Aresta(u, v, peso);

    // Adiciona a Aresta na Lista de adjacências:
    adjacencias[u]!.add(novaAresta);
    adjacencias[v]!.add(novaAresta);

    // Incrementa a quantidade de arestas no grafo:
    qntdArestas++;
  }

  /* 
    * Retorna um Nó do Grafo pelo seu ID.
    * 
    * Parâmetros:
    * - id: identificador do nó.
    * 
    * Retorno:
    * - Nó do Grafo com o ID especificado | null.
    */
  No? getNo(String id) {
    // Procura o nó pelo ID na Lista de adjacências:
    for (var no in adjacencias.keys) {
      // Se encontrar o nó, retorna ele:
      if (no.id == id) {
        return no;
      }
    }

    // Caso não encontre, retorna null:
    return null;
  }

  /* 
    * Printa os Nós do Grafo e suas adjacências.
    * 
    */
  void printGrafo() {
    // Percorre os nós da Lista de adjacências:
    for (var no in adjacencias.keys) {
      // Printa o ID do Nó e o ID dos seus Vizinhos no console:

      print('${no.id} -> ${adjacencias[no]!.map((e) => e.id).toList()} \n');
    }
  }
}

class Heap {
  List<int> heap = [];

  int tamanho() {
    return heap.length;
  }
}
