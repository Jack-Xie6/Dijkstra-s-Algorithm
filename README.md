# Dijkstra's-Algorithm

# A program to perform Dijkstra’s algorithm on Matlab.
Considering 400 points in the 2D plane, where the coordinate of each point is (𝑥, 𝑦) with 𝑥 = 1, 2, 3, … , 20 and 𝑦 = 1, 2, 3, … , 20. 
In other words, the coordinates of these 400 points are respectively listed as
(1,1), (1,2), (1,3), … , (1,20),
(2,1), (2,2), (2,3), … , (2,20),
            ......
(20,1), (20,2), (20,3), … (20,20).
Then, keep two points (1,1) and (20,20), and randomly remove 120 points from the other 398 points. One way to do this is as follows. 
First, you label these 398 points, e.g., the index of (1,2) is 1, that of (1,3) is 2, …, that of (20,19) is 398. 
Then, you use Matlab to randomly generate 120 different indices from 1 to 398, with the command“randperm”. 
Last, you remove the points corresponding to these 120 indices. 
Among these 280 remaining points, the distance between two points (𝑥1, 𝑦1) and (𝑥2, 𝑦2) is
