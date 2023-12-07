# CellProfiler 
CellProfiler is widely used here at the Crick to do segementation and quantification of images, without a lot of image analysis background. The documentation for CellProfiler can be found at the [CellProfiler Wiki](https://github.com/CellProfiler/CellProfiler/wiki).

## CellProfiler on HPC OnDemand
We're beginning to experiementally support a GUI version of Cellprofiler on HPC OnDemand. This is very much a work in progress, but please feel free to beta test and tell us how it is working.

### Requirements:
HPC OnDemand account (Contact HPC on the #HPC Slack Channel) to get your account set up.

You may find it useful to have your .conda and .cache home directories soft-linked to your working directory.

A bit of linux/command line experience would help for now. We're hoping to make it easier
### Files:
There are three files that are used for installation and running. You can download them from The CALM Github Page for [CellProfiler](https://github.com/FrancisCrickInstitute/CALM/tree/master/CellProfiler).

install_cellprofiler.sh

run_cellprofiler.sh

Download_CellProfiler_Plugins.sh



### To install :
ALL OF THIS NEEDS TO BE DONE IN ONDEMAND

Navigate to the folder where you downloaded the files.

Run the command "./install_cellprofiler.sh"

This will take between 5-10 minutes, depending on how many resources you asked for. 

If all goes well, CellProfiler will download and be installed in a new mamba/conda environment. This should be reported by the install file at the end of the process

### To Run: 
In the directory in which you downloaded the run_cellprofiler.sh file, run the command

"./run_cellprofiler.sh"   without the quotes

### To Download and use plugins:
Make a directory to store the plugins in your working directory.  The plugins are small python scripts, you do not need a lot of room.

In the directory where you downloaded the Download_CellProfiler_Plugins.sh run the command

"./Download_CellProfiler_Plugins.sh /path/to/your/folder"      without the quotes, Where /path/to/your/folder is replaced by the path to the folder you made for the plugins

Open CellProfiler again using "./run_cellprofiler.sh"

Under "File" --> "Preferences" --> set the "CellProfiler plugins directory" to your plugins directory.


