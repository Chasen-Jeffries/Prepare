# Prepare

## Overview

**Prepare**: An R Package for Streamlined Data Cleaning

The `Prepare` package is specifically designed to address the unique challenges of cleaning and preparing data from various public datasets. With an initial focus on data from the World Bank and the United Nations, this package simplifies the process of transforming raw data into a format that's ready for analysis. This includes capabilities such as reshaping datasets, handling missing values, standardizing naming conventions, and more.

### Key Features:

- **Specialized Functions**: Includes functions like `WB_Clean` and `UN_Clean` tailored for datasets from the World Bank and United Nations, respectively.
- **Flexibility in Data Transformation**: Offers options to reshape data into wide or long formats, catering to diverse analytical needs.
- **Ease of Use**: Designed with simplicity in mind, it's suitable for both beginners and experienced R users.
- **Expandability**: While currently focused on World Bank and United Nations data, the package is structured to easily incorporate cleaning functions for additional data sources in the future.

Ideal for researchers, data analysts, and anyone working with data from international organizations, `Prepare` serves as a go-to solution for making the initial steps of data analysis quicker and more efficient.


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

**Prepare(df, source)**: Main function to clean and prepare datasets. 
- Requires specifying a dataframe (df) and a source (currently supports 'wb' for World Bank and 'un' for United Nations).
- Additional options:
1. **make_wide**: transform the dataset from long to wide
2. **drop_na**: drops NA values  
3. **var_name**: changes the value column name in a long format. 

**WB_Clean(dataset)**: Function to clean World Bank data. 
- Only requires the dataset 
- Additional options:
1. **make_wide**: transform the dataset from long to wide
2. **drop_na**: drops NA values  
3. **var_name**: changes the value column name in a long format. 

**UN_Clean(dataset)**: Function to clean United Nations data. 
- Only requires the dataset.
- Additional options:
1. **make_wide**: transform the dataset from long to wide
2. **drop_na**: drops NA values  
3. **var_name**: changes the value column name in a long format.

Note: using both **drop_na** and **make_wide** on the UN dataset can still result in NA values where variables are included in some years but not others. The years where the variable is not included become NAs. 


## Getting Help

If you encounter a clear bug, please file a minimal reproducible example on GitHub issues.

For questions and other discussions, please contact the package maintainer.

## Contributions

Contributions to the Prepare package are welcome from anyone and are best sent as a pull request on GitHub.

## License

The Prepare package is licensed under the MIT License.
