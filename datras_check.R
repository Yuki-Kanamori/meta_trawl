require()

install.packages("icesDatras")
library(icesDatras)
?icesDatras


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
    qlist = getSurveyYearQuarterList(survey = slist[i], year = ylist[[i]][[j]])
    temp = data.frame(survey = rep(paste0(slist[i]), each = length(qlist)), year = rep(paste0(ylist[[i]][[j]]), each = length(qlist)), quarter = qlist)
    
    
  }
}



t = getSurveyYearQuarterList(survey = slist[1], year = ylist[[1]][[3]])
yqlist = data.frame(survey = rep(paste0(slist[1]), each = length(t)), year = rep(paste0(ylist[[1]][[3]]), each = length(t)), quarter = t)


yqlist = data.frame(quarter = t) %>% mutate(year = paste0(survey = paste0(slist[1]), ylist[[1]][[3]]))



qlist = list()
for(i in 1:length()){
  
}







