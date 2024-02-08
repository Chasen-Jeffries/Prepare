# 🌟 Prepare

## 🔍 Overview

**Prepare**: An R Package for Streamlined Data Cleaning

The `Prepare` package is specifically designed to address the unique challenges of cleaning and preparing data from various public datasets. It transforms what previously required dozens of lines of code into a single command. With an initial focus on data from the World Bank and the United Nations, this package simplifies the process of transforming raw data into a format that's ready for analysis. This includes capabilities such as reshaping datasets, handling missing values, standardizing naming conventions, and more. 

### 🔑 Key Features:

- 🌐**Specialized Functions**: Includes functions like `WB_Clean` and `UN_Clean` tailored for datasets from the World Bank and United Nations, respectively.
- 🔄**Flexibility in Data Transformation**: Offers options to reshape data into wide or long formats, catering to diverse analytical needs.
- 👍**Ease of Use**: Designed with simplicity in mind, it's suitable for both beginners and experienced R users.
- 📈**Expandability**: While currently focused on World Bank and United Nations data, the package is structured to easily incorporate cleaning functions for additional data sources in the future.

🌍Ideal for researchers, data analysts, and anyone working with data from international organizations, `Prepare` serves as a go-to solution for making the initial steps of data analysis quicker and more efficient.


## ⚙️Installation

You can install the released version of Prepare through Github with:

```r
# install.packages("devtools")
devtools::install_github("Chasen-Jeffries/Prepare")
```

## 🚀Usage

Here's a quick example of how to use the Prepare package:

```r
# Load Package
library(Prepare)
# Load a sample dataset (replace this with an actual dataset)
data(world_bank_example)

# Clean the World Bank data
cleaned_data <- Prepare(world_bank_example, source = 'wb')
```

## 🛠️Features

### `Prepare(df, source)`: Core Function for Data Cleaning and Preparation

The `Prepare` function is essential for cleaning and preparing datasets. It requires two main arguments:

- **Required Argument**:
  - `df`: The DataFrame to be cleaned.
  - `source`: The source of the data. Currently, it supports 'wb' (World Bank) and 'un' (United Nations).

#### Additional Options:

1. **make_wide**: A logical argument. If set to `TRUE`, it transforms the dataset from long format to wide format.
2. **drop_na**: A logical argument. When `TRUE`, it drops all rows with NA values.
3. **var_name**: An optional argument to specify a new name for the value column in a long format dataset.

### `WB_Clean(dataset)`: Function for Cleaning World Bank Data

This function is tailored for cleaning datasets obtained from the World Bank.

- **Required Argument**:
  - `dataset`: The World Bank dataset to be cleaned.

#### Additional Options:

1. **make_wide**: A logical argument. If set to `TRUE`, it transforms the dataset from long format to wide format.
2. **drop_na**: A logical argument. When `TRUE`, it drops all rows with NA values.
3. **var_name**: An optional argument to specify a new name for the value column in a long format dataset.

### `UN_Clean(dataset)`: Function for Cleaning United Nations Data

This function is specifically designed for cleaning datasets from the United Nations.

- **Required Argument**:
  - `dataset`: The United Nations dataset to be cleaned.

#### Additional Options:

1. **make_wide**: A logical argument. If set to `TRUE`, it transforms the dataset from long format to wide format.
2. **drop_na**: A logical argument. When `TRUE`, it drops all rows with NA values.
3. **var_name**: An optional argument to specify a new name for the value column in a long format dataset.

## ❓Getting Help
- 🐞 **Bugs**: File a reproducible example on GitHub issues.
- 💬 **Discussions**: Contact the package maintainer.

## 🤝Contributions

Contributions to the Prepare package are welcome from anyone and are best sent as a pull request on GitHub.

## 📜License

The Prepare package is licensed under the MIT License.
