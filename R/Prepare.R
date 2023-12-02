#' Prepare
#'
#' This function prepares datasets from specified sources for analysis.
#'
#' @param df DataFrame to be cleaned.
#' @param source The source of the data ('wb' for World Bank, 'un' for United Nations).
#' @param drop_na Logical; if TRUE, NA values will be dropped.
#' @param make_wide Logical; if TRUE, the dataset will be converted to wide format.
#' @param var_name Optional; specify a name for the variable column.
#' @return A cleaned and optionally transformed DataFrame.
#' @import dplyr
#' @export
#' @examples
#' prepared_wb_data <- Prepare(world_bank_example, source = 'wb')
#' prepared_un_data <- Prepare(united_nations_example, source = 'un')

Prepare <- function(df, source, drop_na = FALSE, make_wide = FALSE, var_name = NULL) {
  source <- tolower(source)

  if (source == "wb" || source == 'world bank') {
    clean_data <- WB_Clean(df, drop_na, make_wide, var_name)
  } else if (source == "un" || source == 'united nations') {
    clean_data <- UN_Clean(df, drop_na, make_wide)
  } else {
    stop("That data source appears to be unsupported.
         Double check that you entered the source name correctly.
         Otherwise, check our package page to note possible solutions.")
  }

  return(clean_data)
}

#' Clean World Bank Data
#'
#' This function cleans and formats dataset specifically from the World Bank. It standardizes
#' column names and formats, removes unnecessary columns, and handles data encoding and value
#' transformations.
#'
#' @param dataset The dataset to be cleaned.
#' @param drop_na Logical; if TRUE, NA values will be dropped.
#' @param make_wide Logical; if TRUE, the dataset will be converted to wide format.
#' @param var_name Optional; specify a name for the variable column if `make_wide` is FALSE.
#' @return A cleaned and optionally transformed DataFrame.
#' @import dplyr
#' @export
#' @examples
#' wb_data <- WB_Clean(world_bank_example, drop_na = TRUE, make_wide = FALSE)

# Data cleaning specific to World Bank (WB)
WB_Clean <- function(dataset, drop_na = FALSE, make_wide = FALSE, var_name = NULL) {

  # Check if 'Country' or 'Country Name' is not in the column names
  if (!("Country" %in% colnames(dataset)) || !("Country Name" %in% colnames(dataset))) {
    colnames(dataset) <- as.character(unlist(dataset[4, ]))
    dataset <- dataset[-c(1:4), ]
  } else {
    # Error message if the columns are not found
    stop("Error: initial data structure appears different from expectations.")
  }

  # Drop 'Country Code' columns if they exist
  if ("Country Code" %in% colnames(dataset)) {
    dataset <- dataset %>% dplyr::select(-c("Country Code", "Indicator Code"))
  } else {
    # Error message if the columns are not found
    stop("Error: expected column name 'Country Code' not found.")
  }

  # Rename 'Indicator Name' to 'Variable' if it exists
  if ("Indicator Name" %in% colnames(dataset)) {
    colnames(dataset)[colnames(dataset) == "Indicator Name"] <- "Variable"
  } else {
    # Error message if the columns are not found
    stop("Error: expected column name 'Indicator Name' not found.")
  }

  # Rename 'Country Name' to 'Country' if it exists
  if ("Country Name" %in% colnames(dataset)) {
    colnames(dataset)[colnames(dataset) == "Country Name"] <- "Country"
  } else {
    # Error message if the columns are not found
    stop("Error: expected column name 'Country Name' not found.")
  }

  clean_dataset <- dataset

  # Transform column to Long
  clean_dataset <- clean_dataset %>%
      tidyr::pivot_longer(
        cols = -c("Country", "Variable"),  # Select all columns except 'Country' and 'Variable'
        names_to = "Year",             # Name of the new key column
        values_to = "Values"           # Name of the new value column
      )
  clean_dataset$Year <- as.integer(clean_dataset$Year)

    # Determine the new column name
  if (!is.null(var_name)) {
      # Use user-provided column name
      col_name <- var_name
  } else {
      # Check if 'Variable' has exactly one unique value
      unique_var <- unique(clean_dataset$Variable)
      if (length(unique_var) == 1) {
        col_name <- unique_var[1]
      } else {
        warning("Multiple unique 'Variable' values found. 'Values' column not renamed.")
        col_name <- "Values"
      }
  }
    # Rename the 'Values' column and drop the 'Variable' column
    colnames(clean_dataset)[colnames(clean_dataset) == "Values"] <- col_name
    clean_dataset <- clean_dataset %>% dplyr::select(-Variable)

  # Drop rows with NA values if drop_na is TRUE
  if (drop_na) {
    if (nrow(clean_dataset) == 0) {
      warning("The DataFrame is empty. Skipping drop_na operation.")
    } else {
      clean_dataset <- clean_dataset %>% tidyr::drop_na()
    }
  }

    # Pivot the DataFrame to wide format if make_wide is TRUE
    if (make_wide) {
      clean_dataset <- clean_dataset %>%
        tidyr::pivot_wider(
          names_from = Year,
          values_from = col_name
        )
    }

  return(clean_dataset)
}

#' Clean United Nations Data
#'
#' This function cleans and formats dataset specifically from the United Nations. It standardizes
#' column names and formats, removes unnecessary columns, and handles data encoding and value
#' transformations.
#'
#' @param dataset The dataset to be cleaned, typically obtained from United Nations sources.
#' @param drop_na Logical; if TRUE, rows with NA values will be dropped.
#' @param make_wide Logical; if TRUE, the dataset will be pivoted to wide format, with years as column headers.
#' @return A cleaned DataFrame, formatted according to specified parameters.
#' @import dplyr
#' @export
#' @examples
#' un_data <- UN_Clean(united_nations_example, drop_na = TRUE, make_wide = TRUE)


# Data cleaning specific to United Nations (UN)
UN_Clean <- function(dataset, drop_na = FALSE, make_wide = FALSE) {

  # Check if 'Country' is not in the column names
  if (!"Country" %in% colnames(dataset)) {
    colnames(dataset) <- as.character(unlist(dataset[2, ]))
    dataset <- dataset[-c(1), ]
  } else {
    # Error message if the columns are not found
    stop("Error: initial data structure appears different from expectations.")
  }

  # Drop the first column and keep only the first five columns
  clean_dataset <- dataset %>% dplyr::select(1:5)

  # Rename the first five columns
  colnames(clean_dataset) <- c("ID","Country", "Year", "Variable", "Value")

  clean_dataset$Country <- iconv(clean_dataset$Country, from = 'UTF-8', to = 'ASCII//TRANSLIT')

  # Remove commas and other non-numeric characters from the 'Value' column
  clean_dataset$Value <- gsub(",", "", clean_dataset$Value)

  # Convert 'Value' and 'Year' columns to numeric
  clean_dataset$Value <- as.numeric(clean_dataset$Value)
  clean_dataset$Year <- as.numeric(clean_dataset$Year)
  clean_dataset$ID <- as.numeric(clean_dataset$ID)

  # Replace spaces in the variable names with underscores
  clean_dataset$Variable <- gsub(" ", "_", clean_dataset$Variable)

  # Replace spaces and commas in the 'Country' column
  clean_dataset$Country <- gsub(" ", "_", clean_dataset$Country)
  clean_dataset$Country <- gsub(",", "", clean_dataset$Country)

  # Drop rows with NA values if drop_na is TRUE
  if (drop_na) {
    if (nrow(clean_dataset) == 0) {
      warning("The DataFrame is empty. Skipping drop_na operation.")
    } else {
      clean_dataset <- clean_dataset %>% tidyr::drop_na()
    }
  }

  # Pivot the DataFrame to wide format if make_wide is TRUE
  if (make_wide) {
    clean_dataset <- clean_dataset %>%
      tidyr::pivot_wider(
        names_from = Year,
        values_from = Value
      )
  }

  return(clean_dataset)
}

