for (t in 5:15) {
  source('~/Documents/Keio_U/nakatsuma_zemi/sotsuron/bpsbsts.R')
  write.csv(mfdata,paste("/Users/naotowatanabe/Documents/Keio_U/nakatsuma_zemi/sotsuron/mf", t,"pdfs.csv", sep=""),row.names=T,quote=F)
}
