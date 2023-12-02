# Prepare

## Overview

Prepare is an R package designed to streamline the data cleaning process for various public datasets, especially those with unique formatting challenges. Currently, it includes specialized functions for handling data from the World Bank and United Nations, with plans to expand support for other data sources in the future. The package offers options for reshaping, cleaning, and preparing data for analysis, making it ideal for researchers and analysts working with these institutions' data.

## Installation

You can install the released version of Prepare through Github with:

```r
# install.packages("devtools")
devtools::install_github("Chasen-Jeffries/Prepare")
```

## Usage
Here's a quick example of how to use the Prepare package:

```r
Copy code
library(Prepare)
# Load a sample dataset (replace this with an actual dataset)
data(world_bank_example)

# Clean the World Bank data
cleaned_data <- Prepare(world_bank_example, source = 'wb')
```

## Features
Prepare(df, source): Main function to clean and prepare datasets. 
- Requires specifying a dataframe (df) and a source (currently supports 'wb' for World Bank and 'un' for United Nations).
- Additional options:
1. make_wide: transform the dataset from long to wide
2. drop_na: drops NA values  
3. var_name: changes the value column name in a long format. 

WB_Clean(dataset, drop_na, make_wide, var_name): Function to clean World Bank data. 
- Only requires the dataset 
- Additional options:
1. make_wide: transform the dataset from long to wide
2. drop_na: drops NA values  
3. var_name: changes the value column name in a long format. 

UN_Clean(dataset, drop_na, make_wide): Function to clean United Nations data. 
- Only requires the dataset.
- Additional options:
1. make_wide: transform the dataset from long to wide
2. drop_na: drops NA values  
3. var_name: changes the value column name in a long format.

Note: using both drop_na and make_wide on the UN dataset can still result in NA values where variables are included in some years but not others. The years where the variable is not included become NAs. 


## Getting Help
If you encounter a clear bug, please file a minimal reproducible example on GitHub issues.

For questions and other discussions, please contact the package maintainer.

## Contributions
Contributions to the Prepare package are welcome from anyone and are best sent as a pull request on GitHub.

## License
The Prepare package is licensed under the MIT License.
