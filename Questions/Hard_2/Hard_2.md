# 778. Swim in Rising Water

### Link Questão: [778. Swim in Rising Water](https://leetcode.com/problems/swim-in-rising-water/description/)

#### Nível: Difícil

#### Linguagem utilizada: Java

---

## Resultado Juiz Eletrônico (LeetCode)

<center> 

![Resultado](../../assets/accepted_hard2.png)

![Resultado Detalhado](../../assets/details_hard2.png)

</center>

## Resumo

A questão aborda um problema de movimentação em um grid bidimensional 
n×n, onde cada célula possui um valor que representa a elevação do terreno naquele ponto. O objetivo é encontrar o menor tempo necessário para ir da célula superior esquerda (0,0)
até a célula inferior direita (n−1,n−1).
- O tempo 𝑡 é definido como a profundidade da água que cobre o terreno no momento.
- Você só pode se mover para uma célula adjacente (em até 4 direções) se a elevação daquela célula for menor ou igual ao tempo atual 
𝑡.
- O tempo necessário para acessar uma célula é determinado pelo maior valor de elevação encontrado no caminho percorrido até ela.

O desafio é calcular o menor tempo 𝑡 necessário para percorrer do início ao fim do grid, considerando as restrições de elevação e movimentação.

## Solução

### Arquivo: [778.Swim_in_Rising_Water.java](./778.Swim_in_Rising_Water.java)

### Código em Java:

```java

package Questions.Hard_2;

import java.util.PriorityQueue;

class Solution {
    public int swimInWater(int[][] grid) {
        int n = grid.length;  
        
        // Priority Queue para armazenar [tempo, x, y], ordenada pelo menor tempo
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> Integer.compare(a[0], b[0]));
        
        // Matriz de visitados 
        boolean[][] visited = new boolean[n][n];
        
        // Adiciona a célula inicial (0, 0) na fila com o tempo inicial sendo o valor do grid[0][0]
        pq.offer(new int[] { grid[0][0], 0, 0 });
        visited[0][0] = true;

        // Direções para movimentação: [cima, baixo, esquerda, direita]
        int[][] directions = { {0, 1}, {1, 0}, {0, -1}, {-1, 0} };

        while (!pq.isEmpty()) {
            // Remove a célula com o menor tempo atual
            int[] current = pq.poll();
            int time = current[0]; // Tempo necessário para chegar a essa célula
            int x = current[1];    // Coordenada x da célula
            int y = current[2];    // Coordenada y da célula

            // Se chegamos no destino (n-1, n-1), retorna o tempo acumulado
            if (x == n - 1 && y == n - 1) {
                return time;
            }

            // Explora as células adjacentes (4 direções)
            for (int[] dir : directions) {
                int nx = x + dir[0];  // Nova coordenada x
                int ny = y + dir[1];  // Nova coordenada y

                // Verifica se a nova célula está dentro do grid e ainda não foi visitada
                if (nx >= 0 && ny >= 0 && nx < n && ny < n && !visited[nx][ny]) {
                    visited[nx][ny] = true;  // Marca como visitada.

                    // Calcula o tempo necessário para entrar na célula adjacente
                    // É o maior valor entre o tempo atual e a elevação da célula adjacente
                    pq.offer(new int[] { Math.max(time, grid[nx][ny]), nx, ny });
                }
            }
        }

        return -1;  // Este ponto nunca será alcançado, pois o grid é garantido como navegável
    }
}

```