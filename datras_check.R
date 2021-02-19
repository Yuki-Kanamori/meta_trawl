require(tidyverse)

# install.packages("icesDatras")
library(icesDatras)
?icesDatras
## internet connection is needed for {icesDatras}


dir = "/Users/Yuki/Dropbox/meta_trawl/DATRAS"



# ---------------------------------------------------------------
# check for survey points and time-series  ----------------------
# ---------------------------------------------------------------

# survey list ---------------------------------------------------
slist = getSurveyList()
# [1] "BITS"             "BTS"              "BTS-GSA17"        "BTS-VIII"         "DWS"              "DYFS"            
# [7] "EVHOE"            "FR-CGFS"          "IE-IAMS"          "IE-IGFS"          "IS-IDPS"          "NIGFS"           
# [13] "NL-BSAS"          "NS-IBTS"          "NS-IBTS_UNIFtest" "NS-IDPS"          "PT-IBTS"          "ROCKALL"         
# [19] "SCOROC"           "SCOWCGFS"         "SE-SOUND"         "SNS"              "SP-ARSA"          "SP-NORTH"        
# [25] "SP-PORC"          "SWC-IBTS"   



# year list -----------------------------------------------------
# ylist = vector("list", length = length(slist))
ylist2 = list()
data2 = list()
for(i in 1:length(slist)){
  data = getSurveyYearList(slist[i])
  
  for(j in 1:length(data)){
    data2 = c(data2, list(data[j]))
  }
  
  ylist2 = c(ylist2, list(data2))
}
# ylist2 = ylist

ylist = list()
for(i in 1:length(slist)){
  data = getSurveyYearList(slist[i])
}
names(ylist) = slist


# quarters list -------------------------------------------------
syqlist = NULL
for(i in 1:length(slist)){
  for(j in 1:length(ylist)){
    # i = 1; j = 1
    qlist = getSurveyYearQuarterList(survey = slist[i], year = ylist[[i]][[j]])
    temp = data.frame(survey = rep(paste0(slist[i]), each = length(qlist)), year = rep(paste0(ylist[[i]][[j]]), each = length(qlist)), quarter = qlist)
    
    syqlist = rbind(syqlist, temp)
  }
}
unique(syqlist$survey)

year_length = syqlist %>% group_by(survey) %>% summarize(min = as.numeric(min(year)), max = as.numeric(max(year))) %>% mutate(duration = (max-min+1))
year_length = year_length %>% mutate(duration = (max-min+1))

setwd(dir)
write.csv(syqlist, "syqlist.csv")
write.csv(year_length, "year_length.csv")



# ---------------------------------------------------------------
# find species -------------------------------------------------------
# ---------------------------------------------------------------
# install.packages("icesAdvice")
# install.packages("icesVocab")
library(icesAdvice)
?icesAdvice
library(icesVocab)
?icesVocab

# cannot get all species ...
icesVocab::findAphia("haddock")
# find the ID here
# http://datras.ices.dk/Data_products/qryspec.aspx



# ---------------------------------------------------------------
# get data (catch weight) -------------------------------------------------------
# ---------------------------------------------------------------
setwd(dir)
# tabel = read.table("list_sharks.txt", header=TRUE, sep = '\t') %>% data.frame()
table = read.csv("list_sharks.csv")
summary(table)
sp_list = unique(table$WoRMS_AphiaID)

for(i in 1:length(sp_list)){
  for(j in 1:length(year_length)){
    data = getCatchWgt(survey = year_length[j, 1], years = year_length[j, 2]:year_length[j, 2], quarters = 1, aphia = i) %>% mutate()
  }
}
 

BTS = getCatchWgt(survey = slist[2], years = 1991:2016, quarters = 1, aphia = 105704)

aphia = c(105704, 105705, 105706, 105713, 105714, 105715, 105716, 105717, 105743, 105744, 105775, 105787, 105788, 105817, 105819, 105838, 105839, 105839, 105840, 105841, 105898, 105899, 105900, 148801, 148802, 148804, 148805, 148806, 148807, 158508, 158510, 158512, 158513, 158514, 158515, 158516, 158521, 158523, 217626, 217630, 217632, 217635, 217637, 217638, 217639, 217640, 217641)

test = read.table("list_test.txt")


# ---------------------------------------------------------------
# get data (length data) -------------------------------------------------------
# ---------------------------------------------------------------
hl_ns = getHLdata(survey = slist[14], year = 1991, quarter = 1)
colnames(hl_ns)

unique(hl_bits$Valid_Aphia)



# ---------------------------------------------------------------
# get data (haul data) -------------------------------------------------------
# ---------------------------------------------------------------
hh_ns91 = getHHdata(survey = slist[14], year = 1991, quarter = 1)
de = hh_ns91 %>% filter(Country == "DE")
