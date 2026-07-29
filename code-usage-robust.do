egen id = group(所在地)
egen classx=group(class)
egen modelx=group(model)
gen year=time
gen lnin=ln(in)



reghdfe lnin ev, absorb(id classx modelx) vce(cluster id)



drop ranorder
set seed 10101
gen ranorder=runiform()
sort ranorder
psmatch2 ev classx modelx id,neighbor(1) caliper(0.05) common noreplacement




reghdfe lnin ev if _weight!=., absorb(id class model) vce(cluster id)
