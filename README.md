### Getting and Cleaning Data Course Project

# Analysis of Accelerometer Data

## Tidy Data

In [Hadley Wickham's 2014 paper](https://www.jstatsoft.org/article/view/v059i10/) defining the principles of Tidy Data, he explains that 

>"a general rule of thumb is that it is easier to describe functional relationships between variables... than between rows, and it is easier to make comparisons between groups of observations... than between groups of columns".

For this dataset, the means and standard deviations presented were all generated from the same set of raw data using various formulas and transformations. These are functional relationships, and should be represented as columns of variables. The rows of observations are represented by the test subject's ID number and the activity they were performing; it makes sense to compare different subjects and/or different activities.