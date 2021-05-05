# Classification_Final_Project #

## Table of Contents ##
- [Team](#team)
- [Project Prospectus](./prospectus.md)

## Team
- Ilan Valencius → Hyperspectral Signature/Image Classification
- Ian Dulin → Hyperspectral Signature/Image Classification
- Jose Cuevas → Classification Verification/Research
- Alexander Ronan → Classification Verification/Research

## Methods
* Classifying
  * /Classification/Preprocessing.m contains code for parsing Landsat 8 data as well as loading a shapefile, cropping it to a bounding box (lat, lon), then exporting it. Preprocessing.m must be run before Classifying.m which loads the variables exported from preprocessing.m and extracts appropriate endmembers.
    * Note all Landsat8 files can be parsed and examined seperately *in* MATLAB but all bands must be merged into two rasters, one of full study area and one roi.
  * Statistics.m loads 1) classification of study area, 2) reference.png of burned areas. It then plots and examines the similarity between the two (% overlap).

## Other Notes
* Data must be obtained locally due to githubs file size requirements. CA shp perimeters are able to be uploaded.
