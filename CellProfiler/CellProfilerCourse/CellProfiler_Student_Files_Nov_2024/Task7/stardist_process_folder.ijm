/*
 * Quick and easy script for making stardist files from a set of images in a folder.  Change the Prefix to whatever channel is your images you want to use stardist on
 * Todd Fallesen, June 2021, CALM Facility, Francis Crick Insititute. 
 */

#@ File (label = "Input directory", style = "directory") input
#@ String (label = "File suffix", value = ".tif") suffix
#@ String (label = "Channel Name (case sensative)", value = "C1") prefix

// See also Process_Folder.py for a version of this code
// in the Python scripting language.

processFolder(input);

// function to scan folders/subfolders/files to find files with correct suffix
function processFolder(input) {
	list = getFileList(input);
	list = Array.sort(list);
	for (i = 0; i < list.length; i++) {
		if(File.isDirectory(input + File.separator + list[i]))
			processFolder(input + File.separator + list[i]);
		if(startsWith(list[i], prefix) && endsWith(list[i], suffix))
			processFile(input, list[i]);
	}
}


function processFile(input, file) {
	// Do the processing here by adding your own code.
	// Leave the print statements until things work, then remove them.
	open(input+file);
	run("Command From Macro", "command=[de.csbdresden.stardist.StarDist2D], args=['input':"+file+", 'modelChoice':'Versatile (fluorescent nuclei)', 'normalizeInput':'true', 'percentileBottom':'1.0', 'percentileTop':'99.8', 'probThresh':'0.5', 'nmsThresh':'0.5', 'outputType':'Both', 'nTiles':'1', 'excludeBoundary':'2', 'roiPosition':'Automatic', 'verbose':'false', 'showCsbdeepProgress':'false', 'showProbAndDist':'false'], process=[false]");
	output_dir = File.getParent(input) + File.separator + "stardist";
	output_file = output_dir + File.separator + "stardist_" + file;
	if (File.isDirectory(output_dir) == 0)
		File.makeDirectory(output_dir);
	selectWindow("Label Image");
	save(output_file);
	close("*");
	//print("Processing: " + input + File.separator + file);
	//print("Saving to: " + output);
}
