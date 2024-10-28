# Intro to HPC and StarDist

__Welcome to the course__

This course is run 2-3 times a year at the Francis Crick Institute with members of the Light Microscopy facility and the HPC team. 
The first half of the course is just intro to HPC. The aim of the course is to introduce users to the cluster computing resources at the Crick (our cluster is named "nemo"), and let them work independently on the cluster. The class is a pre-requiste for the Intro to Machine Learning course, but can be taken independently.  We run both classes on the same day, so the morning will be HPC, and in the afternoon, Machine Learning with StarDist. 

Quick glossary:
* Nemo: The computing cluster at the Crick. Both the storage and the cluster are called nemo (CALM didn't name them). We will try to refer to the cluster as nemo, and the storage as "nemo storage" but be aware that we may slip.

* OnDemand: This is the Graphical User Interface to Nemo Cluster computing. We can launch OnDemand sessions with a desktop (to run things like Fiji and Ilastik) or Jupyter notebooks, to run things like StarDist or CellPose.  To get access to OnDemand you need to talk to HPC (they respond best to slack).




__What's here__

In the _Presentations_ folder you will find powerpoints and pdfs of the presentations made during the Intro to HPC and Intro to Machine Learning with StarDist course.

__Setup_Scripts__ have the yml files needed to install StarDist and the other needed python packages on nemo. 

Running StarDist_bash_Sept24.sh shell script in the nemo teminal will install all the needed packages on nemo and link the kernel to the jupyter notebooks on nemo.

Running install_FIJI_w_download.sh will download the newest version of Fiji in your working directory, and make a link to it in your home directory, so that you need to just run the command "Run_FIJI.sh" to launch Fiji in Nemo OnDemand.
