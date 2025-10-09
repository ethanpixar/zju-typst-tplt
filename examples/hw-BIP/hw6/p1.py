import numpy as np
import matplotlib.pyplot as plt
import os

# Set working directory
script_dir = os.path.dirname(os.path.abspath(__file__))
os.chdir(script_dir)

# Set font for plots
plt.rcParams["font.family"] = ["SF Pro Display"]

# Define the image matrix
image = np.array([
    [3, 1, 0, 0, 2],
    [1, 0, 1, 1, 0],
    [0, 2, 0, 3, 1],
    [1, 2, 1, 0, 0],
    [0, 0, 2, 3, 1]
])

# Calculate histogram data
unique_values, counts = np.unique(image, return_counts=True)

# Create the histogram
plt.figure(figsize=(10, 6))
plt.bar(unique_values, counts, width=0.7, color='steelblue', edgecolor='black')
plt.xlabel('Pixel Value')
plt.ylabel('Frequency')
plt.title('Histogram of Image Matrix')
plt.xticks(unique_values)
plt.grid(axis='y', linestyle='--', alpha=0.7)

# Add count labels on top of each bar
for i, count in enumerate(counts):
    plt.text(unique_values[i], count + 0.1, str(count), ha='center')

# Calculate uniformity and entropy
total_pixels = image.size
probability = counts / total_pixels
uniformity = np.sum(probability**2)
entropy = -np.sum(probability * np.log2(probability))

# Display metrics on the plot
plt.figtext(0.15, 0.85, f'Uniformity: {uniformity:.4f}', fontsize=12)
plt.figtext(0.15, 0.80, f'Entropy: {entropy:.4f}', fontsize=12)

plt.tight_layout()
plt.show()

print(f"Histogram data:")
for value, count in zip(unique_values, counts):
    print(f"Pixel value {value}: {count} occurrences")
print(f"\nUniformity: {uniformity:.4f}")
print(f"Entropy: {entropy:.4f}")
