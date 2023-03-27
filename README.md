# FRE_Correction_V2
Shiny app for the correction of freshwater reservoir effect when pairs of human and herbivore 14C dates are available.

The freshwater reservoir correction procedure is sometimes necessary because the radiocarbon dating of samples from aquatic environments, such as freshwater systems, can sometimes yield inaccurately old ages. This is due to the "reservoir effect," which occurs when old carbon from the surrounding water is incorporated into the organism's tissues, leading to a discrepancy between the radiocarbon age and the actual calendar age (Bronk-Ramsey et al. 2014; Cook et al. 2001; Cook et al. 2002; Lanting and Van Der Plicht 1998; Philippsen 2013). 

The "offset" method is used to estimate the reservoir effect and correct the radiocarbon age.In this case, you have provided the radiocarbon dates for both a human and an herbivore, as well as their respective δ15N values. The δ15N value is a measure of the nitrogen isotopic composition and is used to estimate the proportion of aquatic resources in the diet. A higher δ15N value generally indicates a higher proportion of aquatic resources in the diet (see details in Cook et al. 2002; Bronk-Ramsey et al. 2014; Schulting et al. 2014; Schulting et al. 2015; Weber et al. 2016).

The code provided here defines a shiny app with a UI and server component.
This app's variant purpose is to help user correct the freshwater reservoir effect of radiocarbon dates, when paired human-herbivore sample-based dates, from the same archaeological context (same burial, house, supply pit, hearth, or other dwelling structures), are securely connected.

The UI component contains input widgets for the variables that the user must upload (see the code below and read the readme file for more details).
The server component calculates the FRE offset and the FRE offset, percentage of aquatic diet, and the corrected 14C date and standard deviation, and generates the output plot and table output.

The calculations performed by the server component of the app are shown below, and follow the procedure outlined in previous other studies, where human-herbivore pair dates procedure had been applied (Cook et al. 2001; Cook et al. 2002; Schulting et al. 2014; Schulting et al. 2015).
In the present app the Nitrogen 15 stable isotope values are used to derive the correction, following research cited above, because in low protein diets the Carbon 13 stable isotope in collagen may be related to both the sources of protein in the diet and because of carbon contributions from carbohydrates and lipids in the diet. When this is the case, a linear mixing model between the  d13C in bone collagen in the consumer end and in the different components of their diet may not be used (Ambrose and Norr 1993; Cook et al. 2001; Cook et al. 2002).
However, as the code is free and available for the users to customize, stable isotope values, such as Carbon 13 and/or Sulfur 34 can be included, according to the formulas provided here and in the literature, to suit to the users respective contexts and research questions.

The offset method for correcting the Freshwater Reservoir Effect (FRE) in radiocarbon dates involves using paired human and herbivore samples to estimate the contribution of freshwater carbon to the human diet. This allows for the calculation of a correction factor to adjust the human radiocarbon date. Here is the procedure:

1.	First, calculate the proportion of aquatic diet in the human sample using the stable isotope values for Carbon 13 (δ13C) and Nitrogen 15 (δ15N).
Proportion of aquatic diet = ((δ13C_human - δ13C_terrestrial) / (δ13C_aquatic - δ13C_terrestrial)) * ((δ15N_human - δ15N_terrestrial) / (δ15N_aquatic - δ15N_terrestrial))

2.	Calculate the radiocarbon age difference between the herbivore and human samples:
Δ14C = 14C_human - 14C_herbivore
SD_Δ14C = sqrt(SD_human^2 + SD_herbivore^2)

3.	Estimate the FRE correction factor for the human sample:
FRE_correction = Δ14C * proportion of aquatic diet

4.   Calculate the standard deviation of the FRE correction factor (SD_FRE_correction) by propagating the uncertainty from the Δ14C standard deviation:
SD_FRE_correction = SD_Δ14C * proportion of aquatic diet

5.   Correct the human radiocarbon date:
14C_human_corrected = 14C_human - FRE_correction  

6.    Estimate the standard deviation of the corrected human radiocarbon date by propagating the uncertainties from the original human radiocarbon date and the FRE correction factor:
SD_corrected = sqrt(SD_human^2 + SD_FRE_correction^2)

To run the app, save the code as a .R file and run it in RStudio or any R environment that supports Shiny applications.
A csv file with dates from Schela Cladovei (Romania), taken from Cook et al. (2002) is also provided to exemplify app’s use.
The application is free to use, and the source code is also freely available for further customization and improvement, as the user contexts and research questions require.

References

Ambrose SH, Norr L. 1993. Experimental Evidence for the Relationship of the Carbon Isotope Ratios of Whole Diet and Dietary Protein to Those of Bone Collagen and Carbonate. In: Lambert JB, Grupe G, editors. Prehistoric Human Bone: Archaeology at the Molecular Level. Berlin, Heidelberg: Springer. p. 1–37. 

Bronk-Ramsey C, Schulting R, Goriunova OI, Bazaliiskii VI, Weber AW. 2014. Analyzing Radiocarbon Reservoir Offsets through Stable Nitrogen Isotopes and Bayesian Modeling: A Case Study Using Paired Human and Faunal Remains from the Cis-Baikal Region, Siberia. Radiocarbon. 56(2):789–799. 

Cook GT, Bonsall C, Hedges RE, McSweeney K, Boronean V, Pettitt PB. 2001. A freshwater diet-derived 14 C reservoir effect at the Stone Age sites in the Iron Gates gorge. Radiocarbon. 43(2A):453–460.

Cook GT, Bonsall C, Hedges RE, McSweeney K, Boroneant V, Bartosiewicz L, Pettitt PB. 2002. Problems of dating human bones from the Iron Gates. Antiquity. 76(291):77–85.

Lanting JN, Van Der Plicht J. 1998. Reservoir Effects and Apparent Ages. The Journal of Irish Archaeology.:151–165.

Philippsen B. 2013. The freshwater reservoir effect in radiocarbon dating. herit sci. 1(1):24. doi:10.1186/2050-7445-1-24.

Schulting RJ, Ramsey CB, Bazaliiskii VI, Goriunova OI, Weber A. 2014. Freshwater Reservoir Offsets Investigated Through Paired Human-Faunal 14C Dating and Stable Carbon and Nitrogen Isotope Analysis at Lake Baikal, Siberia. Radiocarbon. 56(3):991–1008. doi:10.2458/56.17963. 

Schulting RJ, Ramsey CB, Bazaliiskii VI, Weber A. 2015. Highly Variable Freshwater Reservoir Offsets Found along the Upper Lena Watershed, Cis-Baikal, Southeast Siberia. Radiocarbon. 57(4):581–593. 

Weber AW, Schulting RJ, Ramsey CB, Bazaliiskii VI, Goriunova OI, Natal’ia EB. 2016. Chronology of middle Holocene hunter–gatherers in the Cis-Baikal region of Siberia: Corrections based on examination of the freshwater reservoir effect. Quaternary International. 419:74–98.

