# 3112. Minimum Time to Visit Disappearing Nodes

### Link Questão: [3112. Minimum Time to Visit Disappearing Nodes](https://leetcode.com/problems/minimum-time-to-visit-disappearing-nodes/description/)

#### Nível: Média

#### Linguagem utilizada: Java

---

## Resultado Juiz Eletrônico (LeetCode)

<center> 

![Resultado](../../assets/accepted_medium2.png)

![Resultado Detalhado](../../assets/details_medium2.png)

</center>

## Resumo

Você tem um grafo não direcionado com n nós.

1. Arestas: 
- As arestas são representadas por um array 2D chamado ``edges``, onde cada aresta é descrita por ``[ui, vi, length]``. Isso significa que há uma conexão entre os nós ***ui*** e ***vi*** com um custo ou tempo de travessia igual a length.

2. Desaparecimento dos Nós:
-  Existe um array chamado disappear que indica o tempo em que cada nó desaparece. A partir desse tempo, o nó não pode mais ser visitado.

3. Características do Grafo:
-  O grafo pode ser desconexo, ou seja, alguns nós podem não estar conectados. Ele também pode conter múltiplas arestas entre os mesmos pares de nós.

Objetivo: O objetivo é retornar um array chamado ``answer``, onde ``answer[i]`` indica o menor tempo necessário para alcançar o nó ***i*** a partir do nó 0. Se o nó ***i*** não puder ser alcançado, o valor em ``answer[i]`` deve ser -1.


## Solução

### Arquivo: [3112.Minimum_Time_to_Visit_Disappearing_Nodes.java](./3112.Minimum_Time_to_Visit_Disappearing_Nodes.java)

### Código em Java:

```java

import java.util.*;

class Solution {
    public int[] minimumTime(int n, int[][] edges, int[] disappear) {
        // Grafo representado como lista de adjacência
        // Cada nó terá uma lista de pares {vizinho, peso da aresta}
        List<int[]>[] graph = new ArrayList[n];
        for (int i = 0; i < n; i++) {
            graph[i] = new ArrayList<>(); // Inicializa uma lista vazia para cada nó
        }

        // Preenchendo a lista de adjacência com as arestas fornecidas
        for (int[] edge : edges) {
            int u = edge[0]; // Nó de origem
            int v = edge[1]; // Nó de destino
            int weight = edge[2]; // Peso da aresta
            graph[u].add(new int[]{v, weight}); // Adiciona a aresta (v, peso) ao nó u
            graph[v].add(new int[]{u, weight}); // Adiciona a aresta (u, peso) ao nó v (grafo não-direcionado)
        }

        // Array para armazenar as distâncias mínimas do nó 0 para todos os outros nós
        int[] distances = new int[n];
        Arrays.fill(distances, Integer.MAX_VALUE); // Inicializa todas as distâncias como infinito
        distances[0] = 0; // Distância do nó 0 para ele mesmo é 0

        // Fila de prioridade para implementar o algoritmo de Dijkstra
        // A fila armazena pares {tempo acumulado, nó}, e o nó com menor tempo é processado primeiro
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> Integer.compare(a[0], b[0]));
        pq.offer(new int[]{0, 0}); // Adiciona o nó inicial (0) com tempo acumulado 0

        // Array booleano para rastrear quais nós já foram visitados
        boolean[] visited = new boolean[n];

        // Enquanto houver nós na fila de prioridade
        while (!pq.isEmpty()) {
            // Remove o nó com menor tempo acumulado
            int[] current = pq.poll();
            int time = current[0]; // Tempo acumulado até o nó atual
            int node = current[1]; // Nó atual

            // Se o nó já foi visitado ou desapareceu, ignore
            if (visited[node] || time >= disappear[node]) {
                continue; // Pula para o próximo item na fila
            }

            // Marca o nó atual como visitado
            visited[node] = true;

            // Itera sobre todos os vizinhos do nó atual
            for (int[] neighbor : graph[node]) {
                int neighborNode = neighbor[0]; // Nó vizinho
                int weight = neighbor[1]; // Peso da aresta até o vizinho
                int newTime = time + weight; // Tempo acumulado para alcançar o vizinho

                // Atualiza a distância mínima se:
                // 1. O novo tempo é menor que a distância já registrada para o vizinho
                // 2. O vizinho ainda não desapareceu
                if (newTime < distances[neighborNode] && newTime < disappear[neighborNode]) {
                    distances[neighborNode] = newTime; // Atualiza a distância mínima
                    pq.offer(new int[]{newTime, neighborNode}); // Adiciona o vizinho na fila
                }
            }
        }

        // Substitui distâncias "infinito" por -1 para representar nós inacessíveis
        for (int i = 0; i < n; i++) {
            if (distances[i] == Integer.MAX_VALUE) {
                distances[i] = -1;
            }
        }

        // Retorna o array de distâncias mínimas
        return distances;
    }
}

```