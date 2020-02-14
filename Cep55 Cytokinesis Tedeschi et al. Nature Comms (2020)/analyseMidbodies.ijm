/*
 * Analyse ESCRT recruitment to the midbody
 * 
 * Matt Renshaw, Dec 2019, CALM-STP, The Francis Crick Institute
 * 
 * Analysis script to quantify recruitment of a protein to the central midbody region.
 * Works on maximum projection cropped images that have been pre-selected to contain a single intracellular bridge.
 * Central midbody area is identified using a suitable marker (e.g. MKLP1) and Otsu cluster auto-thresholding method; found area is then dilated to include neighbouring area.
 * The intracellular bridge is located by combining the MKLP1 and microtubule channels (after intensity normalisation) and the ICB is defined by Otsu's auto-thresholding method.
 * Outer ICB regions are then created by subtracting the central area from the ICB.
 * 
 * Intensity measurements are made for the ESCRT channel, using the central MB ROI and then the outer ICB regions.
 * Table generated includes the ratio of the mean intensity of the central MB area / mean intensity of all of the found outer ICB areas.
 * 
 * Batch processing, processes all ".tif" files in a folder, saves image with ROI overlays.
 * Result table is not saved automatically.
 * 
 */

 ///////////////////////////////////////////////////////////
 //define variables
	
	
	
	ch1 = 4; // channel # for midbody marker (eg MKLP1)
	ch2 = 3; // channel # for microtubules
	ch3 = 2; // channel # to be analysed eg ESCRT protein

/////////////////////////////////////////////////////////////
dir1 = getDirectory("Choose a parent directory ");
dir2 = getDirectory("Choose a output directory ");

processFolder(dir1, dir2)


//////////////////////////////////////////////


	function processFolder(inputDir, outputDir) {
		/*
		 * recursively looks through sub-directories to find files
		 * file and output directory sent to processFile function
		 */
		list = getFileList(inputDir);
   		for (i=0; i<list.length; i++) {
   			
        	if (endsWith(list[i], ".tif")) {


analyseMidbodies(inputDir+list[i], ch1, ch2, ch3, outputDir);




        	}

     	}
	}



	
	/////////////////////////////////////////////////////////////
function analyseMidbodies(image, ch1, ch2, ch3, output) {
		/*
		 * Select window containing 
		 */
								
setBatchMode(true);

open(image);
		 
				roiManager("reset");
			
				// select MB image
				title = getTitle();
				
	
					
					/*
					 * analyse midbodies
					 */

					  // extract 
					  run("Duplicate...", "title=MB duplicate");
					  run("Split Channels");

					   
		// define MB / central region
					   

					   selectWindow("C"+toString(ch1)+"-MB");

					   //normalise
					   getRawStatistics(nPixels, mean, min, max, std, histogram);
					   run("Subtract...", "value="+toString(min)+" stack"); // note: images are normalised to the minimum value of the maximum projection, to help set all background to 0.
					   run("32-bit");
					   getRawStatistics(nPixels, mean, min, max, std, histogram);
					   run("Divide...", "value="+toString(max)+" stack");
					   setMinAndMax(0, 1);

					   run("Duplicate...", "title=centre duplicate");
					   setAutoThreshold("Otsu dark");
					   run("Convert to Mask");
					   run("Options...", "iterations=4 count=1 do=Dilate"); // dilation to include neightbouring areas: proteins not necessariliy colocalise with MKLP1

					   
	 	 // define ICB / outer regions
					   

					    selectWindow("C"+toString(ch2)+"-MB");

					    // normalise
					    getRawStatistics(nPixels, mean, min, max, std, histogram);
					    run("Subtract...", "value="+toString(min)+" stack"); // note: images are normalised to the minimum value of the maximum projection, to help set all background to 0.
					    run("32-bit");
					    getRawStatistics(nPixels, mean, min, max, std, histogram);
					    run("Divide...", "value="+toString(max)+" stack");
					    setMinAndMax(0, 1);

					    //merge central and outer regions to include whole area
					    run("Merge Channels...", "c1=C"+toString(ch1)+"-MB c2=C"+toString(ch2)+"-MB create");
					    run("Hyperstack to Stack");
					    run("Z Project...", "projection=[Max Intensity]");
					    setAutoThreshold("Otsu dark");
					    run("Convert to Mask");
					    rename("ICB");

					    imageCalculator("AND create", "centre","ICB"); // "Result of centre" : binary image of central area to be measured
					    imageCalculator("Subtract create", "ICB","centre"); // "Result of ICB" : binary image of outer areas to be measured


						/*
						 * Measure intensities at found areas
						 */

						 selectWindow("C"+toString(ch3)+"-MB");
						 rename(title+"_C"+toString(ch3));
						 a = getTitle();

						 	// subtract minimum intensity value from original stack as background
						 	getRawStatistics(nPixels, mean, min, max, std, histogram);
						 	run("Subtract...", "value="+toString(min));

						 	close("Results");

						 	run("Set Measurements...", "area mean standard min integrated display redirect="+a+" decimal=3");
						 	selectWindow("Result of centre");
						 	run("Analyze Particles...", "size=10-infinity pixel circularity=0-1 display add");
						 	selectWindow("Result of ICB");
						 	run("Analyze Particles...", "size=10-Infinity pixel circularity=0-1 display add");
						 	print("nResults", nResults);

						 	

						 	 /*
						 	  * Add results to table
						 	  

						 	  if (nResults > 1) {

						 	  	filename = replace(titleMB, ".ome.tif", "")+".csv";

						 	  	//print(outputDir);
						 	  	outputPath = output+filename;
						 	  	print(outputPath);
						 	  	selectWindow("Results");
						 	  	saveAs("Results", outputPath);
						 	  	close();
						 	  	
						 	  	
						 	  }
						 	  */
						 	 //close("Results");
							 close("Composite");
						 	 close("ICB");
						 	 close("centre");
						 	 close("C1-MB");
						 	 close("C2-MB");
						 	 					 	  
						 	  /*
						 	 * add overlay to midbody image as output
						 	 */

						 	 selectWindow(title);

						 	 
//Table.create("recruitment analysis");
						 	 						 	  if (nResults > 1 && nResults < 5) {

						 	  	//selectWindow("recruitment analysis");

						 	  	if(isOpen("recruitment analysis")){
						 	  		selectWindow("recruitment analysis");						 	  		
						 	  	}
						 	  	else {
						 	  		Table.create("recruitment analysis");
						 	  		selectWindow("recruitment analysis");
						 	  	}
						 	  	//Table.update("recruitment analysis");
						 	  	row = Table.size("recruitment analysis");
						 	  	Table.set("Filename",row,title);
						 	  	meanMB = getResult("Mean", 0);
						 	  	
						 	  	intDen = newArray(nResults-1);
						 	  	area = newArray(nResults-1);
						 	  	for (i =0; i < nResults-1; i++) {
						 	  		intDen[i] = getResult("IntDen", i+1);
						 	  		area[i] = getResult("Area", i+1);
						 	  	}
						 	  	Array.getStatistics(intDen, min, max, meanInt, std);
						 	  	Array.getStatistics(area, min, max, meanArea, std);
						 	  	meanICB = (meanInt * (nResults-1))/(meanArea * (nResults-1));

						 	  	
						 	  	Table.set("Ratio", row, meanMB/meanICB);
						 	  	Table.set("MB 4B mean", row, meanMB);
						 	  	Table.set("MB 4B area", row, getResult("Area", 0));
						 	  	Table.set("MB 4B StdDev", row, getResult("StdDev", 0));
						 	  	Table.set("ICB 4B mean", row, meanICB);

						 	  	for (i = 1; i < nResults; i++) {
				 	  		
						 	  	Table.set("ICB-"+i+" 4B mean", row, getResult("Mean", i));
						 	  	Table.set("ICB-"+i+" 4B area", row, getResult("Area", i));
						 	  	Table.set("ICB-"+i+" 4B StdDev", row, getResult("StdDev", i));
						 	  	Table.update("recruitment analysis");
						 	  	}
						 	  	
						 	  	
						 	  }

						 	  if (roiManager("count")>1 && nResults < 5) {
						 	 	
						 	 	run("From ROI Manager");
						 	 	run("Overlay Options...", "stroke=yellow width=1 fill=none show");
						 	 

						 	 	outputPath = output+title;
						 	  	print(outputPath);
						 	  	//selectWindow("Results");
						 	  	saveAs("tiff", outputPath);


						 	 }
						 
						 	 



						 	  
						 	 
							
			
		

		setBatchMode(false);

		}
		
	