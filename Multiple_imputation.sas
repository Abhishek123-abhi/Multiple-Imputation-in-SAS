/**********************************************************************************************************
This section demonstrates a complete, step-by-step implementation of multiple imputation in SAS, 
following standard analytical practice.

The workflow includes:
- Creation of the analysis dataset
- Generation of multiple imputed datasets using PROC MI
- Analysis of each imputed dataset
- Pooling of results using PROC MIANALYZE based on Rubin’s Rules
**********************************************************************************************************/


/* Step 1: Create Analysis Dataset (One Row per Subject) */
data study_data;
    input Subject Treatment Age Baseline Outcome;
    datalines;
101 0 45 120 140
102 0 50 130 145
103 0 38 110 138
104 0 55 135 .
105 0 52 132 147
106 1 60 140 150
107 1 58 138 148
108 1 42 125 142
109 1 47 128 .
110 1 49 130 144
;
run;

/* proc sort data=study_data; */
/*     by Treatment; */
/* run; */


/* Step 2: Create Multiple Imputed Datasets (PROC MI) */
proc mi data=study_data
        out=mi_data
        nimpute=5
        seed=12345;
        var Treatment Age Baseline Outcome;
        fcs reg(Outcome = Treatment Age Baseline);
run;
           /* Creates 5 complete versions of the dataset.
              FCS REG performs regression-based imputation -- Missing Outcome values are filled using a regression model.
              The model uses Treatment, Age, and Baseline to predict Outcome.
              Each imputed dataset reflects uncertainty in the missing values.
              SAS adds a variable called _IMPUTATION_ to identify each dataset. */
             
             
             
/* Step 3: Sort Imputed Datasets by Imputation Number */
proc sort data=mi_data;
    by _Imputation_;
run;          
             /* Ensures each imputed dataset is processed independently*/
            



/* Step 4: Perform Pre-Specified Analysis on Each Imputed Dataset */
proc reg data=mi_data outest=reg_estimates covout;
    by _Imputation_;
    model Outcome = Treatment Age Baseline;
run;
quit;
                  /* The same model is run on each imputed dataset.
                  Estimates the relationship between Outcome and the predictors.
                  OUTEST= stores estimates in the exact format needed for pooling.
                  BY _IMPUTATION_ ensures the model is fit separately for each dataset. */



/* Step 5: Pool Results Across Imputations (PROC MIANALYZE) */

proc mianalyze data=reg_estimates;
    modeleffects Treatment Age Baseline;
run;
                 /* Combines results from all imputed datasets using Rubin’s Rules.
                    Produces: Final parameter estimates, Correct standard errors, Confidence intervals and p-values.
                    Properly accounts for uncertainty due to missing data. */