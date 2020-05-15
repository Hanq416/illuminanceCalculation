# illuminanceCalculation
#### Retrieve illuminance from Radiance HDR image with region of interest (ROI) lux selection

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 

See the GNU General Public License for more details. 
You should have received a copy of the GNU General Public License 
along with this program.  If not, see https://www.gnu.org/licenses/.

*	Version: 1.0.1
*	Updated: 05/13/2020	
*	Authors: Hankun Li, Hongyi Cai, Siqi He
*	University of Kansas	

*	Questions about program? Contact: hankunli@ku.edu 
*	Lighting variables' questions? Contact: hycai@ku.edu 

----------------------------------------------------------------------------------------------------------------------
### This program is to calculate the illuminance from the High Dynamic Range image (.hdr) taken by circular fisheye lens.

To learn how to take a 'Good' HDR image for lighting measurement purpose and use it as the input of this program, http://people.ku.edu/~h717c996/publication.html

----------------------------------------------------------------------------------------------------------------------
## System Requriement:
 
#### Windows 7 or above, MacOS 10.10 or above.

#### MATLAB release 2018b, 2019a are recommended; Add-on Imgage Processing Toolbox required.

#### This program has been tested on a computer Intel i5 2.9GHZ with 8GB RAM.

-----------------------------------------------------------------------------------------------------------------------
## REFERENCE:

[1]Modern Optical Engineering, Warren J. Smith, McGraw-Hill, p.228-230

[2]ISO 2720:1974. General Purpose Photographic Exposure Meters(Photoelectric Type),
Guide to Product Specification.International Organization for Standardization.

[3]Masket,A.Victor(1957)."Solid angle contour integrals,series and tables"Rev.Sci.Instrum.28(3).doi:10.1063/1.1746479.

[4]Greg Ward, Radiance File Formats, Radiace reference, Lawrence Berkerly Lab, 2011. https://floyd.lbl.gov/radiance/refer/

-----------------------------------------------------------------------------------------------------------------------

## Input

[1] HDR image (.hdr) or luminance map output from Radiance (.txt).

[2] Fisheye projection selection: equisolid/equidistant (will support more projection in later update).

[3] HDR image must be taken by fisheye lens with supported projection above to calculate illuminance

[4] You CAN scale if input is image (.hdr); you MUST specify the resolution if input is luminance map(.txt).

-----------------------------------------------------------------------------------------------------------------------
## Output

[1] CV: Coefficient of variance. Evaluate uniformity of lighting environment of your input.

[2] lux-uniform: illuminance of image taken in very uniform lighting environment.

[3] lux-perpixel: illuminance value calculated by using per-pixel method.

[4] ROI(region of interest): if you want to know how much lux camera received from which object in the scene.
If you select the ROI, the output will tell you lux contributed from selection and its percentage.

[5] Visualized gradient map: For view only; Can give some general idea about which part contribute more lux.

------------------------------------------------------------------------------------------------------------------------
## Usage:

1.Open the “main.m”.

2.Specify the sensor size of camera (INPUT 1)

3.Specify the focal length of fisheye lens (INPUT 2).

4.If input file is hdr image, user can skip this step (using original resolution). 
  If user want to resize image, specifying the resolution x and y, x and y must be equally scaled from original resolution. (e.g. x = 5184/4 and y = 3456/4)
  User MUST specifying the resolution x and y if using luminance file (.txt);  (INPUT 3)

5.Set the input file directory; If file in the same directory of 'main.m', put the file name on it (e.g.:'yourfilename.hdr', 'yourfilenname.txt').

6.Run the program. 

7.Specify the your fisheye projection type, “0”: equisolid angle projection; "1": equidistant project.

8.Input to the choice to print an illuminance map and make ROI selection, “0”: only output the illuminance of scene,  
  “1”: output the illuminance data, print the lux gradient map, and get lux from your selection area (region of interest).

9.Click 'YES' to start selecting user's ROI nad get the lux of ROI.

10.Use the cursor to outline a polygonal region in the grayscale image, double click when finish selecting.

11.Output the visulized lux gradient map.

--------------------------------------------------------------------------------------------------------------------------
#### The original distribution contain a SAMPLE HDR image for NEW USER to getting familar with this program.

--------------------------------------------------------------------------------------------------------------------------
