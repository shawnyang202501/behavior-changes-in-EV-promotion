xtset id ym

set processor 8




fect lnnsales, treat(t10i3) unit(id) time(ym) method("both") r(3) nlambda(30) se nboots(10000)

mat list e(ATT)

mat list e(coefs)

//1

fect lnnsales, treat(t10i3) unit(id) time(ym) method("both") cov(GDPper GDPrate pop income pass aqi pubexp) r(3) nlambda(30) se nboots(10000)

mat list e(ATT)

mat list e(coefs)
//2


fect lnnsales, treat(t10i3) unit(id) time(ym) method("ife") cov(GDPper GDPrate pop income pass aqi pubexp) r(1) se nboots(100)

mat list e(ATT)

mat list e(coefs)

fect lnnsales, treat(t10i3) unit(id) time(ym) method("fe") cov(GDPper GDPrate pop income pass aqi pubexp) se nboots(100)

mat list e(ATT)

mat list e(coefs)

fect lnnfuelsales, treat(t10i3) unit(id) time(ym) method("both") cov(GDPper GDPrate pop income pass aqi pubexp) r(3) nlambda(30) se nboots(10000)

mat list e(ATT)

mat list e(coefs)
//3


fect lnnfuelsales, treat(t10i3) unit(id) time(ym) method("both")  r(3) nlambda(30) se nboots(10000)

mat list e(ATT)

mat list e(coefs)
//4




fect lnnfuelsales, treat(t10i3) unit(id) time(ym) method("ife") cov(GDPper GDPrate pop income pass aqi pubexp) r(1) se nboots(100)

mat list e(ATT)


mat list e(coefs)

fect lnnfuelsales, treat(t10i3) unit(id) time(ym) method("fe") cov(GDPper GDPrate pop income pass aqi pubexp) se nboots(100)

mat list e(ATT)

mat list e(coefs)


fect lnnsales, treat(t10i3) unit(id) time(ym) method("both") cov(GDPper GDPrate pop income pass aqi pubexp) r(3) nlambda(30) se placeboTest placeboperiod(1) nboots(10000)
//5

fect lnnsales, treat(t10i3) unit(id) time(ym) method("ife") cov(GDPper GDPrate pop income pass aqi pubexp) r(1) se placeboTest placeboperiod(1) nboots(100)


fect lnnsales, treat(t10i3) unit(id) time(ym) method("fe") cov(GDPper GDPrate pop income pass aqi pubexp) se placeboTest placeboperiod(1) nboots(100)


fect lnnfuelsales, treat(t10i3) unit(id) time(ym) method("both") cov(GDPper GDPrate pop income pass aqi pubexp) r(3) nlambda(30) se placeboTest placeboperiod(1) nboots(10000)
//6

fect lnnfuelsales, treat(t10i3) unit(id) time(ym) method("ife") cov(GDPper GDPrate pop income pass aqi pubexp) r(1) se placeboTest placeboperiod(1) nboots(100)



fect lnnfuelsales, treat(t10i3) unit(id) time(ym) method("fe") cov(GDPper GDPrate pop income pass aqi pubexp) se placeboTest placeboperiod(1) nboots(100)


fect lnnsales, treat(t10i3) unit(id) time(ym) method("both") cov(GDPper GDPrate pop income pass aqi pubexp) r(3) nlambda(30) preperiod(-10) offperiod(0) se equiTest nboots(10000)
//7

fect lnnsales, treat(t10i3) unit(id) time(ym) method("ife") cov(GDPper GDPrate pop income pass aqi pubexp) r(1) preperiod(-10) offperiod(0) se equiTest nboots(100)


fect lnnsales, treat(t10i3) unit(id) time(ym) method("fe") cov(GDPper GDPrate pop income pass aqi pubexp) preperiod(-10) offperiod(0) se equiTest nboots(100)


fect lnnfuelsales, treat(t10i3) unit(id) time(ym) method("both") cov(GDPper GDPrate pop income pass aqi pubexp) r(3) nlambda(30) preperiod(-10) offperiod(0) se equiTest nboots(10000)
//8

fect lnnfuelsales, treat(t10i3) unit(id) time(ym) method("ife") cov(GDPper GDPrate pop income pass aqi pubexp) r(1) preperiod(-10) offperiod(0) se equiTest nboots(100)



fect lnnfuelsales, treat(t10i3) unit(id) time(ym) method("fe") cov(GDPper GDPrate pop income pass aqi pubexp) preperiod(-10) offperiod(0) se equiTest nboots(100)




//9

fect lnnsales, treat(treat10) unit(id) time(ym) method("both") cov(GDPper GDPrate pop income pass aqi pubexp) r(3) nlambda(30) se nboots(100)

mat list e(ATT)

mat list e(coefs)



fect lnnfuelsales, treat(treat10) unit(id) time(ym) method("both") cov(GDPper GDPrate pop income pass aqi pubexp) r(3) nlambda(30) se nboots(100)

mat list e(ATT)

mat list e(coefs)

//10


