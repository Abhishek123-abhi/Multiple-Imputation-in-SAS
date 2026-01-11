/******************************************************************************************************************************** 
➤ PROC MI is used to handle missing data by creating multiple complete versions of a dataset. Instead of filling in a
   single value for each missing observation, it generates several plausible values that reflect uncertainty, following 
   Rubin’s multiple imputation framework.

➤ Analysis Step involves applying the same statistical model (such as regression) separately to each imputed dataset. 
   This step ensures consistency across imputations and generates parameter estimates and standard errors for each complete dataset.

➤ PROC MIANALYZE is used after the analysis step to combine results obtained from each imputed dataset. It produces 
   valid statistical inferences by correctly estimating standard errors, confidence intervals, and p-values.

→ Together, these three steps form the multiple imputation workflow: PROC MI creates imputed datasets, the analysis 
  step evaluates each dataset independently, and PROC MIANALYZE integrates the results to account for missing-data uncertainty.
********************************************************************************************************************************/




data Fitness1;
   input Oxygen RunTime RunPulse @@;
   datalines;
44.609  11.37  178     45.313  10.07  185
54.297   8.65  156     59.571    .      .
49.874   9.22    .     44.811  11.63  176
  .     11.95  176          .  10.85    .
39.442  13.08  174     60.055   8.63  170
50.541    .      .     37.388  14.03  186
44.754  11.12  176     47.273    .      .
51.855  10.33  166     49.156   8.95  180
40.836  10.95  168     46.672  10.00    .
46.774  10.25    .     50.388  10.08  168
39.407  12.63  174     46.080  11.17  156
45.441   9.63  164       .      8.92    .
45.118  11.08    .     39.203  12.88  168
45.790  10.47  186     50.545   9.93  148
48.673   9.40  186     47.920  11.50  170
47.467  10.50  170
;
run;


*Impute Missing Values Using MCMC (PROC MI);
proc mi data=Fitness1
        out=Fitness1_MI
        seed=501213
        nimpute=5
        mu0=50 10 180;
        mcmc;     
        var Oxygen RunTime RunPulse;
run;
                  /* MCMC specifies the Markov Chain Monte Carlo method */
                  /* mu0= provides starting values for the mean vector */
                 
proc sort data=Fitness1_MI;
   by _Imputation_;
run;


proc reg data=Fitness1_MI
         outest=RegEstimates
         covout;
         by _Imputation_;
         model Oxygen = RunTime RunPulse;
run;
quit;


proc mianalyze data=RegEstimates;
   modeleffects RunTime RunPulse;
run;
