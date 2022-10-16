# P4P - The Perception of Biological Motion (2022)
Part IV Project - Joseph Byrne, Alan Chen

## Overview of the Work Done 

### Data Capture

All point light walker data was captured at the University of Auckland's motion capture lab on level 8 (Department of Mechanical Engineering). The following configuration was used for node placement on the point light walker (28 nodes):

![alt text](/Images/suit.png)

(Note: future researchers may opt for different configurations based on their requirements)

A treadmill was then placed near the centre of the motion capture space. The subject walked at moderate speed (1.5 m/s) at level 4 setting for 60 seconds and his gait was captured by the Vicon Nexus system installed in the lab. Please ask, Emanuele Romano (or other technician) for induction into the motion capture lab and additional assistance with the motion capture technology used for this project.

<p float="left">
  <img src="/Images/mocaplab.jpg" width="500" />
  <img src="/Images/vicondisplays.jpg" width="500" /> 
</p>

The trajectory data for all captured nodes are then stored within the Vicon Nexus software. This can be exported to several different softwares (MATLAB, Python, etc.). For the purposes of our project, we used [MATLAB](https://au.mathworks.com/products/connections/product_detail/vicon-nexus.html).

### Data Processing in MATLAB 

All software used for data processing in this repository is fully commented. These scripts provide all the functionality for extracting data to data analysis of the trial experiments. The repository has been organised in the following structure:

![alt text](/Images/structure.jpg)

### Experiment Procedure 

Experiments were conducted in the brain computer interface (BCI) lab, also on level 8 at the University of Auckland. The environment was set up as follows:

![alt text](/Images/bcidisplays.jpg)





