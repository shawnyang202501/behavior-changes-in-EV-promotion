

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

//Subgroup regression
reghdfe lnmt ev if _weight==.&gdpclass==0, absorb(id class model) vce(cluster id)
reghdfe lnmt ev if _weight==.&gdpclass==1, absorb(id class model) vce(cluster id)
reghdfe lnmt ev if _weight==.&popclass==0, absorb(id class model) vce(cluster id)
reghdfe lnmt ev if _weight==.&popclass==1, absorb(id class model) vce(cluster id)
reghdfe lnmt ev if _weight==.&aqiclass==0, absorb(id class model) vce(cluster id)
reghdfe lnmt ev if _weight==.&aqiclass==1, absorb(id class model) vce(cluster id)
reghdfe lnmt ev if _weight==.&pubexpclass==0, absorb(id class model) vce(cluster id)
reghdfe lnmt ev if _weight==.&pubexpclass==1, absorb(id class model) vce(cluster id)