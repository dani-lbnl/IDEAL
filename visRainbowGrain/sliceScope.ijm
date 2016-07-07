/*
 * Creating paper quality grphs for the CMC samples from Natalie Carlson
 * Algorithm: Detect fiber profiles
 * INPUT: select a binary slice representation of a specimen
 * OUTPUT: separate fibers with watershed, color, and show magnified patches

Symbols:
 
----------------
 Modified: June 28 2016
 Dani Ushizima 
----------------
*/

macro "Slice_Scope" {
	//run("Close All");
	
	outputdir = "~/Desktop/";
	filename = getTitle();
	rename("bw");
	run("Watershed");
	run("Fill Holes");
	npoints = 18; // pi*fiber_radius^2 - 2
	run("Find Connected Regions", "allow_diagonal display_one_image display_results regions_for_values_over=254 minimum_number_of_points="+npoints+" stop_after=-1");
	rename("Original");
	selectWindow("bw"); close;
	heading = 'Points In Region';
	arrayResult = newArray(nResults);
	for (row=0; row<nResults; row++) { 
	        arrayResult[row] = getResult(heading,row); 
	     //print(arrayResult[row]); 
	}
	Array.getStatistics(arrayResult, min, max, mean, std); 
	
	run("Scale Bar...", "width=20 height=5 font=35 color=Yellow background=None location=[Lower Right] bold");
	run("RGB Color");
	w=getWidth();
	h=getHeight();
	dw=round(w/15);
	dh=round(h/15);
	setForegroundColor(255,255,255);
	
	setFont("SansSerif", 35, "bold");
	drawString("Nparticles="+nResults+", Area: mean="+d2s(mean,2)+",std="+d2s(std,2), round(w*0.4), (h-10))
	
	setLineWidth(3); 
	scale = 4;
	w2=scale*dw;
	h2=scale*dh;
	
	//parameters to crop the original figure
	aW=newArray(4,6,11);
	aH=newArray(6,10,8);
	
	//parameters for the new figure
	aW2=newArray(2,2,w-w2);
	aH2=newArray(2,h-h2,2);
	
	for(i=0;i<3;i++){
		selectWindow('Original');
		run("Select None");
		setForegroundColor(255,255,255);
		setLineWidth(5); //line width here
		x=aW[i]*dw; 
		y=aH[i]*dh;
		drawRect(x, y, dw, dh); 
		makeRectangle(x, y, dw, dh);
		run("Duplicate...","title=patch");
		//print(x+", "+y);
		selectWindow("patch");
		run("Scale...", "x="+scale+" y="+scale+" width="+w2+" height="+h2+" interpolation=Bicubic average create title=[patch2]");
		selectWindow("Original");
		run("Add Image...", "image=patch2 x="+aW2[i]+" y="+aH2[i]+" opacity=100");	
		
		selectWindow("patch"); close();
		selectWindow("patch2"); close();
	}
	run("Flatten"); rename("Result");
	run("Select None");	
	selectWindow("Result");
	saveAs("Tiff", outputdir+"paper_"+filename);	
	wait(100);
	run("Close All");
}