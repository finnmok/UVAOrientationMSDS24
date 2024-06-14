import pandas as pd
import matplotlib.pyplot as plt

# Load data
df = pd.read_csv(r'c:\Users\finnr\Downloads\MSDS-Orientation-Computer-Survey(in).csv')

# Binnable data histograms
for column in df.select_dtypes(include=['int64', 'float64']).columns:
    plt.hist(df[column], bins=30, edgecolor='black')
    plt.title(f'Histogram of {column}')
    plt.savefig(f'{column}_histogram.png')
    plt.close()

# Qualitative description for non-binnable features
qualitative_features = df.select_dtypes(include=['object']).columns
qualitative_summary = df[qualitative_features].describe(include=['object'])
qualitative_summary.to_csv('qualitative_summary.csv')
