import numpy as np
import matplotlib.pyplot as plt

def plot_distribution(data, title, filename):
    plt.hist(data, bins=30, edgecolor='black')
    plt.title(title)
    plt.savefig(filename)
    plt.close()

# Binomial distribution
binom_data = np.random.binomial(n=100, p=0.5, size=100000)
plot_distribution(binom_data, 'Binomial Distribution', 'binomial.png')

# Poisson distribution
poisson_data = np.random.poisson(lam=5, size=100000)
plot_distribution(poisson_data, 'Poisson Distribution', 'poisson.png')

# Normal distribution
normal_data = np.random.normal(loc=0, scale=1, size=100000)
plot_distribution(normal_data, 'Normal Distribution', 'normal.png')

# Demonstrate convergence of Binomial to Normal
large_binom_data = np.random.binomial(n=1000, p=0.5, size=10000000)
plot_distribution(large_binom_data, 'Large Binomial Distribution', 'large_binomial.png')

# Demonstrate convergence of Normal to itself with large N
large_normal_data = np.random.normal(loc=0, scale=1, size=1000)
plot_distribution(large_normal_data, 'Large Normal Distribution', 'large_normal.png')
