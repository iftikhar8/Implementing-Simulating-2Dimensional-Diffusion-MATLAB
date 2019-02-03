# Implementing-Simulating-2Dimensional-Diffusion-MATLAB (2017)
Simulating 2 Dimensional temperature distribution on a plate using the finite volume method to discretize the diffusion equation and Gauss-Seidel iterative method for solving the systems equations.

results video animation (https://youtu.be/bFFg4KAUqos)

![alt text](https://github.com/Attaras/Implementing-Simulating-2Dimensional-Diffusion-MATLAB/blob/master/CFD%20gif.gif?raw=true)

## Introduction
The Diffusion equation is a Partial Differential Equation that describes the phenomena of diffusion, The Diffusion Equation is a general equation, and in the simplest form, it can be stated simply as the following:

The change in a specific property with respect to time is proportional to the change of the same property with respect to space with the proportionality constant being the Diffusion Constant.

The diffusion equation’s generality comes from the sense that it is applicable to various types of diffusions, one of its most used applications is heat diffusion, and in this case it’s well known as the heat equation.

![alt text](https://raw.githubusercontent.com/Attaras/Implementing-Simulating-2Dimensional-Diffusion-MATLAB/master/diffusion%20equation.png)

We discretize the Diffusion Equation above using the Finite Volume Method, this is achieved by first Integrating the general equation over the volume we’re working on, in this case a 3 dimensional plate with thickness dz, for simplicity we assume unit thickness.

Skipping through the steps we get this equation:

![alt text](https://raw.githubusercontent.com/Attaras/Implementing-Simulating-2Dimensional-Diffusion-MATLAB/master/final%20equation.png)


## Results

The plate was heated from the north by a source with 30°C temperature, from the south by a source with 10°C, from the west by a source with 60° temperature, and it was insulated from the eastern side.

4 Meshes were experimented on, 50x50, 100x100, 250x250, and 1000x1000, the more nodes we put in the mesh the long the time it took for the simulation to finish, and because the mesh was square, the time increased polynomially, the 1000x1000 mesh took 5 hours to complete on a core i3 processor.

Resulting Temperature distribution at equilibrium:

![alt text](https://raw.githubusercontent.com/Attaras/Implementing-Simulating-2Dimensional-Diffusion-MATLAB/master/temp_profile.png)

## Comparison of the temperature profiles taken from a central horizontal line from the three meshes(50,100,250)

![alt text](https://raw.githubusercontent.com/Attaras/Implementing-Simulating-2Dimensional-Diffusion-MATLAB/master/Comparison%20of%20different%20meshs%20error%200.001.png)

## Simulation Time and Minimum Temperature for each mesh

![alt text](https://raw.githubusercontent.com/Attaras/Implementing-Simulating-2Dimensional-Diffusion-MATLAB/master/Simulation%20Time%20and%20Min%20Temp%20Comparison.png)
