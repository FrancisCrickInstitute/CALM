#### Installing QuPath on HPC the "easy way"

#### Installing QuPath in your working directory 
* Download QuPath for Linux and put it in your working directory on nemo. It will have a file extension of .tar.xz
* Open up an OnDemand GPU Desktop. For instructions on how to do this, see [this documentation].
* Open up a terminal in OnDemand (right click anywhere on the screen and open up xterm)
* Navigate to the folder on Nemo in which you put the QuPath installation file (this is __/path/to/QuPath__)
* use the command __tar -xf QuPath-******.tar.xz__ Where the ***** represents the version of QuPath
* use the command __chomd u+x /path/to/QuPath/bin/QuPath__ to change the permissions of the launcher
* Navigate to the folder /path/to/QuPath/bin/ and type in __./QuPath__ to run QuPath
