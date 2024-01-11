#### Installing FIJI on HPC the "easy way"
* Download [install_FIJI_w_download.sh](https://github.com/FrancisCrickInstitute/CALM/blob/master/Fiji/install_FIJI_w_download.sh) into a folder in your nemo space to which you want to install FIJI
* Open up an OnDemand GPU Desktop. For instructions on how to do this, see [this documentation].
* Open up a terminal in OnDemand (right click anywhere on the screen and open up xterm)
* Navigate to the folder on Nemo in which you put **install_FIJI_w_download.sh**
* Run ./install_FIJI_w_download.sh   -- This will install the program, and create a new run script in your top level home directory
* Start a new xterm (or type in cd $HOME)
* type in **./Run_Fiji.sh**

* At anypoint you want to run QuPath, you can run the script **./Run_Fiji.sh** from your home directory (the first directory that opens when you start xterm)

