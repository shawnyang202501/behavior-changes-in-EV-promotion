/**************************************************************************
 0. Recommended project setup
**************************************************************************/

* Clear previous stored results if needed
* clear all
* set more off

* Optional: open a log file for reproducibility
* log using "ownership_expansion_analysis.log", replace text

* Optional: declare panel structure if not already declared
* xtset id ym


/**************************************************************************
 1. Baseline ownership expansion estimates
    Outcome: lnnsales
    Purpose: Estimate whether sustained EV market entry increases total LDPV sales.
**************************************************************************/

* 1.1 Baseline fect model without covariates
fect lnnsales, ///
    treat(t10i3) unit(id) time(ym) ///
    method("both") r(3) nlambda(30) ///
    se nboots(10000)

* Display average treatment effect on the treated and coefficient output
mat list e(ATT)
mat list e(coefs)


* 1.2 Main fect model with core city-month controls
fect lnnsales, ///
    treat(t10i3) unit(id) time(ym) ///
    method("both") ///
    cov(GDPper GDPrate pop income pass aqi pubexp) ///
    r(3) nlambda(30) ///
    se nboots(10000)

mat list e(ATT)
mat list e(coefs)


/**************************************************************************
 2. Robustness checks for ownership expansion
    Outcome: lnnsales
    Purpose: Check whether the LDPV sales result is robust to alternative
             counterfactual estimators.
**************************************************************************/

* 2.1 Interactive fixed effects specification
fect lnnsales, ///
    treat(t10i3) unit(id) time(ym) ///
    method("ife") ///
    cov(GDPper GDPrate pop income pass aqi pubexp) ///
    r(1) ///
    se nboots(10000)

mat list e(ATT)
mat list e(coefs)


* 2.2 Fixed effects specification
* Note: xinfra is included here in the original code. Confirm whether it should
*       be included here but not in the other main ownership specifications.
fect lnnsales, ///
    treat(t10i3) unit(id) time(ym) ///
    method("fe") ///
    cov(xinfra GDPper GDPrate pop income pass aqi pubexp) ///
    se nboots(10000)

mat list e(ATT)
mat list e(coefs)


/**************************************************************************
 3. ICEV spillover estimates
    Outcome: lnnfuelsales
    Purpose: Estimate whether EV market entry also affects ICEV sales.
**************************************************************************/

* 3.1 Main fect model with core controls
fect lnnfuelsales, ///
    treat(t10i3) unit(id) time(ym) ///
    method("both") ///
    cov(GDPper GDPrate pop income pass aqi pubexp) ///
    r(3) nlambda(30) ///
    se nboots(10000)

mat list e(ATT)
mat list e(coefs)


* 3.2 Baseline fect model without covariates
fect lnnfuelsales, ///
    treat(t10i3) unit(id) time(ym) ///
    method("both") ///
    r(3) nlambda(30) ///
    se nboots(10000)

mat list e(ATT)
mat list e(coefs)


/**************************************************************************
 4. Robustness checks for ICEV spillover
    Outcome: lnnfuelsales
    Purpose: Check whether the ICEV sales result is robust to alternative
             counterfactual estimators.
**************************************************************************/

* 4.1 Interactive fixed effects specification
fect lnnfuelsales, ///
    treat(t10i3) unit(id) time(ym) ///
    method("ife") ///
    cov(GDPper GDPrate pop income pass aqi pubexp) ///
    r(1) ///
    se nboots(10000)

mat list e(ATT)
mat list e(coefs)


* 4.2 Fixed effects specification
fect lnnfuelsales, ///
    treat(t10i3) unit(id) time(ym) ///
    method("fe") ///
    cov(GDPper GDPrate pop income pass aqi pubexp) ///
    se nboots(10000)

mat list e(ATT)
mat list e(coefs)


/**************************************************************************
 5. Placebo tests
    Purpose: Test whether pseudo-treatment effects appear before actual EV
             market entry. These diagnostics support the credibility of the
             counterfactual design when no significant placebo effect is found.
**************************************************************************/

* 5.1 Placebo test for LDPV sales: method both
fect lnnsales, ///
    treat(t10i3) unit(id) time(ym) ///
    method("both") ///
    cov(GDPper GDPrate pop income pass aqi pubexp) ///
    r(3) nlambda(30) ///
    se placeboTest placeboperiod(1) nboots(10000)


* 5.2 Placebo test for LDPV sales: IFE
fect lnnsales, ///
    treat(t10i3) unit(id) time(ym) ///
    method("ife") ///
    cov(GDPper GDPrate pop income pass aqi pubexp) ///
    r(1) ///
    se placeboTest placeboperiod(1) nboots(10000)


* 5.3 Placebo test for LDPV sales: FE
fect lnnsales, ///
    treat(t10i3) unit(id) time(ym) ///
    method("fe") ///
    cov(GDPper GDPrate pop income pass aqi pubexp) ///
    se placeboTest placeboperiod(1) nboots(10000)


* 5.4 Placebo test for ICEV sales: method both
fect lnnfuelsales, ///
    treat(t10i3) unit(id) time(ym) ///
    method("both") ///
    cov(GDPper GDPrate pop income pass aqi pubexp) ///
    r(3) nlambda(30) ///
    se placeboTest placeboperiod(1) nboots(10000)


* 5.5 Placebo test for ICEV sales: IFE
fect lnnfuelsales, ///
    treat(t10i3) unit(id) time(ym) ///
    method("ife") ///
    cov(GDPper GDPrate pop income pass aqi pubexp) ///
    r(1) ///
    se placeboTest placeboperiod(1) nboots(10000)


* 5.6 Placebo test for ICEV sales: FE
fect lnnfuelsales, ///
    treat(t10i3) unit(id) time(ym) ///
    method("fe") ///
    cov(GDPper GDPrate pop income pass aqi pubexp) ///
    se placeboTest placeboperiod(1) nboots(10000)


/**************************************************************************
 6. Equivalence tests for pretreatment fit
    Purpose: Assess whether pretreatment ATT estimates are sufficiently close
             to zero within the specified equivalence bounds.
**************************************************************************/

* 6.1 Equivalence test for LDPV sales: method both
fect lnnsales, ///
    treat(t10i3) unit(id) time(ym) ///
    method("both") ///
    cov(GDPper GDPrate pop income pass aqi pubexp) ///
    r(3) nlambda(30) ///
    preperiod(-10) offperiod(0) ///
    se equiTest nboots(10000)


* 6.2 Equivalence test for LDPV sales: IFE
fect lnnsales, ///
    treat(t10i3) unit(id) time(ym) ///
    method("ife") ///
    cov(GDPper GDPrate pop income pass aqi pubexp) ///
    r(1) ///
    preperiod(-10) offperiod(0) ///
    se equiTest nboots(10000)


* 6.3 Equivalence test for LDPV sales: FE
fect lnnsales, ///
    treat(t10i3) unit(id) time(ym) ///
    method("fe") ///
    cov(GDPper GDPrate pop income pass aqi pubexp) ///
    preperiod(-10) offperiod(0) ///
    se equiTest nboots(10000)


* 6.4 Equivalence test for ICEV sales: method both
fect lnnfuelsales, ///
    treat(t10i3) unit(id) time(ym) ///
    method("both") ///
    cov(GDPper GDPrate pop income pass aqi pubexp) ///
    r(3) nlambda(30) ///
    preperiod(-10) offperiod(0) ///
    se equiTest nboots(10000)


* 6.5 Equivalence test for ICEV sales: IFE
fect lnnfuelsales, ///
    treat(t10i3) unit(id) time(ym) ///
    method("ife") ///
    cov(GDPper GDPrate pop income pass aqi pubexp) ///
    r(1) ///
    preperiod(-10) offperiod(0) ///
    se equiTest nboots(10000)


* 6.6 Equivalence test for ICEV sales: FE
fect lnnfuelsales, ///
    treat(t10i3) unit(id) time(ym) ///
    method("fe") ///
    cov(GDPper GDPrate pop income pass aqi pubexp) ///
    preperiod(-10) offperiod(0) ///
    se equiTest nboots(10000)


/**************************************************************************
 7. Exploratory channel analyses for ownership expansion
    Outcome: lnnsales
    Purpose: Examine whether the sales response to EV market entry varies with
             market, product, cost, infrastructure, socio-economic, and
             environmental contexts.

    Interpretation:
      These regressions should be presented as exploratory heterogeneity or
      channel evidence, not as definitive causal mechanism identification.
      The variables beginning with "x" appear to represent interaction terms
      or constructed moderators. Their construction should be documented.
**************************************************************************/

* 7.1 Infrastructure-related channel
xtreg lnnsales t10i3 xinfra GDPper GDPrate pop income pass pubexp i.ym, fe r

* 7.2 Intelligent-vehicle penetration
xtreg lnnsales t10i3 xaicar GDPper GDPrate pop income pass aqi pubexp i.ym, fe r

* 7.3 EV model availability or EV attribute-related moderator
xtreg lnnsales t10i3 xevam GDPper GDPrate pop income pass aqi pubexp i.ym, fe r

* 7.4 AQI-related moderator
xtreg lnnsales t10i3 xaqiclass GDPper GDPrate pop income pass aqi pubexp i.ym, fe r

* 7.5 Income-related moderator
xtreg lnnsales t10i3 xincomec GDPper GDPrate pop income pass aqi pubexp i.ym, fe r

* 7.6 Public fiscal expenditure-related moderator
xtreg lnnsales t10i3 xlnpub GDPper GDPrate pop income pass aqi pubexp i.ym, fe r

* 7.7 Prior EV market share or EV penetration-related moderator
xtreg lnnsales t10i3 xshare GDPper GDPrate pop income pass aqi pubexp i.ym, fe r

* 7.8 Vehicle price-related moderator
xtreg lnnsales t10i3 xprice2 GDPper GDPrate pop income pass aqi pubexp i.ym, fe r

* 7.9 Public attention to vehicle price reductions
xtreg lnnsales t10i3 pricedownword GDPper GDPrate pop income pass aqi pubexp i.ym, fe r

* 7.10 Public attention to intelligent or AI-driving vehicles
xtreg lnnsales t10i3 xaicarnword GDPper GDPrate pop income pass aqi pubexp i.ym, fe r

* 7.11 Electricity price-related moderator
xtreg lnnsales t10i3 xep GDPper GDPrate pop income pass aqi pubexp i.ym, fe r

* 7.12 Gasoline price-related moderator
xtreg lnnsales t10i3 xop GDPper GDPrate pop income pass aqi pubexp i.ym, fe r

* 7.13 GDP growth-related moderator
xtreg lnnsales t10i3 xgdprate GDPper GDPrate pop income pass aqi pubexp i.ym, fe r

* 7.14 Population-related moderator
xtreg lnnsales t10i3 xpop GDPper GDPrate pop income pass aqi pubexp i.ym, fe r

* 7.15 Public environmental concern
xtreg lnnsales t10i3 xenvironmentattention GDPper GDPrate pop income pass aqi pubexp i.ym, fe r

* 7.16 Public low-carbon mobility concern
xtreg lnnsales t10i3 xlowcarbonattention GDPper GDPrate pop income pass aqi pubexp i.ym, fe r


/**************************************************************************
 8. Robustness check using alternative treatment definition
    Treatment: treat10
    Purpose: Test whether the main LDPV and ICEV sales effects are robust to
             an alternative definition of EV market entry or market presence.
**************************************************************************/

* 8.1 Alternative treatment definition for total LDPV sales
fect lnnsales, ///
    treat(treat10) unit(id) time(ym) ///
    method("both") ///
    cov(GDPper GDPrate pop income pass aqi pubexp) ///
    r(3) nlambda(30) ///
    se nboots(10000)

mat list e(ATT)
mat list e(coefs)


* 8.2 Alternative treatment definition for ICEV sales
fect lnnfuelsales, ///
    treat(treat10) unit(id) time(ym) ///
    method("both") ///
    cov(GDPper GDPrate pop income pass aqi pubexp) ///
    r(3) nlambda(30) ///
    se nboots(10000)

mat list e(ATT)
mat list e(coefs)


/**************************************************************************
 9. Optional: close log
**************************************************************************/

* log close
