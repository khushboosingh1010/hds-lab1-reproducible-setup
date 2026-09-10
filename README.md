# Lab 1: Reproducible Periodontal Health Analysis

This project analyzes the public NHANES 2013-2014 Periodontal Examination dataset using both Python and R. The scripts calculate the number of participants with complete periodontal examinations, the number and mean of valid pocket-depth measurements, and the percentage of examined participants with at least one pocket depth of 4 mm or greater.

## Data

The public dataset is stored at `data/OHXPER_H.xpt`.

Source: CDC National Health and Nutrition Examination Survey, 2013-2014 Periodontal Examination.

https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/OHXPER_H.htm

The results are unweighted descriptive statistics for this laboratory exercise and should not be interpreted as national prevalence estimates.

## Requirements

Install the following tools:

- Git
- Miniforge with conda or mamba
- R and the `renv` package
- Docker Desktop

## Setup

Clone the repository and enter its directory:

```bash
git clone https://github.com/khushboosingh1010/hds-lab1-reproducible-setup.git
cd hds-lab1-reproducible-setup
```

### Python environment and analysis

Create the Python environment and run the analysis:

```bash
mamba env create -f environment.yml
mamba run -n nhanes-lab python scripts/analyze.py
```

### R environment and analysis

Restore the R environment and run the analysis:

```bash
Rscript -e 'install.packages("renv", repos="https://cloud.r-project.org")'
Rscript -e 'renv::restore(prompt = FALSE)'
Rscript scripts/analyze.R
```

## Docker

Start Docker Desktop, then build and run the container:

```bash
docker build -t hds-lab1-periodontal .
docker run --rm hds-lab1-periodontal
```

The Docker output should match the native Python and R output.

## Expected output

```text
NHANES 2013-2014 Periodontal Examination
Participants with complete periodontal exam: 3982
Valid pocket-depth measurements: 487775
Mean pocket depth (mm): 1.37
Participants with pocket depth >= 4 mm: 1315
Percentage with pocket depth >= 4 mm: 36.36%
```

## Conda and renv comparison

Conda manages the Python interpreter and Python packages through `environment.yml`, while renv manages R packages for one R project through `renv.lock`. Conda was easier for creating a complete named environment, but exporting only requested dependencies required the `--from-history` option. Renv recorded more exact package versions, although project activation and private library paths made its workflow more fragile. Fornguage environment clearly.
