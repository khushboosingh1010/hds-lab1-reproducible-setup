FROM condaforge/miniforge3:latest
WORKDIR /workspace
COPY environment.yml .
RUN mamba env create -f environment.yml && mamba clean --all --yes
COPY data/ data/
COPY scripts/analyze.py scripts/analyze.py
CMD ["conda", "run", "--no-capture-output", "-n", "nhanes-lab", "python", "scripts/analyze.py"]
