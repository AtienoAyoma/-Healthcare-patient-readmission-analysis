# Healthcare Patient Readmission & Data Quality Analysis

## Project summary
This project analyses the UCI Diabetes 130-US Hospitals dataset to demonstrate practical healthcare data-analysis skills using Python and SQL. The dataset represents hospital encounters from 130 US hospitals and integrated delivery networks during 1999–2008.

## Business questions
- What does the encounter population look like?
- How are readmissions distributed?
- How does length of stay vary by readmission outcome?
- How do readmission patterns vary across age groups and admission types?
- What data-quality and missing-value issues should an analyst consider?

## Tools
Python, Pandas, NumPy, Matplotlib, SQL, Jupyter

## Dataset
UCI Machine Learning Repository — Diabetes 130-US Hospitals for Years 1999-2008.

Official source: https://archive.ics.uci.edu/dataset/296/diabetes-130-us-hospitals-for-years-1999-2008

## How to run
1. Create a Python environment.
2. Install the packages in `requirements.txt`.
3. Open `notebooks/healthcare_analysis.ipynb`.
4. Run all cells using the included dataset in data/diabetes_data.csv.
5. Save 3–5 evidence-based findings in this README after running the analysis.

## Important data note
The source dataset contains demographic and clinical information and uses `?` as a missing-value marker in several fields. The analysis replaces this marker with null values for data-quality profiling.

## Portfolio skills demonstrated
- Healthcare data handling
- Data cleaning and validation
- Exploratory data analysis
- Missing-value analysis
- Grouped analysis and cross-tabulation
- Data visualisation
- SQL aggregation and conditional logic
- Communicating limitations and evidence
