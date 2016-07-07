inputdir = getArgument();
print(">>>>>> Testing dataset at" + inputdir);
numberfiles = 5;
startfile = 1;
filename = "numberedSlices"; //for other folders, change here --- future: we will parse getArgument() using command split()

//print("start:",imageSubset_first);
run("Image Sequence...", "open=["+inputdir+"] number="+numberfiles+" starting="+startfile+" increment=1 scale=100 file="+filename+" or=[] convert sort");

//open("/Users/dani/Dropbox/prog/Python/runExternal/temp.tif");
run("Add Specified Noise...", "stack standard=20");
run("Smooth", "stack");
setOption("BlackBackground", true);
run("Auto Threshold", "method=Otsu white stack");
saveAs("Tiff", inputdir+"segmentation.tif");
//eval("script", "System.exit(0);");

//how to call it directly on terminal "/Users/dani/Desktop/Fiji.app.jan26.app/Contents/MacOS/ImageJ-macosx" --headless -macro Macro.ijm
