# Coursera-GettingData-Final-Project

## Tasking 

This is a guide to the run_analysis.R script in this repository, which merges, cleans, and analyzes a set of raw data files collected from the accelerometers and gyroscopes in Samsung Galaxy II smartphones that were worn by 30 volunteers who performed six different activities.

The raw data files were numerous and some were quite large (one being over 62 MB), containing multiple vectors of calcuations for 30 subjects performing six different activities - the main tables containing the data had rows with 561 variables.  Furthermore, each subject/activity pair contained multiple windows of data, with each window having its own row in the raw dataset.

The raw data files were also optimized for machine learning, with the data vectors split into training and test datasets. In addition, subject and activity variables - as well as the header list for columns - were split into their own tables.    

I was asked to merge the training and test sets, and to generate a final table of data that provided averages of their mean and standard deviation calculations, grouped by subject/activity pairings.

### Description of the final dataset

The final means.txt dataset contains 180 rows (for 30 subjects x 6 activities each) in a tidy, wide format.  The first two columns of each row denote a unique subject/activity pairing, and each of the remaining 66 columns in the rest of the vector for that row contains a calculation averaging a unique variable across multiple windows for that subject/activity pairing. 

The most difficult aspect of creating a tidy dataset here was in the choosing of variable names, as the calculations in the raw datasets had lengthy descriptors. I chose to render the variable names in camelCase to make them more readable, and to provide a full text string for some abbreviations to make them easier to grasp. A guide for the variable names can be found in my codebook (https://github.com/aep123/Coursera-GettingData-Final-Project).

If I had a more user-friendly names or descriptors for the subjects (such as "male", "female", or age markers, etc) I would have included them in the final file, but the original raw data referred to subjects by number only. 

## General Notes on the script

I used RStudio for initial exploration of the dataset and for writing the run\_analysis.R script. The script requires the dplyr package as it makes use of dplyr's handy `tbl\_df()`, `rename()`, `left\_join()`, `select()`, `group\_by()`, and `summarise\_each()` functions.

Since some of the datasets in this exercise were so large, I used the rm() function to drop data frames, vectors, and tables once they were no longer needed by the script, in order to save RAM on my old desktop computer.

### Reading the datasets

When exploring the datasets it was clear that the X\_test.txt and X\_train.txt files were the main data files, containing the 561-element calculation vectors.  In addition, it was clear that the Y\_test.txt and Y\_train.txt datasets contained activity codes that corresponded to the X files, as the values in the Y files ranged from 1 to 6 and the number of rows in the Y files matched the number of rows in the X files.  Finally, the number of rows of the subject\_train.txt and subject\_test.txt files also matched those of their corresponding Y and X files, and the values ranged from 1 to 30, which was the number of subjects in the data set per the original file documentation.

Further exploration revealed the features.txt file contained the variable labels for the 561-element vector. It also contained a highly abbreviated name for each variable and the reserved characters () and -, which would make it difficult to use the variable names within tables. 

I elected to read features.txt with the read.table function, with conditions `colClasses = "character"`, `fixed = TRUE`, and `encoding = "UTF-8"`) in order to ease the unpacking of variable names further down in the script. I did it this way because I had noticed that the variables I wanted to select for averaging all had the same format - "mean()" or "std()" - which separated them from other uses of the same letters (specifically "Mean", which had a different connotation in other variable names). By using the conditions outlined above, I was able to keep the (otherwise undesirable) "()" characters to make easier use of the grep() and sub() functions further down in the script.

### Merging the datasets

After reading in the initial 7 datasets described above, I merged all the test files with each other, and then merged all the train files with each other using `cbind()`. 

For the next step I bound the merged train and test sets to each other using an `rbind()` function. I then created a vector of column names that included the variable names in features.txt, adding two initial names "Subject" and "ActivityCode", and added it to the merged dataset.  

I then took the resulting data frame (named 'comp' in the script) and turned it into a dplyr table named 'comptbl', to enable the use of dplyr functions in the following steps.

### Extracting the mean and standard deviation variables

Per the instructions, I was to extract the mean and standard deviation calculations from this large dataset for further analysis. As noted above, initial review of the raw files showed that variables for these calculations had a distinctive format - containing either the string "mean()" or "std()", which would make it easy to extract them because I had deliberately imported those strings in the column name vector when reading the files into R.

I used the `grep()` function to create the desired subset of 'comptbl', being careful to stipluate the condition `fixed = TRUE` to ensure an exact match on those strings. I named the resulting table 'slim'.

### Converting activity codes to descriptive activity names

Since it is desirable to have qualitative variables represented as factors or character strings for a tidy data set, I was asked to convert the activity codes in the original data set to short descriptions of the activities. Since a file containing a table with activity codes and their descriptions appeared in the original data set (activity\_labels.txt), I used that to supply the descriptive text. 

I read this file in (with `colClasses = "character"`), gave its columns appropriate names, converted its problematic '\_' characters to spaces, and named the resulting file 'acts'. I converted the corresponding column in the 'slim' table from numeric to character and ran a `left\_join()` on 'slim' and 'acts' to add the descriptive activity names to each row. I named the resulting table 'slimmod'.

### Rewording variable names

At this point I elected to convert the pithy variable names supplied in the initial data to something that was more readable (camelCase with limited abbreviations), and to eliminate all the reserved characters that would otherwise make it impossible to use certain dplyr functions. 

These conversions were done with simple `sub()` statements acting on a vector of the variable names. After reattaching the vector to the 'slimmod' table, I ran a `select()` function on slimmod to reorder the columns by making the subject and activity description columns the first and second from the left, and by removing the now unnecessary activity code column. 

### Creating the final dataset

I was asked to provide a final dataset that contained averages of all the variables that I had extracted, grouped by subject/activity pairings. To accomplish this I ran the dplyr functions `group\_by()` and `summarise\_each()`. 

Oddly, the `summarise\_each` function consistently added a row of NA and zero values to the top of the table it produced, so I elected to simply lop off that row before writing the final result to the 'means.txt' file, using the condition `row name = False` as dictated in the project instructions. 
