# Ilastik
You can download Ilastik [here](https://www.ilastik.org/). 

Ilastik is a pixel based classifier, that works in both 2D and 3D. It is very powerful at segmentation by color, intensity, texture and other pixel based parameters. 
To use it, you "simply" paint with your mouse cursor the background of your image, as well as representative regions that you are trying to segment. 
This is done iteratively to create a good pixel classifier that can be run on many images, either through Ilastik or imported into your FIJI or CellProfiler pipelines.  
We support Ilastik on some of our [Image Analysis Workstations](https://github.com/FrancisCrickInstitute/CALM/wiki/Workstations) and on the Nemo Compute Cluster (HPC). 


## Using Ilastik on Nemo OnDemand (HPC)
HPC Helpfully supports a pre-installed version of Ilastik on nemo, that you can use on Nemo Compute or OnDemand.

### To use Ilastik on OnDemand:

1.) Spin up a GPU version of OnDemand Desktop. Please be considerate when choosing resources, and don't choose more than you need, but do choose enough to accomplish your task in a timely manner.

2.) At the OnDemand desktop, right click anywhere on the screen to bring up a menu, and then launch "xterm"

3.) Type in the following commands to load VirtualGL and Ilastik

      ml VirtualGL

      ml ilastik/1.4.0.post1-gpu

      cd /camp/apps/eb/software/ilastik/1.4.0.post1-gpu/

      ./run_ilastik.sh


You can also download [this file](https://github.com/FrancisCrickInstitute/CALM/blob/master/Ilastik/ilastik.sh), which is a short batch script that does the above commands. You can save it to your home directory and then type 

      ./ilastik.sh

To load ilastik, as opposed to the above commands. 

## Using your own version of Ilastik on HPC
You can also download and use your own version of Ilastik on HPC. To do so, download the linux version of Ilastik into your working directorry, and follow [these instructions](https://www.ilastik.org/documentation/basics/installation).


