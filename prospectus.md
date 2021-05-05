# Project Prospectus #
## Table of Contents
  - [Team](#team)
  - [Research Question](#research-question)
  - [Hypotheses](#hypotheses)
  - [Data Sources](#data-sources)
  - [Methods](#methods)
## Team
- Ilan Valencius → Hyperspectral Signature/Image Classification
- Ian Dulin → Hyperspectral Signature/Image Classification
- Jose Cuevas → Classification Verification/Research
- Alexander Ronan → Classification Verification/Research

## Research Question
Satellite data and image classification have long been used to determine the extent and magnitude of burned areas, and until now most of this analysis has used geographic-based information systems. Our group aims to determine the feasibility of such analysis using MATLAB by quantifiably comparing the ability of MATLAB’s Image Processing Toolbox™ to identify regions burned from the August Complex fire to existing data sources. The August Complex fire was a group of wildfires that burned in Northern California in the late summer/early fall of 2020. The complex consisted of 38 separate fires, burned over 1,000,000 acres of land and caused roughly $320,000,000 worth of damage. Such analysis, both pre- and post-fire, are important in evaluating the consequence of burning and the effectiveness of land management strategies, especially in areas sensitive to ignition-based changes. To this end, we endeavor to use MATLAB’s image processing capabilities on known records of the August Complex fire to diagnose the efficacy of these methods in this particular analysis.

In summary:
- How can imaging techniques be used to detect burned - forested areas?
- How can you do image classification in MATLAB?
- How feasible is this as a large-scale analytical - method?
- If MATLAB image classification is feasible, what geospatial patterns or trends from the Northern California wildfires can we observe and what are their implications?

## Hypotheses
We hypothesize that MATLAB’s Image Processing Toolbox™ can adequately identify burned areas resulting from wildfires from 2015-2019 in Northern California. By focusing on individual bands of LANDSAT data, there is a predicated unique spectral fingerprint for burned trees and non burned trees. Consequently, we should be able to use the Hyperspectral Image Library to observe these changes in the LANDSAT data and align these changes with known conflagration events.
## Data Sources
1) [In Situ fire burn data - California State Geoportal](https://gis.data.ca.gov/datasets/CALFIRE-Forestry::recent-large-fire-perimeters-last-five-years-2015-2019-gt5000-acres) *Note: this dataset is temporarily unavailable on the CA Gis Explorer Website*
2) [LANDSAT-8 Hyperspectral Imagery](https://search.earthdata.nasa.gov/search?fp=Landsat-8&as[platform][0]=Landsat-8)
3) [Global Forest Cover Change](https://earthenginepartners.appspot.com/science-2013-global-forest)
## Methods
This should include types of calculations/analyses you will perform with the datasets you are using and the types of visualizations you expect you will be able to create, which you can illustrate using mock-ups of graphs.
Classification:
The backbone of our project is the MATLAB Image Processing Toolbox™, and Hyperspectral Imaging Library, which allows us to download, examine, and extract data pertaining to Landsat-8. Using these toolboxes it is possible to extract a signature for burned areas of forest, determined using burn data provided by the State of California. This signature can then be used to create a classification map of Northern California, indicating where forests have been destroyed by fire.
Verification:
This classification map can then be ground-truthed using i) area of known burn in Northern CA, as well as, ii) global forest changes. These two data sources can be used to compare the accuracy of the methods outlined above to determine the viability of using MATLAB for such an analysis. Additionally, by correlating multiple data sources and methods of analysis with documented mitigation strategies, common trends can be determined for areas which have experienced significant burn.
