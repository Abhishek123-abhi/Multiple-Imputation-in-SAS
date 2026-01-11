# Multiple-Imputation-in-SAS
## This repository provides a clear and practical introduction to Multiple Imputation in SAS, covering concepts, implementation using PROC MI and PROC MIANALYZE, and examples relevant to clinical and applied statistical analysis.

**Missing data is a common challenge in real-world datasets, particularly in clinical research, epidemiology, and observational studies. If not handled properly, missing values can reduce statistical power, introduce bias, and lead to misleading conclusions. Multiple imputation (MI) is a principled and widely accepted method for addressing this problem while preserving the integrity of statistical inference.**

## Impuatation Methods for Missing Data (Single vs Multiple):
**Single Imputation:** Single imputation is a simple approach to handling missing data in which each missing value is replaced with one fixed value, resulting in a single complete dataset. Common single imputation methods include mean or median substitution, last observation carried forward (LOCF), baseline observation carried forward (BOCF), and regression-based imputation.

While single imputation is easy to implement and interpret, it has important limitations. Because the imputed values are treated as if they were observed, this approach ignores uncertainty due to missing data, often leading to underestimated variability, biased standard errors, and overly optimistic statistical conclusions. For this reason, single imputation is generally considered suitable only for exploratory analyses or descriptive purposes and is not recommended for primary inferential analyses, especially in clinical research.

## Multiple Imputation:
Multiple imputation is a statistical technique in which each missing value is replaced not by a single estimate, but by a set of plausible values. This process results in multiple complete datasets, each reflecting uncertainty about the missing data. These datasets are analyzed separately, and the results are then combined to produce a single set of valid statistical inferences.

Unlike single imputation methods such as mean substitution or last observation carried forward, multiple imputation accounts for the variability introduced by missing data.

<img width="684" height="673" alt="A-schematic-illustration-of-multiple-imputation-33-with-m-5" src="https://github.com/user-attachments/assets/a9d195db-2fb5-4970-afd8-bc5ed6d017b3" />


**Why Multiple Imputation Is Preferred?**
Traditional single-value imputation methods tend to underestimate variability and can bias parameter estimates. Multiple imputation addresses these issues by:
- Preserving the original sample size
- Reducing bias caused by missing observations
- Producing valid standard errors and confidence intervals
- Reflecting uncertainty due to missing data


## Missing Data Mechanisms:
**Missing Completely at Random (MCAR):** Data are Missing Completely at Random when the probability of missingness is independent of both observed and unobserved data.
Implications:
- Complete-case analysis yields unbiased estimates
- Statistical power is reduced due to loss of data
- Rarely holds in practical research settings

**Missing at Random (MAR):** Data are Missing at Random when missingness depends only on observed data and not on the missing values themselves.
Implications:
- Most widely assumed mechanism in practice
- Supports modern methods such as multiple imputation
- Valid inference depends on including relevant covariates

**Missing Not at Random (MNAR):** Data are Missing at Random when missingness depends only on observed data and not on the missing values themselves.
Implications:
- Standard MAR-based methods may be biased
- Requires specialized modeling or sensitivity analyses
- Common in longitudinal and clinical trial data

**Multiple imputation typically relies on the Missing at Random (MAR) assumption. Under MAR, the probability that a value is missing depends only on observed data and not on the missing value itself. While this assumption cannot be tested directly, it is often reasonable in well-designed studies when relevant covariates are included in the imputation model.**

__The Three Steps of Multiple Imputation__

**1.Imputation:** Missing values are replaced multiple times to create several complete datasets. Each imputed value is drawn from a predictive distribution based on the observed data. In practice, 5 to 20 imputed datasets are commonly used.

**2.Analysis:** Each imputed dataset is analyzed using the same statistical model, such as a regression model, analysis of variance, or survival analysis. This ensures consistency across analyses.

**3.Pooling:** The results from all analyses are combined using Rubin’s Rules, which appropriately account for both within-dataset variability and variability between imputations. The final output includes pooled estimates, standard errors, confidence intervals, and p-values.


**Rubin's rule:** Rubin’s Rules work by averaging parameter estimates across all imputed datasets and then adjusting the variance to reflect uncertainty due to missing data. This adjustment is what makes multiple imputation statistically valid and superior to single imputation approaches.
