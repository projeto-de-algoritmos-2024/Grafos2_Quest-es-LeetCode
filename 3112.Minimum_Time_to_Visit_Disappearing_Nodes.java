import java.util.*; // Importamos as coleções necessárias (Map, List, PriorityQueue, etc.)

class Solution {
    public int[] minimumTime(int n, int[][] edges, int[] disappear) {
        
        Map<Integer, List<int[]>> graph = new HashMap<>(); //Construção do grafo como uma lista de adjacência
        for (int i = 0; i < n; i++) {
            graph.put(i, new ArrayList<>());
        }

        // O grafo é representado como um HashMap: A chave é o número do nó (de 0 a n-1).
        // O valor é uma lista de pares [vizinho, peso], que representam as arestas.
        for (int[] edge : edges) {
            int u = edge[0]; // Nó de origem
            int v = edge[1]; // Nó de destino
            int length = edge[2]; // Valor da aresta
            graph.get(u).add(new int[]{v, length}); // Adiciona o vizinho na lista de adjacência de u
            graph.get(v).add(new int[]{u, length}); // Adiciona o vizinho na lista de adjacência de v 
        }


        int[] distances = new int[n]; //  array que armazena a menor distância de 0 até cada nó.

        Arrays.fill(distances, Integer.MAX_VALUE); //  Setando todas as distâncias como "infinito" (Integer.MAX_VALUE) porque ainda não foi calculado nenhum caminho.
        distances[0] = 0;  // Definindo a distância para o nó inicial (0) como 0
        
        
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]); 
        // Fila de prioridade para processar nós com base no menor tempo acumulado, [tempo acumulado, nó atual].
        // O comparator `(a, b) -> a[0] - b[0]` garante que o nó com o menor tempo acumulado seja processado primeiro.

        pq.offer(new int[]{0, 0}); // Adicionamos o nó inicial (0) com tempo acumulado 0 na fila.

        // Processar os nós usando Dijkstra 
        while (!pq.isEmpty()) {
            int[] current = pq.poll(); // Pegamos o nó com o menor tempo acumulado
            int time = current[0]; // Tempo acumulado até o nó atual
            int node = current[1]; // Nó atual
            
            // Ignorar o nó se ele já desapareceu no tempo atual
            if (time >= disappear[node]) {
                continue;
            }
            // Percorrer todos os vizinhos do nó atual
            for (int[] neighbor : graph.get(node)) {
                int neighborNode = neighbor[0]; // Nó vizinho
                int weight = neighbor[1]; // Peso da aresta para o vizinho
                int newTime = time + weight; // Tempo acumulado para alcançar o vizinho

                // Se o novo tempo for menor que a distância atual e o vizinho ainda não desapareceu
                if (newTime < distances[neighborNode] && newTime < disappear[neighborNode]) {
                    distances[neighborNode] = newTime; // Atualizar a menor distância
                    pq.offer(new int[]{newTime, neighborNode}); // Adicionar o vizinho à fila de prioridade
                }
            }
        }

        // Substituir distâncias inalcançáveis por -1
        for (int i = 0; i < n; i++) {
            if (distances[i] == Integer.MAX_VALUE) {
                distances[i] = -1; // Se a distância ainda for "infinito", o nó é inalcançável
            }
        }

        // 5. Retornar o array de distâncias
        return distances;
    }
}


            


        