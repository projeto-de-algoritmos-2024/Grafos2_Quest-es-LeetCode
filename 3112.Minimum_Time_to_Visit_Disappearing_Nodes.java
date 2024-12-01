import java.util.*; 
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
    

        