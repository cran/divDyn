# divDyn
R package for quantifying diversity dynamics using fossil sampling data

![](https://github.com/divDyn/assets/raw/master/logo/divDyn_logo_min.png)

## News

- The next update of the package (V0.8.2) is now availble from the CRAN servers! As this is a major update, I suggest everyone to update their copy. See the change log below for the changes. 

- The paper describing the package is available from the Wiley Online Library. You can download it from this link:
https://besjournals.onlinelibrary.wiley.com/doi/10.1111/2041-210X.13161 
(or contact me, if you have problems). If you decide to use the methods implemented in this package, please refer to this document. The examples implemented can be reproduced with the files deposited at
https://github.com/divDyn/ddPhanero
using this (updated) vignette:
https://github.com/divDyn/ddPhanero/blob/master/doc/dd_phanero_web.html


## About the package

If you are interested in what this package does, or have questions about its use, please check out the first vignette: 'Handout to the R package 'divDyn' v0.8.0 for diversity dynamics from fossil occurrence data' here:
https://github.com/divDyn/r_package/blob/master/vignettes/handout.pdf

As the package is still getting developed, please note that some interface changes might occurr based on the feedback of people and my own experience on what is easier to use. If you have any requirements or recommendations about what to add (or more importantly, if you find a mistake), do not hesitate to contact me at adam.kocsis@fau.de.


## Installing 

### 1. From CRAN (v0.8.1)

You can install the appropriate binaries normally, by running 
`install.packages("divDyn")`

### 2. Using manually pre-built binaries (v0.8.1)

I have updated the windows binaries so they work with the latest internals (3.6). If you want to use the binaries, please update your R to at least 3.6.

- If you have a windows computer, you can install the package with the following R command:
  `install.packages("https://github.com/divDyn/assets/raw/master/r_archive/bin/Win_x64_x86/divDyn_0.8.0.zip", repos=NULL, type="win.binary")`

### 3. Using the source tarball to install (v0.8.2)
This you can do with running
```
install.packages(
  "https://github.com/divDyn/assets/raw/master/r_archive/source/divDyn_0.8.0.tar.gz", 
  repos=NULL, type="source")
```

from the R console. Note that there is some code in the package that requires compilation. To do this, the most straightforward way is to install/use Rtools (https://cran.r-project.org/bin/windows/Rtools/) on Windows, and XCode https://developer.apple.com/xcode/ on Mac.

The sources of the older versions are also in the _archive/source folder. You can access earlier versions by changing the version number in the command above.

### 4. Using the repository files and 'devtools' to install (v0.8.2)

To do this:
- You need a compiler, as for method 3
- Make sure that the 'devtools' package is installed
- Run `devtools::install_github("divDyn/r_package")`

If the frist method is not working for you, and you do not want to mess around with a compiler and such, then contact me and I will find a way to compile binaries for you.


# Change log

## [0.8.0 (build 736)]  - 2019.06.12 
### Added
- Support for 'tibble' type input data.frames. 
- The tsbars() function.
- The 'age' argument for the divDyn() and fadlad() functions. With the previous composite time argument ('bin') it was difficult to handle both contiunous age and discrete bin entries, as the two implied different direction of time and applicability in the package functions. The argument 'bin' is now reserved for discrete entries, where bin number increases from earlier to later intervals. The argument 'age' is used for continuous, automatically binned time, where time flows from higher to lower numbers. The 'age' argument will be added to the binstat() function in future versions.
- You can reverse this pattern by toggling the added 'revtime' argument.
- The repmatch() function is now exported from the package namespace. This is the function that is called to match and average the subsampling output. You will probably not need this, but just in case.
- The 'bin=NULL' option is now valid for the subsample() function, specifying subsampling processes that are not iterated over mutliple time bins. This allows the application of sampling-based rarefaction, SQS and so on. With this configuration, the function can also accept vectors as the primary argument. 
- The 'na.rm' argument is added to the subsample() function. The inclusion of this argument is part of a more scrutinous checking protocol for missing values. 
- The slice() function is now exported from the package namespace. This function is used by the divDyn() function for discretizing (slicing) the continuous time dimension. Doing this separately is a prerequisite of running subsample() on the data.
- The 'depenv' element to the 'keys' data object. This addition maps entries in the 'environment' field of the Paleobiology Database to "onshore" or "offshore" settings. 
- Option to supress loop counting output in the subsample() function ('counter=FALSE').

### Changes
- The divDyn() and binstat() functions both output the names of the 'bins' in the a column that has the 'bin'/'age' argument as a name. Note that in previous versions this was a hard-coded '"bin"' character string. The occasional empty rows that result from using largen than 1- bin numbers now have the bin numbers in the <bin> column instead of ``NA``s. 
- The subsample() function is updated to version 2.0, with a lot of additions. The output of the subsample() function is constrained to match the output of the FUN argument function. <bin> numbers are no longer NA, when FUN=divDyn, and when bins fail the subsampling trials (too low quota) and the output table dimensions do not change, even if bins are omitted from the start or end of the series. THe reorganized function allows additional improvements that will be added in the next version of the package.
- The divDyn() and binstat() functions have a rownames variable that is a replicate of <bin> column. 
- The 'zerodur' argument of the fadlad() function is renamed to 'diffbin' and is restricted to be used with binned entries.
- If 'bin!=NULL' then 'output=list' option of subsample() returns the failed bins (accessible as $failed). The list containing trial results can be accessed as '$results'. 
- If the last bin is supplied as 'rem', the dimensions of the output of subsample() will not change, because the interval will be included in the prototype calculation.
- The abbreviation for the Triassic in the 'stages' internal data.frame is changed from 'T' to 'Tr' (suggestion by V. Roden)
- The 'bins' internal time scale object was renamed to 'tens'. The columns <bin> and <Bin> were also replaced with 'ten' to avoid confusion. 
- All functions of the package now use the conventional 'x' as the primary function argument, typically denoting the occurrence database. This change was necessary to streamline the passing of function objects. Accordingly, the rarely used x-exponent of the OxW subsampling method was changed from 'x' to 'xexp'. 
- The default 'xlab' of the tsplot() function was changed to "Age (ma)" from "age (ma)".
- Some default arguments of the omit() function were changed from the Paleobiology Database defaults, ensuring proper argument flow.
- The package now depends on R versions that are newer than 3.5.0.


### Deleted
- The 'ages' argument of the divDyn() and fadlad() functions was removed due to the re-organization of the time-argumentation.

### Fixed
- The function subsample() crashed when FUN was set to 'divDyn', and the output resulting from its application on the subsample trial dataset did not have have the same dimensions as the result of divDyn() when it was applied to the total dataset. Note that this matching of the 'trial results' is only viable when the data.frame output of FUN has a 'rownames' attribute. 


## [0.7.1 (build 670)]  - 2019.02.18 
### Added
- A lot of people reported problems with the direction of time in the divDyn() function. A startup message is added as a reminder of the arbitrary decision I had to make when designing the function. 
- The affinity() function is extended with the 'na.rm' argument. Setting this argument to TRUE will remove all NAs found in relevant columns of the data table. Otherwise the function will halt if these are found. 
- The "binom" method of the affinity() function is now generalized to more than two entry types. Binomial tests are run for that type that has the highest odds ratio of occurrences when contrasted to the reference dataset ('dat' or 'reldat').
- The 'bycoll' argument is now added to the affinity() function. This allows the calculation of affinities based on the collection rather than occurrence counts.
- Some code was added to the tsplot() function to correctly plot the labels of the time scale boxes when the boundaries of the plot do not coincide with those of the boxes. The plotting of the labels of these partially drawn boxes can be switched on and off with the added 'rtlab' and 'ltlab' arguments.

### Changed
- Package suggested citation now directs to the paper in Methods in Ecology and Evolution.
- The default of the 'coll' argument in the affinity() function is now set to NULL.

### Fixed
- The main divDyn() function produced warnings ('In cbind(bin = aubi$z, dCountsAndMetrics)'') when the automatic binning was used ('breaks 'argument) and when the provided interval had younger parts than the occurrence data. The results are the same, the warnings are no longer produced.
- Problems with the 'reldat' argument of the affinity() function

  
## [0.7.0 (build 642)]  - 2019.01.08 
### Added
- the georange() function for geographic range estimation from a set of coordinates (suggesting the vegan and the icosa packages)
- the tabinate() function for iterating procedures on taxon/time slice subsets of the data

### Changed
- the internals of the binning procedure of divDyn()
- updated ddPhanero vignette
- To make the contents of the 'stages' object consistent with its name, the former geochronological entries are replaced with their chronostratigraphic counterparts. The columns per, period and periodCol were replaced with 'sys', 'system' and 'systemCol', table entries with 'Early' and 'Late' qualifiers were replaced with 'Lower' and 'Upper', respectively. The vignettes are adjusted to work with these changes. 


## [0.6.3] - 2018.12.21
### Added
- The modeltab() function 
- the fill() utility function
- proper NEWS file
- the 'ages' argument to the divDyn() function
- the 'misspell', 'subgenera' and 'stems' are added to the spCleanse() function, which was renamed to cleansp()
- warnings to some functions that signs the presence of "" empty quotes taxa

### Changed/Fixed
- instead of zeros, the divDyn() function now outputs NAs where counting patterns are not applicable
- bin processing in divDyn() had potential issues with negative integer bin numbers

### Deleted
- The inf argument of divDyn() 


## [0.6.2] - 2018.10.22
### Added
- The collapse() and seqduplicated() utility functions.
- The 'zerodur' argument to the fadlad() function
- Hexadecimal colour values to the 'stages' table.
- The 'boxes.col' argument is added to the tsplot() function to plot these colours.
- The 'labels' argument to the the tsplot() function, that allows the user not to plot the labels within the boxes.

### Changed/Fixed
- The stage identification 'Thanetian' was changed to 'Selandian-Thanetian in the 'stages' object to better reflect what the interval really is. It also had a typo in the 'per' column, at the Ordovician/Silurian boundary. The abbreviation of the Bartonian stage was changed to 'Brt' as 'Bar' was already assigned to the Barremian, causing plotting errors.
- Bug in the 'noNAStart' argument of the binstat() function, causing inappropriate function return
- tsplot() now allows y-axis reversal, e.g. ylim=c(4,-1)
- fix of bug in subsample() that resulted in an error message when the first randomly chosen species had higher adjusted frequency than the quorum

## [0.6.1] - 2018.10.01
### Added
- the singletons() function to quickly return single-occurrence, single-reference, single-interval and similar taxa
- citation file

### Changed 
- typo correction in the 'stages' table: 'Ordiovician' entries in the 'period' column were corrected to 'Ordovician'
- minor changes in help files.

## [0.6.0] - 2018.09.17
### Added 
- the indices() function to calculate some basic diversity indices within the package. Please feel encouraged to use the rest from the 'vegan' package.
- the binstat() and sumstat() functions. Binstat calculates bin-specific indices and sampling metrics, sumstat() calculates those relevant for the entire occurrence database. Most functionality of the deprecated sampstat() function is in binstat. 
- forgotten proper cleanup of dynamic libraries upon package unload

## Changed
- material in the sampstat() function was reorganized to two separate functions, see above

## Deleted
- the deprecated crDD() function and the old plotTS() functions were deleted from the package


## [0.5.2] - 2018.09.02
### Added
- x argument for sampstat() to calculate maximum quotas with OxW subsampling.
- the "none" subsampling type to subsample(). This argument will skip the subsampling part, but reruns the *applied function* in the trials, nevertheless.

### Changed
- the map() function was renamed to categorize() to better reflect its intended use

## [0.5.1] - 2018.08.31
### Changed
- example bin identifier changes (from 'slc' to 'stg')
- the subsample(), subtrialCR(), subtrialOXW(), subtrialSQS() functions now automatically omit rows that have NA entries in the 'bin' variables.
- the 'stages' object now contains dates from Ogg et al. 2016
- bin durations were added to both the 'stages' and 'bins' objects
- the 'stratkeys' and 'keys' objects were updated to version 0.9.2

## [0.5.0-1] - 2018.08.29
### Changed
- stratigraphic assignment objects (in 'keys') now have a -1 entries for empty strings


## [0.5.0] - 2018.08.20
### Added
- bug fix that made R crash randomly
- subsampling trial functions (subtrialCR(), subtrialOXW(), subtrialSQS()) and cleaned help files for 'subsample()'
- multiple bin entry support for 'ranges()'
- proper Description in description file

### Changed
- the functions 'plotTS()' and 'fadLad()' were renamed to 'tsplot()' and 'fadlad()' for easier typing. 
- 'stratkeys' and the corresponding 'keys' updated to v0.9.1
- the 'sampstat()' function no longer outputs empty variables when the argument columns are set to NULL

### Deleted
- the 'exact' method implementation for SQS as it was slow and and incorrect. The 'inexact' method was confirmed with the iNEXT package.


## [0.4.2] - 2018.07.24
### Added
- the ranges() function to plot occurrence data and stratigraphic ranges over time (see examples)
- fadLad(): function defenses 
- fadLad(): two bin columns are now allowed as input (for age uncertainty estimation)
- fadLad(): the ages argument for inverting the time axis
- fixes to conform to the CRAN requirements

### Changed
- plotTS() now allows "no-boxes" plotting, and multiple layers of boxes


## [0.4.1] - 2018.07.07
### Added
- function defenses
- fixes to conform to the CRAN requirements

### Changed
- default settings for the sampstat() and subsample() functions to increase flexibility and user-friendliness
- the intact argument of subsample() was separated to the rem and keep arguments, to enable negative time-slice identifiers.

## [0.4.0] - 2018.06.29
### Added
- the first vignette is now included
- bug fix for the parts() function. Due to the overplotting of polygons, the RGBA colours were not appropriately visualized
- bug fix to the omit() function's binref method.
- the "total" method for the sampstat() function
- documentation to the built in datasets
- the map() function to resolve information downloaded from the PaleoDB
- 'keys' to the stratigraphic and environmental resolution, based on the FossilWorks dynamic timescale ?keys
- the 10 million year timescale of the Paleobiology Database, ?bin

### Changed
- The sampstat() function now outputs a data.frame, instead of a matrix.
- the 'method' argument of subsample() was renamed to 'type' to avoid problems with argument distribution with the frequent 'method' argument name

### Deleted 
- The previously added bayesian method from the affinity() function. The method had problems and is under investigation.

## [0.3.1] - 2018.06.04
### Added
- method argument for the affinity() function, allows implementation of a simple majority rule (method="majority") or the Bayesian approach of Simpson and Harnik (2009, method="bayesian")

### Changed
- the affinity() function was also completely reprogrammed

## [0.3.0] - 2018.06.01
### Added
- continuous time entry is now possible for the divDyn() function. (does not yet work with subsampling!!!!)
- the breaks argument to the divDyn() function

### Changed
- the examples and defaults match the current download from the Paleobiology Database
- the previous 'scleractinia' example dataset was renamed to 'corals' for the sake of simplicity

## [0.2.12] - 2018.05.17
### Added
- na.rm argument for the shades() function to omit gaps in plotting of the time series
- bug fix for the shades() function, single rows bounded by rows of NAs (gaps) from above and below do not crash the function anymore


## [0.2.11] - 2018.05.17
### Added
- bug fix for the plotTS() function, enables log scaling of y axis with plot.args=list(log="y")
- the parts() function for efficient plotting of proportion/count data over time 


## [0.2.10] - 2018.05.13
### Added
- proportional extinction and origination rates to the divDyn() function
- the omit() function for culling occurrence datasets (kind of slow yet)

### Changed
- argumentation of the divDyn function was extended to accomodate the omission of occurrences within the function (optional)


## [0.2.9] - 2018.05.09
### Changed
- the 'cr' method of the subsample() function was rewritten in C++ and with Rcpp classes for faster performance
- fixed bug in the subsample() function, when custom functions produce vector output


## [0.2.8] - 2018.05.01
### Added
- multiple versions of the shareholder quorum subsampling (SQS) routine to subsample()
- the sampstat() function, that outputs basic sampling stats for the time slices
- useFailed argument to subsample(). Changes output depending on whether the subsampling quota/quorum is reached.
- bug fix for the CR method in subsampling 

### Changes
- argument distribution in the subsample() function, FUN argument simplified to a single function

### Planned
- the subsampling routines will be remodularized so that their argument becomes the dataset, rather than the individual columns. This will allow the support for custom subsampling functions.
- 

## [0.2.7] - 2018.02.01
### Changes
- bug (due to output changes in fadLad) and speed fixes for the affinity() function. The interface also changed, it now outputs a single vector instead of a data.frame.
- bug fix in the ratesplit() function argument distribution. The "combine" version works properly now.

# Change log
## [0.2.6] - 2018.01.26
### Added
- John Alroy's (2015) second-for-third extinction/origination proportions/rates to the divDyn() function

## [0.2.5] - 2018.01.22
### Added
- survivors() function to calculate survivorship probabilities

### Changes
- the 'subseries()' function was renamed to 'subsample()' for easier application
- the 'fadLad()' function was redrafted for speed

## [0.2.4] - 2018.01.15
### Added
- the the "oxw" method for the subseries() function. This implements occurrence-weighted by list subsampling.

## [0.2.3] - 2018.01.08
### Added
- the subseries() function to execute certain functions with subsampling applied.


## [0.2.2] - 2017.12.18
### Added
- the shades() function for plotting distributions of values arranged in a time series

## [0.2.1] - 2017.12.12
### Added
- the ratesplit() function for selectivity tests
- period abbreviations for the 'stages' object

### Changes
- plotTS() function default changes


## [0.2.0] - 2017.12.11
### Changes
- added Rccp import
- divDyn() updated to v2, ca. 150x faster
- installation changes

## [0.1.6] - 2017-12-04
### Added
- the plotTS() time scale plotting function
- examples were updated

## [0.1.5] - 2017-11-27
### Added
- the streaklog() and whichmaxstreak() functions

## [0.1.4] - 2017-11-22
### Changes
- documentation

## [0.1.3] - 2017-11-21
### Changes
- output variable names in the divDyn() function

### Added
- the first version of the crDD() function is added.

### Notes
Pre-open versions were not registered.
