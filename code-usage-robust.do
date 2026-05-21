egen id = group(所在地)
egen classx=group(class)
egen modelx=group(model)
gen year=time
gen lnin=ln(in)
gen price=新车含税价


reghdfe lnin ev, absorb(id classx modelx) vce(cluster id)



set seed 10101
gen ranorder=runiform()
sort ranorder
psmatch2 ev price modelx id, out(lnin) logit neighbor(1) ties common ate caliper(0.05)



reghdfe lnin ev if _weight==., absorb(id classx modelx) vce(cluster id)
