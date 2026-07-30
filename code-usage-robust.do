egen id = group(所在地)
egen class=group(class)
egen model=group(model)
gen lnin=ln(in)



reghdfe lnin ev, absorb(id class model) vce(cluster id)



drop ranorder
set seed 10101
gen ranorder=runiform()
sort ranorder
psmatch2 ev class model id,neighbor(1) caliper(0.05) common noreplacement




reghdfe lnin ev if _weight!=., absorb(id class model) vce(cluster id)
