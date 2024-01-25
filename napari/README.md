# napari

Napari is a Python-based n-dimensional viewer which allows the user to explore their data as well as overlay points, labels, tracks and vectors.
With the addition of plugins, users can do image analysis on their multidimensional data from within the napari GUI.

The napari website can be found [here](https://napari.org/stable/) with information on local installation and available plugins.

## napari on HPC OnDemand
These files will allow you to install napari on OnDemand with useful image analysis plugins already included.
You will then be able to visualise, analyse and quantify your data using HPC resources.

Please let us know if you come across any issues.

## Step 1: Download the files
The files you'll need for the installation and running of napari on OnDemand are `install_napari.sh` and `run_napari.sh`

## Step 2: Install napari
**FROM WITHIN ONDEMAND DESKTOP** open a terminal (right click > xterm) and navigate to the folder where the downloaded files are.
Run the commmand:
```
./install_napari.sh
```
You will know that the process has finished when `script completed` is printed in the terminal. This will install napari along with some useful plugins for image analysis.

## Step 3: Run napari
You can interact with napari in two ways: 
- OnDemand desktop
- Jupyter Notebooks

#### OnDemand desktop
Navigate to the folder where the downloaded files are.
Run the command:
```
./run_napari.sh
```
This will open a napari window from within OnDemand desktop. Navigate to this file and run this command whenever you want to interact with napari this way.

#### Jupyter Notebooks
Start a Jupyter Notebook job and open a new notebook.
Change the kernel (kernel > change kernel > napari-nemo-jan24).
Begin an instance of napari by copying this code into a cell and running it:
```python
import napari
viewer = napari.Viewer()
napari.run()
```
