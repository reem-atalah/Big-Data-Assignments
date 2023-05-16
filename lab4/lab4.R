#Osama Magdy sec:1, BN: 15
#Reem Emad sec:1 BN: 33

# clean workspace

rm(list=ls())

# change the directory
setwd("D:\faculty\CMP4\semester2\Big Data\Assignments\lab4\Association Rules-20230320T090526Z-001\Association Rules")

# check if directory has changed correctly
getwd()

library("arules")
library("arulesViz")

data <- read.transactions("AssociationRules.csv")

# use inspect to display the transactions in readable format using function inspect and show the first 100 transactions
inspect(data[1:100])

# use itemfrequency to get the most two frequent items
itemFrequency(data, type = "absolute")[1:2]

# use itemfrequencyplot to plot the most 5 frequent items
itemFrequencyPlot(data, topN = 5, type = "absolute")

min_support <- 0.01
min_conf <- 0.5
min_cardinality <- 2

# use function apriori to generate the association rules with the minimum support, confidence and cardinality 
rules <- apriori(data, parameter = list(supp = min_support, conf = min_conf, minlen = min_cardinality))

# sort the rules by support
rules_sort_supp <- sort(rules, by = "support", decreasing = TRUE)

# show the first 6 rules
inspect(rules_sort_supp[1:6])

# sort the rules by confidence
rules_sort_conf <- sort(rules, by = "confidence", decreasing = TRUE)

# show the first 6 rules
inspect(rules_sort_conf[1:6])

# sort the rules by lift
rules_sort_lift <- sort(rules, by = "lift", decreasing = TRUE)

# show the first 6 rules
inspect(rules_sort_lift[1:6])

# plot the rules by support as x-axis, 
# confidence as y-axis and lift as a shaded region 
plot(rules)
plot(rules, control=list(jitter=2, col = rev(brewer.pal(9, "Greens")[c(3,7,8,9)])),shading = "lift")
