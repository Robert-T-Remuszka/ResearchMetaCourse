clear all
do globals

do import_data  // Import and save raw data from FRED
do merging_data // Merge the two raw files and create the Phillips curve analysis file
do graphing     // Create some graphs to visualize the Phillips curve
do reg_tables   // Create a regression table to correct the OVB problem with the Phillips curve