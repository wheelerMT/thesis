import matplotlib.pyplot as plt
import numpy as np
import matplotlib

plt.rc("text.latex", preamble=r"\usepackage{fourier}")
plt.rcParams["text.usetex"] = True
plt.rcParams.update({"font.size": 16})
matplotlib.use("TkAgg")

gamma = [0.2, 0.3, 0.5, 0.6, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95]
exponent = [4.0, 3.8, 3.7, 3.6, 3.1, 2.7, 2.5, 2.0, 1.5, 1.4]

fig, ax = plt.subplots(1, figsize=(8, 3))
ax.set_ylabel(r'$z$')
ax.set_xlabel(r'$\gamma$')
ax.plot(gamma, exponent, 'kD')
plt.savefig('gfx/ch-twoCompDynamics/gamma_vs_expo.pdf', bbox_inches='tight')
plt.show()
