# plumber.R
model <-readRDS("bestModel.rds")

#* Plot a histogram of the MMSE
#* @png 
#* @get /plotMMSE
function(){
  hist(brain_df$MMSE)
}
#* Returns the value of CDR(scale of Dementia). The CDR is based on a scale of 0–3: no dementia (CDR = 0), questionable dementia (CDR = 0.5), MCI (CDR = 1), moderate cognitive impairment (CDR = 2), and severe cognitive impairment (CDR = 3).
#* @param Gender (0-male, 1-female)
#* @param Age Patient's Age
#* @param Educ Education level (0- no education, 3- high school done, 5- 2+ graduation done)
#* @param SES
#* @param MMSE
#* @param eTIV
#* @param nWBV
#* @param ASF
#* @post /manualtransmission
function(Gender, Age, Educ, SES, MMSE, eTIV, nWBV, ASF){
  newdata<- data.matrix(data.frame(Gender = as.numeric(Gender), Age = as.numeric(Age), Educ = as.numeric(Educ), SES = as.numeric(SES), MMSE = as.numeric(MMSE), eTIV = as.numeric(eTIV), nWBV = as.numeric(nWBV), ASF = as.numeric(ASF)))
  xgb_data = xgb.DMatrix(data = newdata)
  y_pred <-predict(model, xgb_data)
  y_pred
}
