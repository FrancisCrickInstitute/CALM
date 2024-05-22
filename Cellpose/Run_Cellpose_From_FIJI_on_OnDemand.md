# How to install Cellpose on OnDemand and run it from FIJI

[Cellpose](https://github.com/MouseLand/cellpose) is a general model for cell and nuclear segmentation. Essentially a Python package, it is possible to run it from within FIJI by following these instructions. It is assumed that you have already set up FIJI to run on OnDemand - if not, see [here](https://github.com/FrancisCrickInstitute/CALM/blob/master/Fiji/readme.md).

## Step 1: Set up Cellpose

1. When your OnDemand Desktop session starts, right click and select `xterm` to open a terminal:

    ![image](https://github.com/FrancisCrickInstitute/CALM/assets/31737822/c541950a-7dab-4641-982e-b657eb4e530c)

2. You need to set up a [conda](https://en.wikipedia.org/wiki/Conda_(package_manager)) environment, which will contain your Cellpose installation. To do this, you first need to load [Anaconda](https://en.wikipedia.org/wiki/Anaconda_(Python_distribution)). Tyoe the following in your terminal window and press `Enter`:

    ```shell
    ml Anaconda3
    ```
3. You then need to create the environment that will contain the Cellpose installation, using the following command:

    ```shell
     conda create --name cellpose-env
    ```
    In this example, the environment has been named `cellpose-env`, but you can all it whatever you want.

4. The terminal will produce output similar to the following, where `user_name` will be replaced with whatever your user name is:

   ```shell
   Retrieving notices: ...working... done
   Collecting package metadata (current_repodata.json): done
   Solving environment: done
    
   ## Package Plan ##
    
   environment location: /camp/home/user_name/.conda/envs/cellpose-env
   
   Proceed ([y]/n)?
   ```

   Press `y` and `Enter` to proceed.

5. Activate your new Cellpose environment with the following command:

    ```shell
    conda activate cellpose-env
    ```
6. At this point, it is important to note that you have merely created what is essentially an empty environment called `cellpose-env`. To actually install Cellpose within this environment, run the following:

    ```shell
    pip install cellpose
    ```
    The terminal will produce a large amount of output as the necessary packages are installed.
7. To test whether the installation was succesful, run the following:

    ```shell
    cellpose --help
    ```
    If the installation was sucessful, this should produce a list of all the parameters that can be used when running Cellpose.
8. You can now deactivate your Cellpose environment by running the following:

    ```shell
    conda deactivate
    ```

> More detailed information on installing Cellpose can be found [here](https://github.com/MouseLand/cellpose?tab=readme-ov-file#installation) if needed.

## Step 2: Install the FIJI - Cellpose Wrapper:

This part should be relatively straightforward. Instructions for installing the Plugin allowing Cellpose to be run from FIJI can be found [here](https://github.com/BIOP/ijl-utilities-wrappers?tab=readme-ov-file#ib-fiji---cellpose-wrapper).
