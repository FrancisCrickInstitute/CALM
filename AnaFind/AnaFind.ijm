/*
 * Find anaphase cells in DAPI image (single slice, 10x objective)
 * uses DoG and RenyiEntropy auto threshold to identify brighter objects/mitotic cells
 * anaphase cells are then selected by their proximity to other found objects
 * 
 * outputs list of centroids for use in MicroManager intelligent acqusition
 * 
 * Update for this version - expects exploration image with 2 channels, but will only analyse channel 1 (DAPI), second/other additional channels to be used for later validation of the script.
 * 
 * Matt Renshaw
 * CALM-STP, Francis Crick Institute
 * May 2018
 */

 setBatchMode(true);


/*
 * assign variables
 */

 nDilate = 9; // number of dilations to connect close objects (8 iterations is maximum ~10um apart)
 minArea = 200; // minimum area for anaphase cells, needs to factor in nDilate; for nDilate = 8, individual object area ~100um^2
 maxArea = 400; // maximum area for anaphase cells, needs to factor in nDilate as above. Too large and centroid position is meaningless/too small and will exclude multi-polar spindles.

 run("Clear Results");
 roiManager("reset");
 run("Select None");
// run("Duplicate...", " ");
 run("Duplicate...", "title=image duplicate channels=1"); // duplicate DAPI channel
 rename("image");

/*
 * initial image processing
 */

 run("Subtract Background...", "rolling=50 sliding"); //subtract background

/*
 * normalise image between min and max
 */

 getRawStatistics(nPixels, mean, min, max, std, histogram);
 run("Subtract...", "value="+toString(min));
 run("32-bit");
 getRawStatistics(nPixels, mean, min, max, std, histogram);
 run("Divide...", "value="+toString(max));
 setMinAndMax(0, 1);

/*
 * difference of gaussian
 */
 
 selectWindow("image");
 run("Duplicate...", "title=gaussian");
 run("Gaussian Blur...", "sigma=3");

 selectWindow("image");
 run("Duplicate...", "title=DoG");
 run("Gaussian Blur...", "sigma=1");

 imageCalculator("Subtract", "DoG","gaussian");
 selectWindow("gaussian");
 close();

/*
 * auto threshold
 */

 selectWindow("DoG");
 
 run("Median...", "radius=2");
 run("Maximum...", "radius=1"); 
 
 setAutoThreshold("RenyiEntropy dark");
 setOption("BlackBackground", false);
 run("Convert to Mask");
 
//dilation/Erosion to merge very close objectsv
run("Options...", "iterations=1 count=1 do=Dilate");
//run("Options...", "iterations=3 count=1 do=Erode");

 run("Set Measurements...", "area mean standard modal min centroid shape display redirect=image decimal=3");
 run("Analyze Particles...", "size=38-150 circularity=0.4-0.98 show=Masks display exclude clear summarize add"); // excludes objects based on size and circularity

/*
 * Select anaphase cells
 */

 selectWindow("Mask of DoG");
 run("Duplicate...", "title=anaphase");
 run("Skeletonize");
 run("Ultimate Points");
 setThreshold(1, 255);
 run("Convert to Mask");
 run("Options...", "iterations="+toString(nDilate)+" count=1 edm=Overwrite");
 run("Dilate");

 run("Set Measurements...", "centroid redirect=None decimal=2");
 run("Analyze Particles...", "size="+toString(minArea)+"-"+toString(maxArea)+" show=Outlines display clear add");
 close("anaphase");

  // check DoG image 
 selectWindow("DoG");
 getRawStatistics(nPixels, mean, min, max, std, histogram);
 print(std);
 if (std > 80){
	run("Clear Results");
	selectWindow("Drawing of anaphase");
	run("Add...", "value=255"); // resets "Drawing of anaphase" image to blank
 }

/*
 * generate exploration image with outlines
 */

 selectWindow("image");
 run("8-bit");
 selectWindow("Drawing of anaphase");
 run("Invert");
 run("Merge Channels...", "c4=image c7=[Drawing of anaphase] create keep ignore");
 run("RGB Color");
 rename("image (RGB)");

 o = isOpen("Explore");
 if(o) {
 	run("Concatenate...", "  title=[Explore] image1=Explore image2=[image (RGB)] image3=[-- None --]"); // concatenate exploration images
 }
 else {
 	rename("Explore");
 }

 selectWindow("Explore");
 n = nSlices();
 setSlice(n); // display most recent exploration image

 setBatchMode(false); 