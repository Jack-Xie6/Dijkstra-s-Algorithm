# Dijkstra's-Algorithm

Dijkstra's algorithm (/ˈdaɪkstrəz/ DYKE-strəz) is an algorithm for finding the shortest paths between nodes in a weighted graph, which may represent, for example, a road network. It was conceived by computer scientist Edsger W. Dijkstra in 1956 and published three years later. -- From wikipedia  

## Reproduction  

### A program to perform Dijkstra’s algorithm on Matlab.  

### 1.1 
Considering 400 points in the 2D plane, where the coordinate of each point is (𝑥, 𝑦) with 𝑥 = 1, 2, 3, … , 20 and 𝑦 = 1, 2, 3, … , 20.  
In other words, the coordinates of these 400 points are respectively listed as  
                       (1,1), (1,2), (1,3), … , (1,20),  
                       (2,1), (2,2), (2,3), … , (2,20),  
                                   ......  
                       (20,1), (20,2), (20,3), … (20,20).  
                       
### 1.2
Keep two points (1,1) and (20,20), and randomly remove some points from the other 398 points. (In this code,we randomly removed 250 points).  

### 1.3
Label these 398 points, e.g., the index of (1,2) is 1, that of (1,3) is 2, …, that of (20,19) is 398. Then, use Matlab to randomly generate 250 different indices from 1 to 398, with the command“randperm”.  Last,  remove the points corresponding to these 120 indices.  Among these 280 remaining points, the distance between two points (x₁, y₁) and (x₂, y₂) is: sqrt((x₁ - x₂)^2 + (y₁ - y₂)^2)

## Building the graph.  

Build a graph 𝐺 = (𝑁, 𝐸) on Matlab based on the following requirements.  

### 1.1 
In this graph, the set of nodes 𝑁 consists of all the remaining 150 points.  
### 1.2 
For any two nodes (𝑥1, 𝑦1) and (𝑥2, 𝑦2) on this graph, there is an edge to connect them if and only if ‖𝑥1 − 𝑥2‖ ≤ 1 and ‖𝑦1 − 𝑦2‖ ≤ 1. For example, the node (2,2)
is only connected to (1,1), (1,2), (1,3), (2,1), (2,3), (3,1), (3,2), and (3,3), if all the above nodes are among the 280 remaining points.  
### 1.3 
If there is an edge to connect two nodes (𝑥1, 𝑦1) and (𝑥2, 𝑦2) on this graph, the cost associated with this edge is the distance between these two nodes, i.e., sqrt((x₁ - x₂)^2 + (y₁ - y₂)^2)  

| ![image](https://github.com/user-attachments/assets/ac1e7548-3381-44d4-8e2a-d5de207efd2f)| 
|:--:| 
| ***Figure1**: Display* |


