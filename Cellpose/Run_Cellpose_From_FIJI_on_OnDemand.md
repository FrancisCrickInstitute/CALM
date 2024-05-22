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

> More detailed information on installing Cellpose can be found [here](https://github.com/MouseLand/cellpose?tab=readme-ov-file#installation) if needed.
