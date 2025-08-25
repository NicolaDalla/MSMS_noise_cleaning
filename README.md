# MSMS_noise_cleaning
code to clean MS/MS spectra relaying only on ions intensities

**Reference:**  
Dalla Valle N., Garcia-Aloy M., Robatscher P., Franceschi P., & Oberhuber M. (2025). Improving Spectral Similarity and Molecular Network Reliability through Noise Signal Filtering in MS/MS Spectra. Analytical Chemistry, 97(29), 15873–15882.
https://doi.org/10.1021/acs.analchem.5c02109

## Overview
In mass spectrometry, noise ions in fragmentation (MS/MS) spectra can significantly reduce spectral similarity scores and compromise molecular network (MN) reliability. This repository provides R code and examples to demonstrate how tailored **noise signal filtering** improves spectral comparisons and network construction.
This repository provides R code and examples to demonstrate how tailored noise signal filtering works on syntetic fragemtnation sepctra.
The code:  
- Works on any MS/MS spectra stored as a `Spectra` object.  
- Requires only ion intensity information, no additional data is needed.  
- Assumes that most ions in a fragmentation spectrum are noise, which is the only key limitation of the method. 

## Key Findings from the Paper
- Noise lowers similarity scores by diluting the contribution of high-intensity peaks.  
- Denoising spectra increases score consistency and reduces false positives connection in molecular networks.
- Molecular networks after denoising show tighter clusters that are better separated by higher distances, resulting in improved network structure.  
- Severe denoising (e.g., 5–10% of relative intensity cutoff) can lead to loss of structural information, making different compounds overlap and appear indistinguishable.     
-  
