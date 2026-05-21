egen id = group(省份)
egen class=group(级别)
egen model=group(车身)
gen year=车龄
gen lnmt=ln(mt)
gen xgdp=ev*percapitagdp
gen xincome=ev*percapitaincomeofresidents
gen xpop=ev*popdensity
gen xaqi=ev*aqi
gen xpub=ev*pubexp
gen xfuel=ev*汽油加权价格
gen xelec=ev*电力加权价格
gen xenergy=ev*燃料价格
gen xenvironment=环境保护热度*ev
gen xlowcarbon=低碳出行热度*ev
gen xai=aidrive*ev
gen xclass=modelclass*ev
gen xprice=price*ev


//original results
reg lnmt ev, r
reghdfe lnmt ev, absorb(id class model) vce(cluster id)



//psm matching
drop ranorder
set seed 10101
gen ranorder=runiform()
sort ranorder
psmatch2 ev year class model id, out(lnmt) logit neighbor(1) ties common ate caliper(0.05)
pstest year class  model id, both
psgraph

//fig
twoway(kdensity _ps if _treat==1, legend(label(1 "Treated"))) (kdensity _ps if _treat==0, legend(label (2 "Control"))), xtitle (Pscore) title("Before Matching")

twoway(kdensity _ps if _treat==1, legend(label(1 "Treated"))) (kdensity _ps if (_weight!=1&_weight!=.), legend(label (2 "Control"))),xtitle (Pscore) title("After Matching")

//results
reghdfe lnmt ev if _weight==., absorb(id class model) vce(cluster id)


//Mechanisms
gen xgdpc=ev*gdpclass
gen xpopc=ev*popclass
gen xaqic=ev*aqiclass
gen xpubc=ev*pubexpclass
gen xincomec=ev*incomeclass
gen xfuelc=ev*gasclass
gen xelecc=ev*elecclass
gen xenvironmentc=environmentclass*ev
gen xlowcarbonc=lowcarbonclass*ev
gen xpricec=priceclass*ev

reghdfe lnmt ev xgdpc if _weight==., absorb(id class model) vce(cluster id)
reghdfe lnmt ev xpopc if _weight==., absorb(id class model) vce(cluster id)
reghdfe lnmt ev xaqic if _weight==., absorb(id class model) vce(cluster id)
reghdfe lnmt ev xpubc if _weight==., absorb(id class model) vce(cluster id)
reghdfe lnmt ev xincomec if _weight==., absorb(id class model) vce(cluster id)
reghdfe lnmt ev xfuelc if _weight==., absorb(id class model) vce(cluster id)
reghdfe lnmt ev xelecc if _weight==., absorb(id class model) vce(cluster id)
reghdfe lnmt ev xenergy if _weight==., absorb(id class model) vce(cluster id)
reghdfe lnmt ev xenvironmentc if _weight==., absorb(id class model) vce(cluster id)
reghdfe lnmt ev xlowcarbonc if _weight==., absorb(id class model) vce(cluster id)
reghdfe lnmt ev xpricec if _weight==., absorb(id class model) vce(cluster id)
reghdfe lnmt ev xclass if _weight==., absorb(id class model) vce(cluster id)
reghdfe lnmt ev xai if _weight==., absorb(id class model) vce(cluster id)


//Subgroup regression
reghdfe lnmt ev if _weight==.&gdpclass==0, absorb(id class model) vce(cluster id)
reghdfe lnmt ev if _weight==.&gdpclass==1, absorb(id class model) vce(cluster id)

reghdfe lnmt ev if _weight==.&popclass==0, absorb(id class model) vce(cluster id)
reghdfe lnmt ev if _weight==.&popclass==1, absorb(id class model) vce(cluster id)


reghdfe lnmt ev if _weight==.&aqiclass==0, absorb(id class model) vce(cluster id)
reghdfe lnmt ev if _weight==.&aqiclass==1, absorb(id class model) vce(cluster id)

reghdfe lnmt ev if _weight==.&pubexpclass==0, absorb(id class model) vce(cluster id)
reghdfe lnmt ev if _weight==.&pubexpclass==1, absorb(id class model) vce(cluster id)

reghdfe lnmt ev if _weight==.&incomeclass==0, absorb(id class model) vce(cluster id)
reghdfe lnmt ev if _weight==.&incomeclass==1, absorb(id class model) vce(cluster id)

reghdfe lnmt ev if _weight==.&gasclass==0, absorb(id class model) vce(cluster id)
reghdfe lnmt ev if _weight==.&gasclass==1, absorb(id class model) vce(cluster id)

reghdfe lnmt ev if _weight==.&elecclass==0, absorb(id class model) vce(cluster id)
reghdfe lnmt ev if _weight==.&elecclass==1, absorb(id class model) vce(cluster id)


reghdfe lnmt ev if _weight==.&environmentclass==0, absorb(id class model) vce(cluster id)
reghdfe lnmt ev if _weight==.&environmentclass==1, absorb(id class model) vce(cluster id)

reghdfe lnmt ev if _weight==.&lowcarbonc==0, absorb(id class model) vce(cluster id)
reghdfe lnmt ev if _weight==.&lowcarbonc==1, absorb(id class model) vce(cluster id)


reghdfe lnmt ev if _weight==.&priceclass==0, absorb(id class model) vce(cluster id)
reghdfe lnmt ev if _weight==.&priceclass==1, absorb(id class model) vce(cluster id)


reghdfe lnmt aidrive if _weight==., absorb(id class model) vce(cluster id)

reghdfe lnmt noai if _weight==., absorb(id class model) vce(cluster id)





