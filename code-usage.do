

//original results
reg lnmt ev, r
reghdfe lnmt ev, absorb(id class model) vce(cluster id)



//psm matching
drop ranorder
set seed 10101
gen ranorder=runiform()
sort ranorder
psmatch2 ev class model id,neighbor(1) caliper(0.05) common noreplacement
pstest class  model, both
psgraph

//fig
twoway ///
    (kdensity _pscore if _treated == 1, ///
        lpattern(solid)) ///
    (kdensity _pscore if _treated == 0, ///
        lpattern(dash)), ///
    legend(order(1 "Treated" 2 "Control")) ///
    xtitle("Propensity score") ///
    ytitle("Density") ///
    title("Before Matching") ///
    name(ps_before, replace)


gen byte matched_treated = ///
    (_treated == 1 & _support == 1 & _nn > 0 & _nn < .)

gen byte matched_control = ///
    (_treated == 0 & _support == 1 & ///
     _weight > 0 & _weight < .)
	 twoway ///
    (kdensity _pscore if matched_treated, lpattern(solid)) ///
    (kdensity _pscore if matched_control, lpattern(dash)), ///
    legend(order(1 "Treated" 2 "Control")) ///
    xtitle("Propensity score") ///
    ytitle("Density") ///
    title("After Matching") ///
    name(ps_after, replace)

//results
reghdfe lnmt ev if _weight!=., absorb(id class model) vce(cluster id)


//Subgroup regression
reghdfe lnmt ev if _weight!=.&gdpclass==0, absorb(id class model) vce(cluster id)
reghdfe lnmt ev if _weight!=.&gdpclass==1, absorb(id class model) vce(cluster id)

reghdfe lnmt ev if _weight!=.&popclass==0, absorb(id class model) vce(cluster id)
reghdfe lnmt ev if _weight!=.&popclass==1, absorb(id class model) vce(cluster id)


reghdfe lnmt ev if _weight!=.&aqiclass==0, absorb(id class model) vce(cluster id)
reghdfe lnmt ev if _weight!=.&aqiclass==1, absorb(id class model) vce(cluster id)

reghdfe lnmt ev if _weight!=.&pubexpclass==0, absorb(id class model) vce(cluster id)
reghdfe lnmt ev if _weight!=.&pubexpclass==1, absorb(id class model) vce(cluster id)

reghdfe lnmt ev if _weight!=.&incomeclass==0, absorb(id class model) vce(cluster id)
reghdfe lnmt ev if _weight!=.&incomeclass==1, absorb(id class model) vce(cluster id)

reghdfe lnmt ev if _weight!=.&gasclass==0, absorb(id class model) vce(cluster id)
reghdfe lnmt ev if _weight!=.&gasclass==1, absorb(id class model) vce(cluster id)

reghdfe lnmt ev if _weight!=.&elecclass==0, absorb(id class model) vce(cluster id)
reghdfe lnmt ev if _weight!=.&elecclass==1, absorb(id class model) vce(cluster id)


reghdfe lnmt ev if _weight!=.&environmentclass==0, absorb(id class model) vce(cluster id)
reghdfe lnmt ev if _weight!=.&environmentclass==1, absorb(id class model) vce(cluster id)

reghdfe lnmt ev if _weight!=.&lowcarbonc==0, absorb(id class model) vce(cluster id)
reghdfe lnmt ev if _weight!=.&lowcarbonc==1, absorb(id class model) vce(cluster id)


reghdfe lnmt ev if _weight!=.&priceclass==0, absorb(id class model) vce(cluster id)
reghdfe lnmt ev if _weight!=.&priceclass==1, absorb(id class model) vce(cluster id)








