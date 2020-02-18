
# Data (preamble)

library(data.table)

input <- "https://raw.githubusercontent.com/Rdatatable/data.table/master/vignettes/flights14.csv"
flights <- fread(input)
flights
head(flights)

dim(flights)


# Introduction ------------------------------------------------------------

# 1. Basics ===============================================================

## pre-req: data.frame

n = 1:3
s = c("aa", "bb", "cc")
b = c(TRUE, FALSE, TRUE)
df = data.frame(n, s, b)
df
head(df)
class(df)


### Create simple data.table

DT = data.table(
  ID = c("b", "b", "b", "a", "a", "c"),
  a = 1:7,
  b = 8:14,
  c = 15:21
)
DT

class(DT$ID) # Get the class of the ID column


## General data.tableform

#####
# DT[i, j, by]
#
##   R:                 i                 j        by
## SQL:  where | order by   select | update  group by
#
# Take DT, subset/reorder rows using i, calculate j, grouped by by
#####


### Sub-set rows (i)

# Get all the flights with origin "JFK" and in the month of June
ans <- flights[origin == "JFK" & month == 6L]
head(ans)

# Get the first two rows
ans <- flights[1:2]
ans

# Sort by origin (asc order) and by dest (desc order)
ans <- flights[order(origin, -dest)]
ans

### Select column(s) in j

# select arr_delay column, but return it as vector
ans <- flights[,arr_delay]
head(ans)

# Select arr_delay and origin, but return it as data.table
ans <- flights[, list(arr_delay, origin)]
ans <- flights[, .(arr_delay, origin)] # same thing, .() is an alias for list()
head(ans)

# Select origin column and rename it to city_origin (return as data.table)
ans <- flights[, .(city_origin = origin)]
ans


### Compute or do in j

# 2. Agregations ===============================================================

