import re
import pandas as pd

data = pd.read_sas("data/OHXPER_H.xpt", format="xport")

complete = data[data["OHDPDSTS"] == 1].copy()

pocket_columns = [
    column
    for column in complete.columns
    if re.match(r"^OHX\d{2}PC[ADLMPS]$", column)
]

pocket_depths = complete[pocket_columns]
pocket_depths = pocket_depths.where(pocket_depths != 99)

valid_depths = pocket_depths.stack()
participant_max = pocket_depths.max(axis=1)

participants = len(complete)
valid_measurements = len(valid_depths)
mean_depth = valid_depths.mean()
deep_pocket_count = (participant_max >= 4).sum()
deep_pocket_percent = (deep_pocket_count / participant_max.notna().sum()) * 100

print("NHANES 2013-2014 Periodontal Examination")
print(f"Participants with complete periodontal exam: {participants}")
print(f"Valid pocket-depth measurements: {valid_measurements}")
print(f"Mean pocket depth (mm): {mean_depth:.2f}")
print(f"Participants with pocket depth >= 4 mm: {deep_pocket_count}")
print(f"Percentage with pocket depth >= 4 mm: {deep_pocket_percent:.2f}%")
